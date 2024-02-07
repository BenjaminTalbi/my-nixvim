{
  plugins = {
    treesitter = {
      enable = true;
      folding = false;
    };
    treesitter-textobjects = {
      enable = true;
      lspInterop = {
        enable = true;
        border = "rounded";
      };
      move = {
        enable = true;
        setJumps = true;
        gotoNextStart = {
          "]f" = { query = "@call.outer"; desc = "Next function call start"; };
          "]m" = { query = "@function.outer"; desc = "Next method/function def start"; };
          "]c" = { query = "@class.outer"; desc = "Next class start"; };
          "]i" = { query = "@conditional.outer"; desc = "Next conditional start"; };
          "]l" = { query = "@loop.outer"; desc = "Next loop start"; };
          "]s" = { query = "@scope"; queryGroup = "locals"; desc = "Next scope"; };
          "]z" = { query = "@fold"; queryGroup = "folds"; desc = "Next fold"; };
        };
        gotoNextEnd = {
          "]F" = { query = "@call.outer"; desc = "Next function call end"; };
          "]M" = { query = "@function.outer"; desc = "Next method/function def end"; };
          "]C" = { query = "@class.outer"; desc = "Next class end"; };
          "]I" = { query = "@conditional.outer"; desc = "Next conditional end"; };
          "]L" = { query = "@loop.outer"; desc = "Next loop end"; };
        };
        gotoPreviousStart = {
          "[f" = { query = "@call.outer"; desc = "Prev function call start"; };
          "[m" = { query = "@function.outer"; desc = "Prev method/function def start"; };
          "[c" = { query = "@class.outer"; desc = "Prev class start"; };
          "[i" = { query = "@conditional.outer"; desc = "Prev conditional start"; };
          "[l" = { query = "@loop.outer"; desc = "Prev loop start"; };
        };
        gotoPreviousEnd = {
          "[F" = { query = "@call.outer"; desc = "Prev function call end"; };
          "[M" = { query = "@function.outer"; desc = "Prev method/function def end"; };
          "[C" = { query = "@class.outer"; desc = "Prev class end"; };
          "[I" = { query = "@conditional.outer"; desc = "Prev conditional end"; };
          "[L" = { query = "@loop.outer"; desc = "Prev loop end"; };
        };
      };
      swap = {
        enable = true;
        swapNext = {
          "<leader>na" = "@parameter.inner";
          "<leader>nn" = "@function.outer";
        };
        swapPrevious = {
          "<leader>pa" = "@parameter.inner";
          "<leader>pn" = "@function.outer";
        };
      };
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "a=" = {
            query = "@assignment.outer";
            desc = "Select outer part of an assignment";
          };
          "i=" = {
            query = "@assignment.inner";
            desc = "Select outer part of an assignment";
          };
          "l=" = {
            query = "@assignment.lhs";
            desc = "Select the left hand side of a statement";
          };
          "r=" = {
            query = "@assignment.rhs";
            desc = "Select the right hand side of a statement";
          };
          "aa" = {
            query = "@parameter.outer";
            desc = "Select the outer part of the parameter";
          };
          "ia" = {
            query = "@parameter.inner";
            desc = "Select the inner part of the parameter";
          };
          "ai" = {
            query = "@conditional.outer";
            desc = "Select the outer part of the conditional";
          };
          "ii" = {
            query = "@conditional.inner";
            desc = "Select the inner part of the conditional";
          };
          "al" = {
            query = "@loop.outer";
            desc = "Select the outer part of the loop";
          };
          "il" = {
            query = "@loop.inner";
            desc = "Select the inner part of the loop";
          };
          "af" = {
            query = "@call.outer";
            desc = "Select the outer part of a function call";
          };
          "if" = {
            query = "@call.inner";
            desc = "Select the inner part of a function call";
          };
          "am" = {
            query = "@function.outer";
            desc = "Select the outer part of a function definition";
          };
          "im" = {
            query = "@function.inner";
            desc = "Select the inner part of a function definition";
          };
        };
      };
    };
  };
}
