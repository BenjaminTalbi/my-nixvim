{ pkgs, ... }:
# https://nix-community.github.io/nixvim
{
  imports = [
    ./telescope.nix
    ./cmp.nix
    ./lsp.nix
    ./harpoon.nix
    ./treesitter.nix
    ./oil.nix
    ./comment.nix
    ./undotree.nix
    ./alpha.nix
    ./lualine.nix
  ];

  config = {
    vimAlias = true;
    enableMan = true;
    colorscheme = "rose-pine";
    colorschemes = {
      rose-pine = {
        enable = true;
        transparentBackground = true;
        transparentFloat = true;
      };
    };

    options = {
      background = "dark";
      guicursor = "";
      number = true;
      relativenumber = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      wrap = false;
      swapfile = false;
      backup = false;
      undodir = "./.vim/undodir";
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      isfname = "@,48-57,/,.,-,_,+,,,#,$,%,~,=,@-@";
      updatetime = 50;
      showtabline = 0;
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        action = ":m '>+1<CR>gv=gv";
        key = "J";
        mode = "v";
        options.desc = "Move selection up";
      }
      {
        action = ":m '<-2<CR>gv=gv";
        key = "K";
        mode = "v";
        options.desc = "Move selection down";
      }
      {
        action = "mzJ`z";
        key = "J";
        mode = "n";
        options.desc = "Join but cursor stays put";
      }
      {
        action = "<C-d>zz";
        key = "<C-d>";
        mode = "n";
        options.desc = "Jump down with fixed cursor";
      }
      {
        action = "<C-u>zz";
        key = "<C-u>";
        mode = "n";
        options.desc = "Jump up with fixed cursor";
      }
      {
        action = "nzzzv";
        key = "n";
        mode = "n";
        options.desc = "Next with fixed cursor";
      }
      {
        action = "Nzzzv";
        key = "N";
        mode = "n";
        options.desc = "Previous with fixed cursor";
      }
      {
        action = ''[["_dP]]'';
        key = "<leader>p";
        mode = "x";
        options.desc = "Paste keep clipboard";
      }
      {
        action = ''[["+y]]'';
        key = "<leader>y";
        mode = [ "n" "v" ];
        options.desc = "Yank system clipboard";
      }
      {
        action = ''[["+Y]]'';
        key = "<leader>Y";
        mode = "n";
        options.desc = "Yank system clipboard";
      }
      {
        action = ''[["_d]]'';
        key = "<leader>d";
        mode = "n";
        options.desc = "Delete to to system clipboard";
      }
      {
        action = "<nop>";
        key = "Q";
        mode = "n";
      }
      {
        action = "<cmd>Ex<CR>";
        key = "<leader>pv";
        mode = "n";
        options.desc = "Go to file explorer";
      }
    ];


    extraPlugins = with pkgs.vimPlugins; [
      lexima-vim
      dressing-nvim
    ];

    extraPackages = with pkgs; [
      nixpkgs-fmt
    ];

  };

}
