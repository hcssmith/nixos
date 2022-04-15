{name, options, lib, ...}:
with lib;
{
  options = {
    id = mkOption {
      type = types.int;
      example = 0;
    };
    isDefault = mkOption {
      type = types.bool;
      default = false;
    };
    userChrome = mkOption {
      type = types.lines;
      default = "";
    };
    settings = mkOption {
      type = with types; attrsOf (either bool (either int str));
      default = { };
    };
  };
}
