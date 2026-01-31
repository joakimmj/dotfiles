require("my.theme")
require("my.mappings")
require("my.options")
require("my.autocmd")

local use_lazy_packages, _ = pcall(require, "my.init-lazy")
if not use_lazy_packages then
    vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
    vim.g.netrw_liststyle=3
    vim.g.netrw_browse_split = 0
    vim.g.netrw_banner = 0
    vim.g.netrw_winsize = 25

    vim.keymap.set("n", "<leader>we", ":Lex<CR>", { desc = "[e]xplorer" })
    vim.keymap.set("n", "<leader>wg", [[:vimgrep //j ** | copen<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]], { desc = "[g]rep" })
    vim.keymap.set("n", "<leader>wf", ":Lex<CR>", { desc = "[f]iles" })
    vim.keymap.set("n", "<leader><space>", ":ls<CR>:b<Space>", { desc = "[ ] find existing buffers" })
    vim.keymap.set("n", "<leader>sw", [[:execute "vimgrep /" . expand("<cword>") . "/j **" | cw<CR>]], { desc = "current [w]ord" })
end
