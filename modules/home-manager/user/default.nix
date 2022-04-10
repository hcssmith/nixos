{ name, options, lib,... }: 
with lib;
{
  options = {
    enable = mkEnableOption "Enable User";
    name = mkOption {
      type = with types; uniq string;
      description =
        "The name of the user account. If undefined, the name of the attribute set will be used.";
    };
    packages = mkOption {
      type = (types.listOf types.package);
      default = [ ];
    };
  };
}
