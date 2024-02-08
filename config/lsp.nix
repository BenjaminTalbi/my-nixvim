{
  plugins = {
    lsp = {
      enable = true;
      preConfig = ''
        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
        

        vim.diagnostic.config {
            virtual_text = true,
            float = {
                header = false,
                border = 'rounded',
                focusable = true,
            }
        }
      '';
      capabilities = ''
        capabilities =  require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      '';
      servers = {
        nil_ls = {
          enable = true;
          settings.formatting.command = [ "nixpkgs-fmt" ];
        };
        tsserver.enable = true;
        svelte.enable = true;
        tailwindcss.enable = true;
        cssls.enable = true;
        html.enable = true;
        lua-ls.enable = true;
        emmet_ls = {
          enable = true;
        };
      };
      onAttach = ''
        local opts = { buffer = bufnr, remap = false }

        -- show definitions, references
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        -- go to declaration
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) 

        -- show lsp definitions
        vim.keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts)

        -- show lsp implementations
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        -- show lsp type definitions
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- see available code actions
        vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)

        -- smart rename 
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- show buffer diagnostics 
        vim.keymap.set("n", "<leader>vD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
            
        -- show line diagnostics
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        
        -- go to next diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
 
        -- go to previous diagnostics
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
          
        -- show documentation for what is under the cursor
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        -- restart lsp
        vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
          
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.format, opts)
      '';
    };
  };
}
