{ config, pkgs, home, lib, ...}:

rec {
  services.hypridle.settings = {
    general = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      ignore_systemd_inhibit = false;
      lock_cmd = "hyrplock";
    };

    listener = [
	{
	  timeout = 900;
	  on-timeout = "hyprlock";
	}
	{
	  timeout = 1200;
	  on-timeout = "hyprctl dispatch dpms off";
	  on-resume = "hyprctl dispatch dpms on";
	}
    ];
  };
}
