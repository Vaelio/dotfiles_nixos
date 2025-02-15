{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.tempdir-daemon;
in {
  options.services.tempdir-daemon = {
    enable = mkEnableOption "tempdir-daemon service";
    socket_path = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
  };

  
  config = mkIf cfg.enable {
    systemd.user.services.tempdir-daemon = {
      Service.ExecStart = ''${pkgs.nix}/bin/nix run https://gitlab.com/vaelio/tempdir-daemon/-/archive/main/tempdir-daemon-main.zip --''
                                + " daemonize "
                                + (optionalString (cfg.socket_path != null) cfg.socket_path);
      Service.ExecStop = ''${pkgs.nix}/bin/nix run https://gitlab.com/vaelio/tempdir-daemon/-/archive/main/tempdir-daemon-main.zip --''
                                + " terminate ";
      Install = { WantedBy = [ "default.target" ]; };
    };
  };

}
