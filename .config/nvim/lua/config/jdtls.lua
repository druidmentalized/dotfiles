local M = {}

local classpath_generator = require("utils.classpath-generator")
local gen_utils = require("utils.general")

local ok_jdtls, jdtls = pcall(require, "jdtls")
if not ok_jdtls then return M end

local function is_java_vendor(dir_name)
    local vendors = { "java", "openjdk", "temurin", "coretto", "zulu", "liberica", "sapmachine", "graalvm" }

    dir_name = dir_name:lower()

    for _, vendor in ipairs(vendors) do
        if dir_name:find(vendor, 1, true) then return true end
    end

    return false
end

local function extract_java_homes(base_dirs, os_name)
    local java_homes = {}

    for _, base_dir in ipairs(base_dirs) do
        local ok, dir_iter = pcall(vim.fs.dir, base_dir)
        if not ok then goto continue_outer end

        for name, type in dir_iter do
            if (type ~= "directory" and type ~= "link") or not is_java_vendor(name) then goto continue_inner end

            local home_path = base_dir .. "/" .. name
            if os_name == "mac" then home_path = vim.fs.joinpath(home_path, "Contents", "Home") end

            table.insert(java_homes, home_path)
            ::continue_inner::
        end

        ::continue_outer::
    end

    if vim.env.JAVA_HOME then table.insert(java_homes, vim.env.JAVA_HOME) end

    return java_homes
end

local function find_java_homes()
    local os_name = gen_utils.get_os_name()
    local base_dirs = {}

    if os_name == "mac" then
        table.insert(base_dirs, "/Library/Java/JavaVirtualMachines")
    elseif os_name == "linux" then
        table.insert(base_dirs, "/usr/lib/jvm")
    elseif os_name == "win" then
        table.insert(base_dirs, "C:\\Program Files\\Java")
    end

    local home = vim.env.HOME or vim.env.USERPROFILE

    if home then
        table.insert(base_dirs, vim.fs.joinpath(home, ".sdkman/candidates/java"))
        table.insert(base_dirs, vim.fs.joinpath(home, ".java"))
        table.insert(base_dirs, vim.fs.joinpath(home, ".jdks"))
    end

    return extract_java_homes(base_dirs, os_name)
end

local function determine_java_runtime(path)
    local p = path:lower()

    if p:match("1%.8") or p:match("jdk8") or p:match("java%-8") then return "JavaSE-1.8" end

    local major = p:match("(%d%d+)")
    if major then return "JavaSE-" .. major end

    -- This shit is just really rare, therefore stays last as a last resort
    if p:match("1%.9") or p:match("jdk%-9") or p:match("java%-9") then return "JavaSE-9" end

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
    local tools_markers =
        { "settings.gradle.kts", "settings.gradle", "gradlew", "mvnw", "build.gradle.kts", "build.gradle", "pom.xml" }
    local general_markers = { ".git", ".idea" }

    local last_tool = nil
    local last_general = nil

    if gen_utils.contains_in_dir(path, tools_markers) then last_tool = path end
    if gen_utils.contains_in_dir(path, general_markers) then last_general = path end

    for dir in vim.fs.parents(path) do
        if gen_utils.contains_in_dir(dir, tools_markers) then last_tool = dir end
        if gen_utils.contains_in_dir(dir, general_markers) then last_general = dir end
    end

    if last_tool then return last_tool end

    if last_general then
        classpath_generator.generate(last_general)
        return last_general
    end

    return vim.fs.dirname(path)
end

local function get_mason_pkg_path(pkg_name)
    local ok, registry = pcall(require, "mason-registry")
    if not ok then return nil end

    local ok_pkg, pkg = pcall(registry.get_package, pkg_name)
    if not ok_pkg or not pkg:is_installed() then return nil end

    local mason_root = require("mason.settings").current.install_root_dir
    return vim.fs.joinpath(mason_root, "packages", pkg_name)
end

local function jdtls_cmd(root_dir)
    local cmd = { vim.fn.exepath("jdtls") }

    vim.list_extend(cmd, {
        "--jvm-arg=-Xms2g",
        "--jvm-arg=-Xmx12g",
        "--jvm-arg=-XX:+UseG1GC",
        "--jvm-arg=-XX:+UseStringDeduplication",
    })

    local jdtls_path = get_mason_pkg_path("jdtls")
    if jdtls_path then
        local lombok = vim.fs.joinpath(jdtls_path, "lombok.jar")

        if vim.uv.fs_stat(lombok) then table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok)) end
    end

    local pname = gen_utils.project_name(root_dir)
    local workspace_dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "jdtls", "workspace", pname)

    vim.fn.mkdir(workspace_dir, "p")

    vim.list_extend(cmd, {
        "-data",
        workspace_dir,
    })

    return cmd
