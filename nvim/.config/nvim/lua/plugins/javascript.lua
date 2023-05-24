return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "mxsdev/nvim-dap-vscode-js",
      module = { "dap-vscode-js" },
      opts = {
        node_path = "node",
        debugger_path = os.getenv("HOME") .. "/.local/share/nvim/lazy/vscode-js-debug",
        -- debugger_cmd = {"js-debug-adapter"}
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
      },
      config = function()
        local dap = require("dap")
        for _, language in ipairs({ "typescript", "javascript" }) do
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "launch",
              name = "Debug Jest Tests",
              -- trace = true, -- include debugger info
              runtimeExecutable = "node",
              runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "--runInBand",
              },
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
              internalConsoleOptions = "neverOpen",
            },
          }
        end
        for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
          require("dap").configurations[language] = {
            {
              type = "pwa-chrome",
              name = "Attach - Remote Debugging",
              request = "attach",
              program = "${file}",
              cwd = vim.fn.getcwd(),
              sourceMaps = true,
              protocol = "inspector",
              port = 9222,
              webRoot = "${workspaceFolder}",
            },
            {
              type = "pwa-chrome",
              name = "Launch Chrome",
              request = "launch",
              url = "http://localhost:3000",
            },
          }
        end
      end,
    },
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    },
  },
}
