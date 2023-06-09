return {
  { "moll/vim-bbye" }, -- close buffers without destroying windows
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["l"] = "open",
        }
      }
    },
  },
}
