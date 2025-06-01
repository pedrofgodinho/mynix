{ pkgs, lib, config, myUsername, host, inputs, ... }:

{
  home.packages = with pkgs; [
    # Shell
    nerd-fonts.fira-code
  ];

  programs.nushell = {
    enable = true;
    extraConfig = ''
      let carapace_completer = {|spans|
      carapace $spans.0 nushell ...$spans | from json
      }
      $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100
            completer: $carapace_completer # check 'carapace_completer'
          }
        }
      }
      $env.PATH = ($env.PATH |
      split row (char esep) |
      prepend ($env.HOME | path join ".apps") |
      append /usr/bin/env
      )
    '';
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "family=\"FiraCode Nerd Font\"";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      shell = "${pkgs.nushell}/bin/nu";
      font_size = 12.0;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
    };
  };
}
