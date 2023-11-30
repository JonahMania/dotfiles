local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
vim.g.mapleader = "\\" -- Leader key for packages

require("lazy").setup({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {'<leader>f', "<cmd>Telescope find_files<cr>", desc = "Find file"},
      {'<leader>b', "<cmd>Telescope buffers<cr>", desc = "Buffers"},
      {'<leader>g', "<cmd>Telescope live_grep<cr>", desc = "Live grep"},
    },
})
