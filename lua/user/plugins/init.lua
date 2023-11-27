local lazypath = LAZY_PATH .. "/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- ------------------------------- Themes ------------------------------- --
    {
        "ThemerCorp/themer.lua",
        config = function()
            require("user.plugins.config.themer")
        end,
    },

    -- -------------------------------- Looks ------------------------------- --
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "HiPhish/nvim-ts-rainbow2",
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("user.plugins.config.treesitter")
        end,
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/playground",
        dependencies = "nvim-treesitter/nvim-treesitter",
        enabled = false,
    },
    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("user.plugins.config.devicons")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = 'ibl',
        config = function()
            require("user.plugins.config.indent-blankline")
        end,
    },
    {
        "lukas-reineke/virt-column.nvim",
        config = true,
    },
    {
        "RRethy/vim-hexokinase",
        config = function()
            vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
        end,
        build = "make hexokinase",
        cmd = "HexokinaseToggle",
    },
    -- --------------------------------- LSP -------------------------------- --
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("user.plugins.config.lspconfig")
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("user.plugins.config.null_ls")
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        dependencies = "nvim-lspconfig",
        config = function()
            require("user.plugins.config.others").lsp_signature()
        end,
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        init = function()
            require("user.plugins.config.others").refactoring()
        end,
    },
    {
        "sbdchd/neoformat",
        cmd = "Neoformat",
        setup = function()
            vim.api.nvim_create_autocmd("BufWritePre", {
                command = [[silent! undojoin | Neoformat]],
                desc = "Format using neoformat on save.",
                group = vim.api.nvim_create_augroup("neoformat_format_onsave", { clear = true }),
                pattern = "*",
            })
        end,
        config = function()
            require("user.plugins.config.neoformat")
        end,
        enabled = false,
    },

    -- ----------------------------- Completion ----------------------------- --
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "quangnguyen30192/cmp-nvim-ultisnips",
            { "hrsh7th/cmp-omni", ft = "tex" },
        },
        config = function()
            require("user.plugins.config.cmp")
        end,
        event = "InsertEnter",
    },

    -- ------------------------------ Features ------------------------------ --
    {
        "dstein64/vim-startuptime",
        config = function()
            vim.g.startuptime_tries = 5
            -- vim.g.startuptime_event_width = 50
        end,
        cmd = "StartupTime",
    },
    {
        "terrortylor/nvim-comment",
        config = function()
            require("user.plugins.config.others").nvim_comment()
        end,
        cmd = "CommentToggle",
        keys = {
            { mode = "n", "<C-/>" },
            { mode = "v", "<C-/>" },
            { mode = "i", "<C-/>" },
            { mode = "n", "gc" },
            { mode = "v", "gc" },
        },
    },
    {
        "jiangmiao/auto-pairs",
        config = function()
            require("user.plugins.config.others").autopairs()
        end,
        event = "InsertEnter",
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("user.plugins.config.alpha")
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        config = function()
            require("user.plugins.config.others").markdown_preview()
        end,
        cmd = "MarkdownPreview",
        ft = "markdown",
        build = "cd app && yarn install",
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("user.plugins.config.others").neogen()
        end,
        cmd = "Neogen",
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("user.plugins.config.neotree")
        end,
        keys = "<Leader><Tab>",
    },
    {
        -- WINDOW PICKER
        "s1n7ax/nvim-window-picker",
        version = "v1.*",
        config = function()
            local picker = require("window-picker")
            picker.setup({ fg_color = "#000000" })

            vim.keymap.set("n", "<leader><leader>w", function()
                local picked_window_id =
                picker.pick_window() or vim.api.nvim_get_current_win()
                vim.api.nvim_set_current_win(picked_window_id)
            end, { desc = "Pick a window" })
        end
    },
    {
        -- WORD USAGE HIGHLIGHTER
        "RRethy/vim-illuminate"
    }, {
        -- JUMP TO WORD INDICTORS
        "jinh0/eyeliner.nvim",
        lazy = false,
        opts = { highlight_on_key = true, dim = true }
    },
    {
        "Shatur/neovim-session-manager",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("user.plugins.config.others").session()
        end,
        cmd = "SessionManager",
        keys = {
            { mode = "n", "<Leader>ss" },
            { mode = "n", "<Leader>ls" },
        },
    },
    {
        "phaazon/hop.nvim",
        version = "2.x",
        config = function()
            require("user.plugins.config.others").hop()
        end,
        keys = {
            { mode = "n", "f" },
            { mode = "n", "S" },
            { mode = "o", "f" },
        },
    },
    {
        "kylechui/nvim-surround",
        opts = {
            highlight = { duration = 500 },
            move_cursor = false,
        },
    },
    {
        "mg979/vim-visual-multi",
        config = function()
            vim.g.VM_set_statusline = 0
        end,
        keys = {
            { mode = "n", "<C-n>" },
            { mode = "n", "<C-Down>" },
            { mode = "n", "<C-Up>" },
        },
    },

    -- -------------------------------- LaTeX ------------------------------- --
    {
        "lervag/vimtex",
        config = function()
            require("user.plugins.config.vimtex")
        end,
        ft = {
            "tex",
            "bib",
        },
    },
    {
        "ludovicchabant/vim-gutentags",
        config = function()
            require("user.plugins.config.others").gutentags()
        end,
        ft = {
            "tex",
            "bib",
        },
    },
    {
        "SirVer/ultisnips",
        config = function()
            require("user.plugins.config.others").ultisnips()
        end,
        event = "InsertEnter",
    },

    {
        -- DISPLAY HEX COLOURS
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end
    },
    {
        -- GENERATE HEX COLOURS
        "uga-rosa/ccc.nvim"
    },
    {
        -- ASYNC DISPATCH
        "tpope/vim-dispatch"
    },
    {
        'skywind3000/asynctasks.vim',
        'tpope/vim-fugitive',
        {
            'skywind3000/asyncrun.vim',
            config = function ()
                vim.cmd([[
                let g:asynctasks_rtp_config = "tasks.ini"
                let g:asynctasks_term_pos = 'right'
                let g:asynctasks_term_rows = 10
                let g:asynctasks_term_cols = 54
                let g:asynctasks_profile = 'debug'
                let g:asynctasks_term_focus = 0
                ]])

                vim.keymap.set('n', '<F5>', ':AsyncTask file-build<CR>', { noremap = true, silent = true })
                vim.keymap.set('n', '<F6>', ':AsyncTask file-run<CR>', { noremap = true, silent = true })
            end
        },
    },
    -- NOTE change default telescope
    -- ------------------------------ Telescope ----------------------------- --
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                dependencies = "tami5/sqlite.lua",
                init = function()
                    vim.g.sqlite_clib_path = "C:\\ProgramData\\chocolatey\\lib\\SQLite\\tools\\sqlite3.dll"
                end,
            },
            "fhill2/telescope-ultisnips.nvim",
            -- NOTE: start edit

        },
        config = function()
            require("user.plugins.config.telescope")
        end,

    },

    -- NOTE: change default telescope-

    {
        -- FZF SORTER FOR TELESCOPE WRITTEN IN C
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        -- SEARCH INDEXER
        "kevinhwang91/nvim-hlslens",
        config = true,
    },
    {
        -- USE TELESCOPE FOR UI ELEMENTS
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({})
        end,
    },
    {
        -- SEARCH WINDOWS IN TELESCOPE
        "kyoh86/telescope-windows.nvim",
    },
    {
        -- SEARCH MARKDOWN HEADINGS IN TELESCOPE
        "crispgm/telescope-heading.nvim",
    },
    {
        -- SEARCH EMOJIS IN TELESCOPE
        "xiyaowong/telescope-emoji.nvim",
    },
    {
        -- SEARCH CHANGED GIT FILES IN TELESCOPE
        "axkirillov/telescope-changed-files",
    },
    {
        -- SEARCH TABS IN TELESCOPE
        "LukasPietzschmann/telescope-tabs",
        config = function()
            vim.keymap.set("n", "<leader>t", "<Cmd>lua require('telescope-tabs').list_tabs()<CR>", { desc = "search tabs" })
        end,
    },
    {
        -- IMPROVES ASTERISK BEHAVIOR
        "haya14busa/vim-asterisk",
        config = function()
            vim.keymap.set('n', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
            vim.keymap.set('n', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
            vim.keymap.set('n', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
            vim.keymap.set('n', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})

            vim.keymap.set('x', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
            vim.keymap.set('x', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
            vim.keymap.set('x', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
            vim.keymap.set('x', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
        end,
    },
    {
        --INFO: SEARCH NOTES/TODOS IN TELESCOPE
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({
                keywords = {
                    FIX = {
                        icon = " ", -- icon used for the sign, and in search results
                        color = "error", -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    TEST = { icon = "⏲", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                },
            })
        end,
    },
    -- ------------------------- Buffer, Statusline ------------------------- --
    {
        "willothy/nvim-cokeline",
        config = function()
            require("user.plugins.config.cokeline")
        end,
        dependencies = "ThemerCorp/themer.lua",
    },
    {
        "rebelot/heirline.nvim",
        dependencies = {
            "ThemerCorp/themer.lua",
            {
                "lewis6991/gitsigns.nvim",
                config = function()
                    require("user.plugins.config.gitsigns")
                end,
                lazy = true,
            },
        },
        config = function()
            require("user.plugins.config.heirline")
        end,
    },
    { "itchyny/vim-highlighturl", event = "VeryLazy" },

    -- --------------------------------- QOL -------------------------------- --
    {
        "tpope/vim-repeat",
    },
    {
        "https://gitlab.com/yorickpeterse/nvim-pqf",
        config = function()
            require("pqf").setup()
        end,
        name = "nvim-pqf",
        event = "VeryLazy",
    },
    {
        "christoomey/vim-titlecase",
        keys = "gz",
    },
    {
        "junegunn/vim-easy-align",
        cmd = "EasyAlign",
    },
    {
        "antoinemadec/FixCursorHold.nvim",
        config = function()
            vim.g.curshold_updatie = 500
        end,
    },
    {
        "Konfekt/FastFold",
        config = function()
            require("user.plugins.config.others").fastfold()
        end,
    },
    {
        -- NOTE: git function
        -- GIT HISTORY
        "sindrets/diffview.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function()
            require("user.plugins.config.others").diffview()
        end,
    },
    {
        -- OPEN LINES IN GITHUB
        "ruanyl/vim-gh-line",
        config = function()
            vim.cmd("GH")
        end,
        keys = {
            {
                "<leader><leader>gl",
                function()
                    vim.cmd("GH")
                end,
                desc = "Open single line in GitHub's web UI",
                noremap = true,
                silent = true
            }
        },
    },
    {
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("user.plugins.config.pretty_fold")
        end,
    },
    {
        "rmagatti/alternate-toggler",
        config = function()
            vim.keymap.set("n", "ta", "<Cmd>:ToggleAlternate<CR>")
        end,
        cmd = "ToggleAlternate",
        keys = "ta",
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = {},
    },
    {
        "sainnhe/sonokai",
        lazy = true,
    },
    {
        "tanvirtin/monokai.nvim",
        lazy = true,
    },{
        -- SEARCH AND REPLACE
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("spectre").setup({
                live_update = true,
                is_insert_mode = true,
                -- replace_engine = { ["sed"] = { cmd = "sed" } }
            })
            vim.keymap.set("n", "<leader>S",
            "<Cmd>lua require('spectre').open()<CR>",
            { desc = "search and replace" })
        end


    },
}
)
