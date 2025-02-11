return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		signs_staged = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		signs_staged_enable = true,
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Jump to next git [c]hange" })

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Jump to previous git [c]hange" })

			-- visual mode
			map("v", "<leader>va", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [a]dd selection" })
			map("v", "<leader>vr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [r]eset selection" })

			-- normal mode
			map("n", "<leader>va", gitsigns.stage_hunk, { desc = "git [a]dd hunk" })
			map("n", "<leader>vr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
			map("n", "<leader>vA", gitsigns.stage_buffer, { desc = "git [A]dd buffer" })
			map("n", "<leader>vu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
			map("n", "<leader>vR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
			map("n", "<leader>vp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
			map("n", "<leader>vb", gitsigns.blame_line, { desc = "git [b]lame line" })
			map("n", "<leader>vtb", gitsigns.toggle_current_line_blame, { desc = "show [b]lame line" })
		end,
	},
}
