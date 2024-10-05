-- local before = require('before')

require("before").setup({
	-- How many edit locations to store in memory (default: 10)
	history_size = 42,
	-- Should it wrap around the ends of the edit history (default: false)
	history_wrap_enabled = true,
})
