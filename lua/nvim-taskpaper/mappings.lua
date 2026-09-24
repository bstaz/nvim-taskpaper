-- File: lua/nvim-taskpaper/mappings.lua
local M = {}

local function buf_map(bufnr, mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function M.setup(bufnr)
    if vim.g.no_plugin_maps or vim.g.no_taskpaper_maps then
        return
    end

    -- Register which-key descriptions (which-key.nvim v3+ API)
    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.add({
            { "<leader>t", group = "TaskPaper", buffer = bufnr },
            { "<leader>t.", desc = "Fold Notes", buffer = bufnr },
            { "<leader>tP", desc = "Focus Project", buffer = bufnr },
            { "<leader>tj", desc = "Next Project", buffer = bufnr },
            { "<leader>tk", desc = "Previous Project", buffer = bufnr },
            { "<leader>tg", desc = "Go to Project", buffer = bufnr },
            { "<leader>t/", desc = "Search Keyword", buffer = bufnr },
            { "<leader>ts", desc = "Search Tag", buffer = bufnr },
            { "<leader>td", desc = "Toggle Done", buffer = bufnr },
            { "<leader>tt", desc = "Toggle Today", buffer = bufnr },
            { "<leader>tx", desc = "Toggle Cancelled", buffer = bufnr },
            { "<leader>tD", desc = "Archive Done", buffer = bufnr },
            { "<leader>tT", desc = "Show Today", buffer = bufnr },
            { "<leader>tX", desc = "Show Cancelled", buffer = bufnr },
        })
    end

    local cmd_prefix = "<cmd>lua require('nvim-taskpaper')"
    
    -- Project navigation and folding
    buf_map(bufnr, "n", "<Leader>t.", cmd_prefix .. ".fold_notes()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tP", cmd_prefix .. ".focus_project()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tj", cmd_prefix .. ".next_project()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tk", cmd_prefix .. ".previous_project()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tg", cmd_prefix .. ".go_to_project()<CR>", {})

    -- Search functionality
    buf_map(bufnr, "n", "<Leader>t/", cmd_prefix .. ".search_keyword()<CR>", {})
    buf_map(bufnr, "n", "<Leader>ts", cmd_prefix .. ".search_tag()<CR>", {})

    -- Task status toggling
    buf_map(bufnr, "n", "<Leader>td", cmd_prefix .. ".toggle_done()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tt", cmd_prefix .. ".toggle_today()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tx", cmd_prefix .. ".toggle_cancelled()<CR>", {})

    -- Project/task management
    buf_map(bufnr, "n", "<Leader>tD", cmd_prefix .. ".archive_done()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tT", cmd_prefix .. ".show_today()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tX", cmd_prefix .. ".show_cancelled()<CR>", {})
end

return M