{
    config,
    lib,
    ...
}:
# Need to make it str not bool
{
    imports = [
        ./gnome.nix
        ./hypr.nix
        ./niri.nix
    ];
}
