{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "test" ''
      echo "test"
    '')
  ];
}
