{config, lib, ...}:
let cfg = config.modules.services.mako;
in
{
  options.modules.services.mako = { enable = lib.mkEnableOption "mako, notices";};

  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;
      
    };
  };
} 
