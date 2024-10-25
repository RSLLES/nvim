return {
  "mfussenegger/nvim-dap",
  config = function ()
    local dap = require("dap")
    vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = "Toogle a breakbpoint"})
    vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = "Start/continue a debugging session"})
    vim.keymap.set('n', '<leader>do', function() dap.step_over() end, { desc = "Step over" })
    vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = "Step into"})
    vim.keymap.set('n', '<leader>dp', function() dap.step_out() end, { desc = "Step out"})
    vim.keymap.set('n', '<leader>dx', function() dap.terminate() end, { desc = "Terminate debugging session"})
  end,
}
