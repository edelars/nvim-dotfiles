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
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"mhartington/formatter.nvim",
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
	{ "lvimuser/lsp-inlayhints.nvim" },
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
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
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
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load({ paths = "~/.snippets" })
		end,
	},
	-- Hop (Better Navigation)
	{
		"phaazon/hop.nvim",
		lazy = true,
	},
})
