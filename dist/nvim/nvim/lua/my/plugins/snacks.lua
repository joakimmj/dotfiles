return {
    {
        "folke/snacks.nvim",
        lazy = false,
        ---@type snacks.Config
        opts = {
            picker = {
                ui_select = true,
                layout = {
                    --- Use the default layout or vertical if the window is too narrow
                    preset = function()
                        return vim.o.columns >= 120 and "ivy" or "ivy_split"
                    end,
                },
                focus = "input",
                sources = {
                    explorer = {
                        layout = {
                            preset = "sidebar",
                            preview = true,

                            layout = {
                                width = 80,
                            }
                        },
                        focus = "list",
                    },
                },
            },
            explorer = {
                replace_netrw = true, -- Replace netrw with the snacks explorer
            },
            gitbrowse = {},
            indent = {},
        },
        keys = {
            -- workspace
            { "<leader>we",      function() Snacks.picker.explorer() end,                                                 desc = "[e]xplorer" },
            { "<leader>wf",      function() Snacks.picker.files({ hidden = true, ignored = true }) end,                   desc = "[f]iles" },
            { "<leader>wg",      function() Snacks.picker.grep() end,                                                     desc = "[g]rep" },
            { "<leader>ws",      function() Snacks.picker.lsp_workspace_symbols() end,                                    desc = "[s]ymbols" },

            -- document
            { "<leader>ds",      function() Snacks.picker.lsp_symbols() end,                                              desc = "[s]ymbols" },

            -- search
            { "<leader>sh",      function() Snacks.picker.help() end,                                                     desc = "[h]elp" },
            { "<leader>sm",      function() Snacks.picker.marks() end,                                                    desc = "[m]arks" },
            { "<leader>sk",      function() Snacks.picker.keymaps() end,                                                  desc = "[k]eymaps" },
            { "<leader>sf",      function() Snacks.picker.smart({ hidden = true }) end,                                   desc = "[f]iles" },
            { "<leader>ss",      function() Snacks.picker.pickers() end,                                                  desc = "[s]elect picker" },
            { "<leader>sw",      function() Snacks.picker.grep_word() end,                                                desc = "current [w]ord" },
            { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                              desc = "[d]iagnostics" },
            { "<leader>sr",      function() Snacks.picker.resume() end,                                                   desc = "[r]esume" },
            { "<leader>s.",      function() Snacks.picker.recent() end,                                                   desc = "recent files ('.' for repeat)" },
            { "<leader><space>", function() Snacks.picker.buffers() end,                                                  desc = "[ ] find existing buffers" },
            { "<leader>/",       function() Snacks.picker.grep({ glob = vim.fn.expand("%:t"), need_search = false }) end, desc = "[/] fuzzily search in current buffer" },
            { "<leader>s/",      function() Snacks.picker.grep_buffers() end,                                             desc = "[/] open files" },
            { "<leader>sn",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true }) end,   desc = "[n]eovim files" },

            -- version control
            { "<leader>vd",      function() Snacks.picker.git_status() end,                                               desc = "git [d]iff" },
            { "<leader>vo",      function() Snacks.gitbrowse() end,                                                       desc = "[o]pen repo destination" },

            -- LSP
            { "gd",              function() Snacks.picker.lsp_definitions() end,                                          desc = "[g]oto [d]efinition" },
            { "gr",              function() Snacks.picker.lsp_references() end,                                           desc = "[g]oto [r]eferences",                 nowait = true },
            { "gI",              function() Snacks.picker.lsp_implementations() end,                                      desc = "[g]oto [I]mplementation" },
            { "<leader>cgt",     function() Snacks.picker.lsp_type_definitions() end,                                     desc = "[t]ype definition" },

            -- scratch (tmp files)
            { "<leader>tt",      function() Snacks.scratch() end,                                                         desc = "[t]oggle scratch" },
            { "<leader>ts",      function() Snacks.scratch.select() end,                                                  desc = "[s]elect scratch" },
        },
    }
}
