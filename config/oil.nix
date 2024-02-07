{
  plugins.oil = {
    enable = true;
    viewOptions.showHidden = true;
  };
  keymaps = [
    {
      action = ":Oil<CR>";
      key = "<leader>O";
    }
    {
      action = ":Oil --float<CR>";
      key = "<leader>o";
    }
  ];
}
