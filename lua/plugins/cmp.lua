local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
		-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
		["<S-Space>"] = cmp.mapping.complete(),
		-- ['<C-e>'] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	matching = {
		disallow_fuzzy_matching = true,
		disallow_fullfuzzy_matching = true,
		disallow_partial_fuzzy_matching = true,
		disallow_partial_matching = false,
		disallow_prefix_unmatching = true,
	},
	sources = cmp.config.sources({
		{ name = "luasnip", score = 45 },
		{ name = "nvim_lsp", keyword_length = 1, score = 40 },
		{ name = "nvim_lsp_signature_help", score = 35 },
         -- { name = "vsnip" },
		{ name = "path" },
		{ name = "buffer", score = 20 },
		-- { name = "nvim_lua" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, { { name = "buffer" } }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig")["ts_ls"].setup({ capabilities = capabilities })
