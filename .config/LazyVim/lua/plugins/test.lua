return {
  { "olimorris/neotest-phpunit" },
  { "rouge8/neotest-rust" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        "neotest-phpunit", -- only works with  with lazyvim.plugins.extras.test.core enabled
        "neotest-rust", -- only works with  with lazyvim.plugins.extras.test.core enabled
        -- "rustaceanvim.neotest", -- doesn't work with lazyvim.plugins.extras.test.core enabled
      },
    },
  },
}
