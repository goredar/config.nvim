local vim = vim

local function keymap(mode, lhs, rhs, options)
  options = options or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local map = keymap

map("n", "<c-s>", ":w!<CR>")
map("n", "<c-q>", ":BufferDelete<CR>")
map("n", "<S-l>", ":BufferNext<CR>")
map("n", "<S-h>", ":BufferPrevious<CR>")

map("v", ">", ">gv")
map("v", "<", "<gv")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
-- map("n", "<C-j>", "<C-w>j")
-- map("n", "<C-k>", "<C-w>k")

map("n", "0", "^")
map("n", "^", "0")

map("i", "<C-e>", "<C-o>$")
map("i", "<C-a>", "<C-o>^")
map("i", "<C-l>", "<C-o>w")
map("i", "<C-h>", "<C-o>b")
map("i", "<C-j>", "<C-o>j")
map("i", "<C-k>", "<C-o>k")
map("i", "<C-b>", "<C-o>b")

map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

map("v", "p", '"_dP')

map("n", "<cr>", "<cmd>:noh<CR>")

map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>")
map("n", "<C-z>", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n", "<C-b>", "<cmd>lua require('telescope.builtin').buffers()<CR>")

map("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
map("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")
map("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

map("n", "<C-J>", '<cmd>lua vim.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>')
map("n", "<C-K>", '<cmd>lua vim.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>')

map("n", "<C-a>", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")

map("n", "<Leader>ss", "<cmd>set spell!<CR>")
map("n", "<Leader>z", "1z=")
map("n", "<a-n>", "]szz")
map("n", "<a-p>", "[szz")

map("n", "<Leader>fe", ":NvimTreeToggle<CR>")
map("n", "<Leader>gb", ":Git blame<CR>")

map("n", "j", "gj")
map("n", "k", "gk")

-- map("n", "s", '<cmd>lua require("flash").jump()<CR>')
-- map('i', '<C-f>', 'copilot#Accept("<CR>")', {silent = true, script = true, expr = true})
-- map("n", "<M-l>", ":BufferNext<CR>")
-- map("n", "<M-h>", ":BufferPrevious<CR>")

-- map("n", "K", "<cmd>Lspsaga hover_doc<CR>")
-- map("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>")
-- map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
-- map("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>")
-- map("n", "<C-J>", "<cmd>Lspsaga diagnostic_jump_next<CR>")
-- map("n", "<C-K>", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
