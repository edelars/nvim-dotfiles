local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		config = function()
			require("todo-comments").setup()
		end,

		keys = {
			{
				"<leader>ft",
				":TodoTelescope<CR>",
				desc = "Search through all project TODOs",
				mode = "n",
				noremap = true,
				silent = true,
			},
		},
	},

	{
		"scalameta/nvim-metals",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
		},
		ft = { "scala", "sbt", "java" },
		opts = function()
			local metals_config = require("metals").bare_config()

			metals_config.settings = {
				showImplicitArguments = true,
				excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
			}
			metals_config.init_options.statusBarProvider = "off"
			metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
			metals_config.on_attach = function(client, bufnr)
				require("metals").setup_dap()
			end

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"mhartington/formatter.nvim",
		lazy = true,
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "lua" },
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		opts = {}, -- your configuration
	},
	{ "rrethy/vim-illuminate" },
	{ "ahmedkhalf/project.nvim", lazy = true },
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},
	{
		"maxandron/goplements.nvim",
		ft = "go",
		lazy = true,
		opts = {},
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"dgagn/diagflow.nvim",
		-- event = 'LspAttach', This is what I use personnally and it works great
		opts = {},
	},
	{ "neovim/nvim-lspconfig", lazy = false },
	{ "bloznelis/before.nvim" },
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
	},
	{ "windwp/nvim-autopairs" },
	{ "AckslD/nvim-neoclip.lua", lazy = false },
	{ "lewis6991/gitsigns.nvim" },
	{ "ray-x/lsp_signature.nvim" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp", dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	} },
	{ "terrortylor/nvim-comment" },
	-- {'sainnhe/gruvbox-material'},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "folke/which-key.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
	},

	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap",
		},
		config = function()
			-- vim.keymap.set("n", "<leader>zt", ":GoAddTest<CR>", { desc = "Add test for function" })
			-- vim.keymap.set("n", "<leader>zf", ":GoFillStruct<CR>", { desc = "Fill struct" })
			-- vim.keymap.set("n", "<leader>zr", ":GoGenReturn:<CR>", { desc = "Generate return value" })
			-- vim.keymap.set("n", "<leader>zb", ":GoAddTag<CR>", { desc = "Add tags for struct" })
			-- vim.keymap.set("n", "<leader>zn", ":GoRmTag<CR>", { desc = "Remove all tags for struct" })
			require("go").setup({
				verbose = false,
				lsp_semantic_highlights = true, -- use highlights from gopls
			})
		end,
		-- event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		lazy = true,
		keys = {
			{
				"<leader>zt",
				":GoAddTest<CR>",
				desc = "Add test for function",
				mode = "n",
				noremap = true,
				silent = true,
			},
			{
				"<leader>zf",
				":GoFillStruct<CR>",
				desc = "Fill struct",
				mode = "n",
				noremap = true,
				silent = true,
			},
			{
				"<leader>zb",
				":GoAddTag<CR>",
				desc = "Add tags for struct",
				mode = "n",
				noremap = true,
				silent = true,
			},
			{
				"<leader>zn",
				":GoRmTag<CR>",
				desc = "Remove all tags for struct",
				mode = "n",
				noremap = true,
				silent = true,
			},
		},

		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{ "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"linrongbin16/lsp-progress.nvim",
		},
	},
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{
		"linrongbin16/lsp-progress.nvim",
		event = { "VimEnter" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lsp-progress").setup()
		end,
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = false,
		dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
		keys = {
			{
				"<leader><leader>;",
				function()
					require("luasnip").jump(1)
				end,
				desc = "Jump forward a snippet placement",
				mode = "i",
				noremap = true,
				silent = true,
			},
			{
				"<leader><leader>,",
				function()
					require("luasnip").jump(-1)
				end,
				desc = "Jump backward a snippet placement",
				mode = "i",
				noremap = true,
				silent = true,
			},
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.snippets" } })
			require("luasnip.loaders.from_lua").load({ paths = "~/.snippets" })
		end,
	},
	-- Hop (Better Navigation)
	{
		"phaazon/hop.nvim",
		lazy = true,
	},
})
