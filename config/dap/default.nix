{ pkgs, lib, ... }:
let
  fromGitHub = owner: repo: rev: hash: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = rev;
    src = pkgs.fetchFromGitHub {
      inherit repo owner rev hash;
      name = "${lib.strings.sanitizeDerivationName repo}";
    };
  };
  jsBasedConfiguration = [
    # Debug single nodejs files
    {
      type = "pwa-node";
      request = "launch";
      name = "Launch file";
      program = "$\{file}";
      cwd.__raw = "vim.fn.getcwd()";
      sourceMaps = true;
    }
    # Debug nodejs processes (make sure to add --inspect when you run the process)
    {
      type = "pwa-node";
      request = "attach";
      name = "Attach";
      processId.__raw = "require(\"dap.utils\").pick_process";
      cwd.__raw = "vim.fn.getcwd()";
      sourceMaps = true;
    }
    # Debug web applications (client side)
    {
      type = "pwa-chrome";
      request = "launch";
      name = "Launch & Debug Chrome";
      url.__raw = ''
        function()
            local co = coroutine.running()
            return coroutine.create(function()
                vim.ui.input({
                    prompt = "Enter URL: ",
                    default = "http://localhost:5173",
                }, function(url)
                    if url == nil or url == "" then
                        return
                    else
                        coroutine.resume(co, url)
                    end
                end)
            end)
        end 
      '';
      webRoot.__raw = "vim.fn.getcwd()";
      protocol = "inspector";
      sourceMaps = true;
      userDataDir = false;
    }
    # Divide for the launch.json derived configs
    # Unsure if I need this. Got it from here: 
    # https://github.com/nikolovlazar/dotfiles/blob/23d5e9fef68608f791c4cc26df93cc0653944cb8/.config/nvim/lua/plugins/dap.lua#L71
    {
      name = "----- ↓ launch.json configs ↓ -----";
      type = "";
      request = "launch";
    }
  ];
in
{
  extraPlugins = [
    (fromGitHub "mxsdev" "nvim-dap-vscode-js" "v1.1.0" "sha256-lZABpKpztX3NpuN4Y4+E8bvJZVV5ka7h8x9vL4r9Pjk=")
  ];
  extraConfigLua = ''
    require("dap-vscode-js").setup({
      -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      debugger_path = "${import ./vscode-js-debug-derivation.nix { inherit pkgs; }}", -- Path to vscode-js-debug installation.
      -- which adapters to register in nvim-dap
      adapters = { 
        'chrome',
        'pwa-node',
		'pwa-chrome',
		'pwa-msedge',
		'node-terminal',
		'pwa-extensionHost' 
      },
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })
  '';

  keymaps = [
    {
      action = "function() require(\"dap\").step_into() end";
      key = "<leader>di";
      lua = true;
      options.desc = "DAP - Step Into";
    }
    {
      action = "function() require(\"dap\").step_out() end";
      key = "<leader>do";
      lua = true;
      options.desc = "DAP - Step Out";
    }
    {
        action = "function() require(\"dap\").continue() end";
        key = "<leader>dc";
        lua = true;
        options.desc = "DAP - Step Over";
    }
    {
      action = "function() require(\"dap\").toggle_breakpoint() end";
      key = "<leader>db";
      lua = true;
      options.desc = "DAP - Step Over";
    }
    {
      action = "function() require(\"dap\").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
      key = "<leader>dB";
      lua = true;
      options.desc = "DAP - Step Over";
    }
    {
      action = "function() require(\"dap\").step_over() end";
      key = "<leader>dO";
      lua = true;
      options.desc = "DAP - Step Over";
    }
    {
      action = ''
        function()
            if vim.fn.filereadable(".vscode/launch.json") then
              local dap_vscode = require("dap.ext.vscode")
              dap_vscode.load_launchjs(nil, {
                -- TODO: Refactor this because I will forget to add it here if I add another language
                ["pwa-node"] = { "typescript", "javascript", "typescriptreact", "javascriptreact"},
                ["chrome"] = { "typescript", "javascript", "typescriptreact", "javascriptreact"},
                ["pwa-chrome"] = { "typescript", "javascript", "typescriptreact", "javascriptreact"},
              })
            end
            require("dap").continue()
          end
      '';
      key = "<leader>da";
      lua = true;
      options.desc = "DAP - Run with Args";
    }
  ];

  plugins = {
    dap = {
      enable = true;

      adapters = {
        executables = { };
        servers = { };
      };
      configurations = {
        typescript = jsBasedConfiguration;
        javascript = jsBasedConfiguration;
        typescriptreact = jsBasedConfiguration;
        javascriptreact = jsBasedConfiguration;
      };
      signs = {
        dapStopped = {
          text = "→";
          texthl = "DiagnosticWarn";
        };
        dapBreakpoint = {
          text = "B";
          texthl = "DiagnosticInfo";
        };
        dapBreakpointRejected = {
          text = "R";
          texthl = "DiagnosticError";
        };
        dapBreakpointCondition = {
          text = "C";
          texthl = "DiagnosticInfo";
        };
        dapLogPoint = {
          text = "L";
          texthl = "DiagnosticInfo";
        };
      };
      extensions = {
        dap-ui.enable = true;
        dap-virtual-text.enable = true;
      };
    };
  };
}