end

local function collect_bundles()
    local bundles = {}

    local debug_path = get_mason_pkg_path("java-debug-adapter")
        .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
    local debug_jars = vim.fn.glob(debug_path, false, true)
    vim.list_extend(bundles, debug_jars)

    local test_path = get_mason_pkg_path("java-test") .. "/extension/server/*.jar"
    local test_jars = vim.fn.glob(test_path, false, true)
    vim.list_extend(bundles, test_jars)

    return vim.tbl_filter(function(x) return x and x ~= "" end, bundles)
end

local function java_settings()
    return {
        java = {
            autobuild = {
                enabled = false,
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
            signatureHelp = {
                enabled = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = build_jdtls_runtimes(),
            },
            references = {
                includeDecompiledSources = true,
            },
            implementationCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "literals",
                },
            },
            format = {
                enabled = true,
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
            completion = {
                favoriteStaticMembers = {
                    "org.junit.jupiter.api.Assertions.*",
                    "org.mockito.Mockito.*",
                    "java.util.Objects.requireNonNull",
                },
                importOrder = { "java", "javax", "com", "org" },
            },
        },
    }
end

local function on_attach(client, buffer)
    local opts = { buffer = buffer, silent = true }

    vim.keymap.set(
        "n",
        "<leader>co",
        jdtls.organize_imports,
        vim.tbl_extend("force", opts, { desc = "Organize Imports" })
    )
    vim.keymap.set(
        "n",
        "<leader>cgs",
        jdtls.super_implementation,
        vim.tbl_extend("force", opts, { desc = "Goto Super" })
    )
    vim.keymap.set(
        "n",
        "<leader>cxv",
        jdtls.extract_variable_all,
        vim.tbl_extend("force", opts, { desc = "Extract Variable" })
    )
    vim.keymap.set(
        "n",
        "<leader>cxc",
        jdtls.extract_constant,
        vim.tbl_extend("force", opts, { desc = "Extract Constant" })
    )
    vim.keymap.set(
        "x",
        "<leader>cxm",
        function() jdtls.extract_method(true) end,
        vim.tbl_extend("force", opts, { desc = "Extract Method" })
    )
    vim.keymap.set(
        "x",
        "<leader>cxv",
        function() jdtls.extract_variable_all(true) end,
        vim.tbl_extend("force", opts, { desc = "Extract Variable" })
    )
    vim.keymap.set(
        "x",
        "<leader>cxc",
        function() jdtls.extract_constant(true) end,
        vim.tbl_extend("force", opts, { desc = "Extract Constant" })
    )

    local has_dap, _ = pcall(require, "dap")
    if has_dap then
        require("jdtls").setup_dap({ hotcodereplace = "auto" })

        vim.keymap.set(
            "n",
            "<leader>tt",
            function() require("jdtls.dap").test_class() end,
            vim.tbl_extend("force", opts, { desc = "Run Java Test Class" })
        )

        vim.keymap.set(
            "n",
            "<leader>tr",
            function() require("jdtls.dap").test_nearest_method() end,
            vim.tbl_extend("force", opts, { desc = "Run Nearest Java Test" })
        )
    end
end

local function with_completion_capabilities(config)
    local capabilities = config.capabilities or vim.lsp.protocol.make_client_capabilities()

    local ok_blink, blink = pcall(require, "blink.cmp")
    if ok_blink then
        config.capabilities = blink.get_lsp_capabilities(capabilities)
        return
    end

    local ok_cmp, cmp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
        config.capabilities = cmp.default_capabilities(capabilities)
        return
    end
end

function M.setup()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then return end

    local root_dir = find_root_dir(bufname)
    if not root_dir then return end

    local clients = vim.lsp.get_clients({ name = "jdtls" })
    for _, client in ipairs(clients) do
        if client.config.root_dir == root_dir then
            vim.lsp.buf_attach_client(0, client.id)
            return
        end
    end

    local config = {
        name = "jdtls",
        root_dir = root_dir,
        cmd = jdtls_cmd(root_dir),
        init_options = {
            bundles = collect_bundles(),
        },
        settings = java_settings(),
        on_attach = on_attach,
    }

    with_completion_capabilities(config)
    require("jdtls").start_or_attach(config)
end

return M
