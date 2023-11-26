local actions = require("telescope.actions")
local ts = require("telescope")

ts.setup({
    defaults = {
        layout_strategy = "vertical",
        layout_config = {
            width = 0.75,
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-o>"] = actions.send_selected_to_qflist,
            },
        },
        scroll_strategy = "limit",
    },
    extensions = {
        heading = {
            treesitter = true,
        },
    },
})

ts.load_extension("changed_files")
ts.load_extension("emoji")
ts.load_extension("fzf")
ts.load_extension("heading")
ts.load_extension("ui-select")
ts.load_extension("windows")

vim.g.telescope_changed_files_base_branch = "main"

vim.keymap.set("n", "<leader>b", "<Cmd>Telescope buffers<CR>", {
    desc = "search buffers",
})
vim.keymap.set("n", "<leader>c", "<Cmd>Telescope colorscheme<CR>", {
    desc = "search colorschemes",
})
vim.keymap.set("n", "<leader>da", "<Cmd>TodoTelescope<CR>", {
    desc = "search TODOs across all files",
})
vim.keymap.set("n", "<leader>dc", "<Cmd>TodoQuickFix<CR>", {
    desc = "search TODOs in current file",
})
vim.keymap.set("n", "<leader>e", "<Cmd>Telescope commands<CR>", {
    desc = "search Ex commands",
})
vim.keymap.set("n", "<leader>f", "<Cmd>Telescope find_files hidden=true<CR>", {
    desc = "search files",
})
vim.keymap.set("n", "<leader>g", "<Cmd>Telescope changed_files<CR>", {
    desc = "search changed files",
})
vim.keymap.set("n", "<leader><leader>h", "<Cmd>Telescope help_tags<CR>", {
    desc = "search help",
})
vim.keymap.set("n", "<leader>i", "<Cmd>Telescope builtin<CR>", {
    desc = "search builtins",
})
vim.keymap.set("n", "<leader>j", "<Cmd>Telescope emoji<CR>", {
    desc = "search emojis",
})
vim.keymap.set("n", "<leader>k", "<Cmd>Telescope keymaps<CR>", {
    desc = "search key mappings",
})
vim.keymap.set("n", "<leader>ld", "<Cmd>Telescope diagnostics<CR>", {
    desc = "search lsp diagnostics",
})
vim.keymap.set("n", "<leader>li", "<Cmd>Telescope lsp_incoming_calls<CR>", {
    desc = "search lsp incoming calls",
})
vim.keymap.set("n", "<leader>lo", "<Cmd>Telescope lsp_outgoing_calls<CR>", {
    desc = "search lsp outgoing calls",
})
vim.keymap.set("n", "<leader>lr", "<Cmd>Telescope lsp_references<CR>", {
    desc = "search lsp code reference",
})
vim.keymap.set("n", "<leader>ls", "<Cmd>lua require('telescope.builtin').lsp_document_symbols({ show_line = true })<CR>", {
    desc = "search lsp document tree",
})
vim.keymap.set("n", "<leader>m", "<Cmd>Telescope heading<CR>", {
    desc = "search markdown headings",
})
vim.keymap.set("n", "<leader>p", "<Cmd>Telescope grep_string<CR>", {
    desc = "search for keyword under cursor",
})
vim.keymap.set("n", "<leader>q", "<Cmd>Telescope quickfix<CR>", {
    desc = "search quickfix list",
})
vim.keymap.set("n", "<leader>r", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", {
    desc = "search current buffer text",
})
vim.keymap.set("n", "<leader>s", "<Cmd>Telescope treesitter<CR>", {
    desc = "search treesitter symbols",
})
vim.keymap.set("n", "<leader>w", "<Cmd>Telescope windows<CR>", {
    desc = "search windows",
})
vim.keymap.set("n", "<leader>x", "<Cmd>Telescope live_grep<CR>", {
    desc = "search text",
})

-- Remove the Vim builtin colorschemes so they don't show in Telescope.
vim.cmd("silent !rm $VIMRUNTIME/colors/*.vim &> /dev/null")
