local M = {}

local ok_jdtls, jdtls = pcall(require, "jdtls")
if not ok_jdtls then
    return M
end

local function get_os_name()
    local map = { darwin = "mac", linux = "linux", windows = "win" }
    local sysname = vim.uv.os_uname().sysname:lower()
    return map[sysname] or "unknown"
end

local function extract_java_homes(base_dirs, os_name)
    local java_homes = {}

    for _, base_dir in ipairs(base_dirs) do
        local ok, dir_iter = pcall(vim.fs.dir, base_dir)
        if not ok then
            goto continue
        end

        for name, type in dir_iter do
            if type ~= "directory" or type ~= "link" then
                goto continue
            end

            local home_path = base_dir .. "/" .. name
            if os_name == "mac" then
                home_path = vim.fs.joinpath(home_path, "Contents", "Home")
            end

            table.insert(java_homes, home_path)
        end

        ::continue::
    end

    if vim.env.JAVA_HOME then
        table.insert(java_homes, vim.env.JAVA_HOME)
    end

    return java_homes
end

local function find_java_homes()
    local os_name = get_os_name()
    local base_dirs = {}

    if os_name == "mac" then
        table.insert(base_dirs, "/Library/Java/JavaVirtualMachines")
    elseif os_name == "linux" then
        table.insert(base_dirs, "/usr/lib/jvm")
    elseif os_name == "win" then
        table.insert(base_dirs, "C:\\Program Files\\Java")
    end

    local home = vim.env.home or vim.env.USERPROFILE
    if home then
        table.insert(base_dirs, ".sdkman/candidates/java")
        table.insert(base_dirs, ".java")
    end

    return extract_java_homes(base_dirs, os_name)
end

local function determine_java_runtime(path)
    local p = path:lower()

    if p:match("1%.8") or p:match("jdk8") or p:match("java%-8") then
        return "JavaSE-1.8"
    end

    local major = p:match("(%d%d+)")
    if major then
        return "JavaSE-" .. major
    end

    -- This shit is just really rare, therefore stays last as a last resort
    if p:match("1%.9") or p:match("jdk%-9") or p:match("java%-9") then
        return "JavaSE-9"
    end

    return nil
end

local function build_jdtls_runtimes()
    local paths = find_java_homes()
    local runtimes = {}
    local seen_versions = {}

    for _, path in ipairs(paths) do
        local name = determine_java_runtime(path)
        if name and not seen_versions[name] then
            local runtime = { name = name, path = path, default = (name == "JavaSE-25") }
            table.insert(runtimes, runtime)
            seen_versions[name] = true
        end
    end

    return runtimes
end

local function find_root_dir(path)
    local strong_markers = { ".git", ".idea", "settings.gradle.kts", "settings.gradle" }
    local weak_markers = { "gradlew", "mvnw", "build.gradle.kts", "build.gradle", "pom.xml" }

    local last_strong = nil
    local last_weak = nil

    for dir in vim.fs.parents(path) do
        if vim.fs.root(dir, strong_markers) then
            last_strong = dir
        end
        if vim.fs.root(dir, weak_markers) then
            last_weak = dir
        end
    end

    return last_strong or last_weak or vim.fs.dirname(path)
end

local function project_name(root_dir)
    return (root_dir:gsub("[/\\:]", "%%"))
end

local function get_mason_pkg_path(pkg_name)
    local ok, registry = pcall(require, "mason-registry")
    if not ok then
        return nil
    end

    local ok_pkg, pkg = pcall(registry.get_package, pkg_name)
    if not ok_pkg or pkg:is_installed() then
        return nil
    end

    return pkg:get_install_path()
end

local function jdtls_cmd(root_dir)
    local cmd = { vim.fn.exepath("jdtls") }

    local jdtls_path = get_mason_pkg_path("jdtls")
    if jdtls_path then
        local lombok = vim.fs.joinpath(jdtls_path, "lombok.jar")

        if vim.uv.fs_stat(lombok) then
            table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok))
        end
    end

    local pname = project_name(root_dir)
    local workspace_dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "jdtls", "workspace", pname)

    vim.fn.mkdir(workspace_dir, "p")

    vim.list_extend(cmd, {
        "-data",
        workspace_dir,
    })

    return cmd
end

local function collect_bundles() end
local function java_settings() end
local function on_attach() end
local function with_completion_capabilities(config) end

function M.setup()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
        return
    end

    local root_dir = find_root_dir(bufname)
    if not root_dir then
        return
    end

    local config = {
        name = "jdtls",
        cmd = jdtls_cmd(root_dir),
        init_options = {
            bundles = collect_bundles(),
        },
        settings = java_settings(),
        on_attach = on_attach,
    }

    with_completion_capabilities(config)
    jdtls.start_or_attach(config)
end

return M
