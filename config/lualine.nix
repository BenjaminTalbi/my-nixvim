{
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    sections.lualine_c = [
      {
        name = "filename";
        extraConfig = {
          path = 1;
        };
      }
    ];
  };
}
