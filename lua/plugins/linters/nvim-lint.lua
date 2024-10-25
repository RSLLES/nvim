return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    mason = require("mason")
    nvim_lint = require("lint")
    
    -- command to trigger linting
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })

    -- selected linters (should be installed in mason)
    nvim_lint.linters_by_ft = {
      python = {"pylint"},
    }
    
  end,
}
