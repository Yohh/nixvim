{ lib, config, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "lir";
  packPathName = "lir.nvim";
  package = "lir-nvim";

  maintainers = [ lib.maintainers.GaetanLepage ];

  settingsExample = {
    show_hidden_files = true;
    devicons.enable = false;
    mappings = {
      "<CR>".__raw = "require('lir').actions.edit";
      "-".__raw = "require('lir').actions.up";
      "<ESC>".__raw = "require('lir').actions.quit";
      "@".__raw = "require('lir').actions.cd";
    };
    hide_cursor = true;
  };

  extraConfig = cfg: {
    warnings =
      lib.optional
        (
          (cfg.settings ? devicons.enable)
          && (lib.isBool cfg.settings.devicons.enable)
          && cfg.settings.devicons.enable
          && (!config.plugins.web-devicons.enable)
        )
        ''
          Nixvim (plugins.lir): You have enabled `settings.devicons.enable` but `plugins.web-devicons.enable` is `false`.
          Consider enabling the plugin for proper devicons support.
        '';
  };
}
