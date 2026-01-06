-- ~/.config/nvim/lua/plugins/lsp.lua
return {
    -- 1. DISABLE DEFAULT SETUP
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            opts.setup = opts.setup or {}
            opts.setup.jdtls = function()
                return true
            end
        end,
    },

    -- 2. GLOBAL KEYMAPS (The "Never-Fail" Method)
    -- This runs whenever ANY LSP attaches to a buffer
    {
        "neovim/nvim-lspconfig",
        init = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local bufnr = ev.buf
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- Only apply these to JDTLS (or any Java file)
                    if client.name == "jdtls" then
                        local bufmap = function(mode, lhs, rhs, desc)
                            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                        end

                        -- JDTLS Specific Commands
                        require("jdtls").setup_dap({ hotcodereplace = "auto" })

                        -- Standard Navigation
                        bufmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
                        bufmap("n", "gr", vim.lsp.buf.references, "Go to References")
                        bufmap("n", "K", vim.lsp.buf.hover, "Hover Documentation")
                        bufmap("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
                        bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    end
                end,
            })
        end,
    },

    -- 3. JDTLS ENGINE
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            local home = os.getenv("HOME")
            local current_bin = "/home/dmitrbar/.jdks/current/bin/java"
            local project_jdk = os.getenv("JAVA_HOME")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
            local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
            local config_path = mason_path .. "/config_linux"
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

            local config = {
                cmd = {
                    current_bin,
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xmx1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens",
                    "java.base/java.util=ALL-UNNAMED",
                    "--add-opens",
                    "java.base/java.lang=ALL-UNNAMED",
                    "-jar",
                    launcher_jar,
                    "-configuration",
                    config_path,
                    "-data",
                    workspace_dir,
                },
                capabilities = capabilities,
                root_dir = require("jdtls.setup").find_root({
                    ".git",
                    "gradlew",
                    "mvnw",
                    ".project",
                    ".classpath",
                    "src",
                }),
                settings = {
                    java = {
                        configuration = {
                            runtimes = {
                                { name = "JavaSE-1.8", path = project_jdk },
                                { name = "JavaSE-21", path = "/usr/lib/jvm/default-java" },
                                { name = "JavaSE-25", path = "/home/dmitrbar/.jdks/current", default = true },
                            },
                        },
                    },
                },
            }
            require("jdtls").start_or_attach(config)
        end,
    },
}
