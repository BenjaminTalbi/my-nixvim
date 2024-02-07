{ lib, ... }:
let
  image = (builtins.readFile ../ascii/img3.txt);
in
{
  extraConfigLua = "require'alpha.term'";

  extraFiles = {
    "../ascii/img3.txt" = "img3.txt";
  };

  plugins.alpha = {
    enable = true;
    iconsEnabled = true;
    layout = [
      {
        type = "padding";
        val = 4;
      }
      {
        opts = {
          position = "center";
        };
        type = "terminal";
        val = "";
        # command = "cat /home/benjamin/code/hobby/nixvimflake/ascii/img3.txt";
        command = "cat ./ascii/img3.txt";
        width = 75;
        height = 25;
      }
      {
        type = "padding";
        val = 6;
      }
      {
        type = "group";
        val = [
          {
            type = "button";
            val = "    old files";
            on_press = ":Telescope oldfiles<CR>";
            opts = {
              align_shortcut = "right";
              hl = "normal";
              hl_shortcut = "Function";
              width = 50;
              cursor = 5;
              shrink_margin = true;
              shortcut = "SPC f r";
              position = "center";
            };
          }
          {
            type = "button";
            val = "󰥨    find file";
            on_press = ":Telescope file_browser<CR>";
            opts = {
              align_shortcut = "right";
              hl = "normal";
              hl_shortcut = "Function";
              width = 50;
              cursor = 5;
              shrink_margin = true;
              shortcut = "SPC f f";
              position = "center";
            };
          }
          {
            type = "button";
            val = "󰱼    find text";
            on_press = ":Telescope live_grep_args<CR>";
            opts = {
              align_shortcut = "right";
              hl = "normal";
              hl_shortcut = "Function";
              width = 50;
              cursor = 5;
              shrink_margin = true;
              shortcut = "SPC f s";
              position = "center";
            };
          }
          #{
          #  type = "button";
          #  val = "    browse git";
          #  on_press = ":Flog<CR>";
          #  opts = {
          #    align_shortcut = "right";
          #    hl = "normal";
          #    hl_shortcut = "Function";
          #    width = 50;
          #    cursor = 5;
          #    shrink_margin = true;
          #    shortcut = "h";
          #    position = "center";
          #  };
          #}
          {
            type = "button";
            val = "    new file";
            on_press = ":ene <BAR> startinsert<CR>";
            opts = {
              align_shortcut = "right";
              hl = "normal";
              hl_shortcut = "Function";
              width = 50;
              cursor = 5;
              shrink_margin = true;
              shortcut = ":e";
              position = "center";
            };
          }
          {
            type = "button";
            val = "󰭿    Quit NVIM";
            on_press = ":qa<CR>";
            opts = {
              hl = "normal";
              hl_shortcut = "Function";
              cursor = 2;
              align_shortcut = "right";
              width = 50;
              shrink_margin = true;
              shortcut = ":q";
              position = "center";
            };
          }
        ];
      }
      {
        type = "padding";
        val = 6;
      }
      {
        opts = {
          hl = "Keyword";
          position = "center";
        };
        type = "text";
        val = "Treat yourself as a community across time";
      }
    ];
  };
}
