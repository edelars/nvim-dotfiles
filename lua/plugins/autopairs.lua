require("nvim-autopairs").setup({
	check_ts = true,
	enable_check_bracket_line = false,
	map_bs = false,
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
