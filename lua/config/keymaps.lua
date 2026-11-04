


local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- 基本模式切換
keymap("i", "jk", "<Esc>", opts)

-- 視窗移動
keymap("n", "<C-h>", "<C-W>h", opts)
keymap("n", "<C-j>", "<C-W>j", opts)
keymap("n", "<C-k>", "<C-W>k", opts)
keymap("n", "<C-l>", "<C-W>l", opts)

keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-b>", "<Left>", opts)
keymap("i", "<C-a>", "<Home>", opts)
keymap("i", "<C-e>", "<End>", opts)

-- 切換輸入法（假設你有定義 SetInputMethod 函數）
-- keymap("n", "<C-i>", ":call SetInputMethod()<CR>", opts)

-- 插入模式下的光標控制
-- keymap("i", "<C-F>", "<Right>", opts)
-- keymap("i", "<C-B>", "<Left>", opts)
-- keymap("i", "<C-A>", "<Home>", opts)
-- keymap("i", "<C-]>", "<End>{}<Left>", opts)

-- 替代視覺模式貼上行為（不覆蓋寄存器）
keymap("v", "p", '"_dP', opts)

keymap("i", "<C-k>", "copilot#Accept(\"\\<CR>\")", {
    expr = true,
    silent = true,
    script = true,
    noremap = true
  })

-- 根據 FileType 設定鍵盤映射
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "java", "javascript" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "i", "<C-u>", "<End>;", opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "i", "<C-u>", "<End>:", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<C-f>", ":Autoformat<CR>", opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<localleader>@", ":%s/\\[@\\([^]]*\\)\\]/\\\\cite{\\1}/g<CR>", opts)
  end,
})




