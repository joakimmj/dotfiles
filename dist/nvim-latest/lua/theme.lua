-- vim.pack.add({
--     { src = "https://github.com/folke/tokyonight.nvim" },
-- })
--
-- local Theme = require("tokyonight")
-- Theme.setup({
--     on_colors = function(colors)
-- 	colors.bg = "#2E3434"
-- 	colors.comment = "#577466"
-- 	colors.fg_gutter = "#577466"
-- 	colors.bg_statusline = "#374641"
-- 	colors.fg_sidebar = "#374641"
-- 	colors.bg_sidebar = "#2E3434"
--     end,
-- })
--
-- -- Set colorscheme
-- vim.cmd.colorscheme("tokyonight-night")
--
-- -- Configure highlights
-- vim.cmd.hi("ColorColumn guibg=#374641")
local redox = {
    bg = "#2E3434",
    bg_alt = "#343A3A",
    surface = "#3A4141",
    overlay = "#414949",
    fg = "#DCE8E5",
    muted = "#AFC3BE",
    subtle = "#919D9B",
    rust = "#CD8B64",
    orange = "#E3A36F",
    teal = "#7EC1AE",
    sea = "#9FD8C4",
    cyan = "#8FC7B7",
    amber = "#D6C38A",
    red = "#CD8980",
    warn = "#E3B86F",
    info = "#8EC6C4",
    hint = "#98C3B1",
    cursor = "#FFD7A0",
    selection = "#3F4A4A",
}
vim.opt.termguicolors = true
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "redox"
vim.api.nvim_set_hl(0, "Normal", { fg = redox.fg, bg = redox.bg })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = redox.fg, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = redox.overlay, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "LineNr", { fg = redox.subtle, bg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#323838" })
vim.api.nvim_set_hl(0, "CursorColumn", { link = "CursorLine" })
vim.api.nvim_set_hl(0, "ColorColumn", { link = "CursorLine" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = redox.orange, bold = true })
vim.api.nvim_set_hl(0, "StatusLine", { fg = redox.bg, bg = redox.orange, bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = redox.muted, bg = redox.surface })
vim.api.nvim_set_hl(0, "TabLine", { link = "StatusLineNC" })
vim.api.nvim_set_hl(0, "TabLineSel", { link = "StatusLine" })
vim.api.nvim_set_hl(0, "TabLineFill", { link = "Normal" })
vim.api.nvim_set_hl(0, "VertSplit", { fg = redox.overlay })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = redox.overlay })
vim.api.nvim_set_hl(0, "Visual", { bg = redox.selection })
vim.api.nvim_set_hl(0, "Pmenu", { fg = redox.fg, bg = redox.surface })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = redox.bg, bg = redox.orange })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = redox.surface })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = redox.overlay })
vim.api.nvim_set_hl(0, "Search", { fg = redox.bg, bg = redox.teal })
vim.api.nvim_set_hl(0, "IncSearch", { fg = redox.bg, bg = redox.rust })
vim.api.nvim_set_hl(0, "CurSearch", { fg = redox.bg, bg = redox.rust })
vim.api.nvim_set_hl(0, "MatchParen", { fg = redox.orange, underline = true })
vim.api.nvim_set_hl(0, "NonText", { fg = redox.subtle })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = redox.overlay })
vim.api.nvim_set_hl(0, "Whitespace", { fg = redox.overlay })
vim.api.nvim_set_hl(0, "SignColumn", { fg = redox.muted, bg = redox.bg })
vim.api.nvim_set_hl(0, "Folded", { fg = redox.muted, bg = redox.surface })
vim.api.nvim_set_hl(0, "FoldColumn", { fg = redox.subtle, bg = redox.bg })
vim.api.nvim_set_hl(0, "Title", { fg = redox.orange, bold = true, underline = true })
vim.api.nvim_set_hl(0, "Directory", { fg = redox.teal })
vim.api.nvim_set_hl(0, "WildMenu", { link = "PmenuSel" })
vim.api.nvim_set_hl(0, "ModeMsg", { link = "Normal" })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = redox.teal })
vim.api.nvim_set_hl(0, "ErrorMsg", { link = "DiagnosticError" })
vim.api.nvim_set_hl(0, "WarningMsg", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "@comment", { fg = redox.subtle, italic = true })
vim.api.nvim_set_hl(0, "Todo", { bg = redox.hint, fg = redox.bg, bold = true })
vim.api.nvim_set_hl(0, "@comment.todo", { link = "Todo" })
vim.api.nvim_set_hl(0, "@keyword", { fg = redox.orange, bold = true })
vim.api.nvim_set_hl(0, "@conditional", { fg = redox.orange })
vim.api.nvim_set_hl(0, "@function", { fg = redox.teal })
vim.api.nvim_set_hl(0, "@method", { link = "@function" })
vim.api.nvim_set_hl(0, "@type", { fg = redox.amber })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = redox.amber })
vim.api.nvim_set_hl(0, "@constant", { fg = redox.amber })
vim.api.nvim_set_hl(0, "@string", { fg = redox.sea })
vim.api.nvim_set_hl(0, "@number", { link = "@constant" })
vim.api.nvim_set_hl(0, "@boolean", { link = "@constant" })
vim.api.nvim_set_hl(0, "@operator", { fg = "#C9D4D2" })
vim.api.nvim_set_hl(0, "@field", { fg = "#CFE3DE" })
vim.api.nvim_set_hl(0, "@property", { link = "@field" })
vim.api.nvim_set_hl(0, "@variable", { fg = redox.fg })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#E6D4A3" })
vim.api.nvim_set_hl(0, "@variable.member", { link = "@type.builtin" })
vim.api.nvim_set_hl(0, "@attribute", { link = "@function" })
vim.api.nvim_set_hl(0, "@markup.heading",   { fg = redox.orange, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.1", { fg = redox.orange, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.2", { fg = redox.rust, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.3", { fg = redox.teal, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.4", { fg = redox.amber, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.5", { fg = redox.cyan, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.6", { fg = redox.sea, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = redox.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = redox.warn })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = redox.info })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = redox.hint })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = redox.red, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = redox.warn, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = redox.info, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = redox.hint, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = redox.red })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = redox.warn })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = redox.info })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = redox.hint })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#4A5353" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = redox.subtle, bg = redox.bg_alt, italic = true })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = redox.selection, bold = true })
vim.api.nvim_set_hl(0, "LspCodeLens", { fg = redox.subtle })
vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = redox.overlay, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#33403B" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#403F30" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#4A3333" })
vim.api.nvim_set_hl(0, "DiffText", { bg = redox.orange })
vim.api.nvim_set_hl(0, "diffAdded", { bg = "#33403B", fg = "#449dab" })
vim.api.nvim_set_hl(0, "diffRemoved", { bg = "#4A3333", fg = "#914c54" })
vim.api.nvim_set_hl(0, "diffChanged", { bg = "#403F30", fg = "#6183bb" })
vim.api.nvim_set_hl(0, "diffOldFile", { fg = redox.orange, bg = "#4A3333" })
vim.api.nvim_set_hl(0, "diffNewFile", { fg = redox.orange, bg = "#33403B" })
vim.api.nvim_set_hl(0, "diffFile", { fg = redox.teal })
vim.api.nvim_set_hl(0, "diffLine", { fg = redox.subtle })
vim.api.nvim_set_hl(0, "diffIndexLine", { fg = redox.cyan })
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = redox.teal })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = redox.amber })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = redox.red })
vim.api.nvim_set_hl(0, "QFFileName", { fg = redox.teal })
vim.api.nvim_set_hl(0, "QuickFixLine", { fg = redox.bg, bg = redox.orange })
vim.api.nvim_set_hl(0, "@lsp.type.class", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.struct", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.interface", { link = "@function" })
vim.api.nvim_set_hl(0, "@lsp.type.enum", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.enumMember", { link = "@constant" })
vim.api.nvim_set_hl(0, "@lsp.type.type", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.typeParameter", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.union", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.function", { link = "@function" })
vim.api.nvim_set_hl(0, "@lsp.type.method", { link = "@method" })
vim.api.nvim_set_hl(0, "@lsp.type.macro", { link = "@function" })
vim.api.nvim_set_hl(0, "@lsp.type.constructor", { link = "@function" })
vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "@variable" })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { link = "@variable" })
vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@type.builtin" })
vim.api.nvim_set_hl(0, "@lsp.type.field", { link = "@field" })
vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "@variable" })
vim.api.nvim_set_hl(0, "@lsp.type.package", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.number", { link = "@constant" })
vim.api.nvim_set_hl(0, "@lsp.type.boolean", { link = "@constant" })
vim.api.nvim_set_hl(0, "@lsp.type.string", { link = "@string" })
vim.api.nvim_set_hl(0, "@lsp.type.escapeSequence", { link = "@string" })
vim.api.nvim_set_hl(0, "@lsp.type.formatSpecifier", { link = "@string" })
vim.api.nvim_set_hl(0, "@lsp.type.operator", { link = "@operator" })
vim.api.nvim_set_hl(0, "@lsp.type.keyword", { link = "@keyword" })
vim.api.nvim_set_hl(0, "@lsp.type.modifier", { link = "@keyword" })
vim.api.nvim_set_hl(0, "@lsp.type.comment", { link = "@comment" })
vim.api.nvim_set_hl(0, "@lsp.type.regexp", { link = "@string" })
vim.api.nvim_set_hl(0, "@lsp.type.decorator", { fg = "#E6D4A3", italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.builtinType", { link = "@type.builtin" })
vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@variable.builtin" })
vim.api.nvim_set_hl(0, "@lsp.type.null", { link = "@constant" })
vim.api.nvim_set_hl(0, "@lsp.mod.deprecated", { strikethrough = true })
vim.api.nvim_set_hl(0, "@lsp.mod.readonly", { underline = true, sp = "#4A5353" })
vim.api.nvim_set_hl(0, "@lsp.mod.static", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.mod.abstract", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.mod.unused", { fg = "#4A5353" })
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
-- vim.cmd.hi("StatusLine guibg=#A6E3A1 guifg=#374641")
-- vim.cmd.hi("StatusFlags guibg=#374641 guifg=#A6E3A1")
vim.o.statusline = " %f [%{strlen(&fenc)?&fenc:&enc}] [%{&ff}] %y [%{&spelllang}] [0x%04B] "
    .. "%="
    .. " [%n] %l/%L (%p%%), %c "
    .. "%#StatusLineNC#%{&mod?' [+] ':''}%*"
function _G.get_tabline()
    local s = ""
    for tabnr = 1, vim.fn.tabpagenr("$") do
        local winnr = vim.fn.tabpagewinnr(tabnr)
        local buflist = vim.fn.tabpagebuflist(tabnr)[winnr]
        local bufname = vim.fn.bufname(buflist)
        local bufname_short = vim.fn.fnamemodify(bufname, ":t")
        if #bufname_short == 0 then
            bufname_short = "[No Name]"
        end
        if tabnr == vim.fn.tabpagenr() then
            s = s .. "%#TabLineSel#"
        else
            s = s .. "%#TabLine#"
        end
        s = s .. " " .. tabnr .. ": " .. bufname_short .. " "
    end
    s = s .. "%#TabLineFill#"
    return s
end

-- vim.cmd.hi("TabLine guibg=#374641 guifg=#577466")
-- vim.cmd.hi("TabLineSel guibg=#374641 guifg=#A6E3A1")
-- vim.cmd.hi("TabLineFill guibg=#2E3434")

vim.o.tabline = "%!v:lua.get_tabline()"
vim.pack.add({
	"https://github.com/folke/which-key.nvim",
})

local wk = require("which-key")
wk.setup()

wk.add({
    { "<leader>c",  group = "[c]ode",            mode = { "n", "x" } },
    { "<leader>ct", group = "[t]oggles",         mode = { "n", "x" } },
    { "<leader>cg", group = "[g]oto",            mode = { "n", "x" } },
    { "<leader>d",  group = "[d]ocument" },
    { "<leader>s",  group = "[s]earch" },
    { "<leader>S",  group = "[S]ession" },
    { "<leader>t",  group = "[t]emporary (\"scratch\") files" },
    { "<leader>w",  group = "[w]orkspace" },
    { "<leader>v",  group = "[v]ersion control", mode = { "n", "v" } },
    { "<leader>vt", group = "[t]oggles",         mode = { "n", "v" } },
})
