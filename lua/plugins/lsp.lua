local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- Sntup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.prismals.setup {}
lspconfig.cssls.setup {
    capabilities = capabilities
}
lspconfig.gopls.setup({
        on_attach = function(client, bufnr)
                    require("shared/lsp")(client, bufnr)
                    require("lsp-inlayhints").setup({
                        inlay_hints = {type_hints = {prefix = "=> "}}
                    })
                    require("lsp-inlayhints").on_attach(client, bufnr)
                    require("illuminate").on_attach(client)

                    vim.api.nvim_create_autocmd({"BufWritePost"}, {
                        group = vim.api.nvim_create_augroup("FixGoImports",
                                                            {clear = true}),
                        pattern = "*.go",
                        callback = function()
                            -- ensure imports are sorted and grouped correctly
                            local params = vim.lsp.util.make_range_params()
                            params.context = {only = {"source.organizeImports"}}
                            local result =
                                vim.lsp.buf_request_sync(0,
                                                         "textDocument/codeAction",
                                                         params)
                            for _, res in pairs(result or {}) do
                                for _, r in pairs(res.result or {}) do
                                    if r.edit then
                                        vim.lsp.util.apply_workspace_edit(
                                            r.edit, "UTF-8")
                                    else
                                        vim.lsp.buf.execute_command(r.command)
                                    end
                                end
                            end
                        end
                    })

                    vim.keymap.set("n", "<leader><leader>lv",
                                   "<Cmd>cex system('revive -exclude vendor/... ./...') | cwindow<CR>",
                                   {
                        noremap = true,
                        silent = true,
                        buffer = bufnr,
                        desc = "lint project code (revive)"
                    })
                end,
                settings = {
                    -- https://go.googlesource.com/vscode-go/+/HEAD/docs/settings.md#settings-for
                    gopls = {
                        analyses = {
                            nilness = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true
                        },
                        experimentalPostfixCompletions = true,
                        gofumpt = true,
                        -- staticcheck = true,
                        --
                        -- DISABLED because gopls doesn't invoke the staticcheck binary.
                        -- Instead it imports the analyzers directly and this means it can report on issues the binary doesn't.
                        -- But rather than that being a good thing, it can be annoying because you can't then use line directives to ignore the issue if it's not important.
                        -- So instead I use null-ls to invoke the staticcheck binary.
                        -- https://github.com/golang/go/issues/36373#issuecomment-570643870
                        --
                        -- See also my longer explanation of issues here:
                        -- https://github.com/golangci/golangci-lint/issues/741#issuecomment-1488116634
                        usePlaceholders = true,
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true
                        }
                    }
                }
                -- DISABLED: as it overlaps with `lvimuser/lsp-inlayhints.nvim`
                -- init_options = {
                  -- usePlaceholders = true,
                -- }
            }
            )
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
    },
  },
}
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>lD', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = {buffer = ev.buf}
        -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        -- vim.keymap
        --     .set('n', '<Leader>sa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<Leader>sr', vim.lsp.buf.remove_workspace_folder,
        --                opts)
        -- vim.keymap.set('n', '<Leader>sl', function()
        --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
        -- vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<Leader>la', vim.lsp.buf.code_action, opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<Leader>lf',
                       function() vim.lsp.buf.format {async = true} end, opts)
    end
})
