shellfile=$PWD/etc/default.nix
depsdir="$PWD/.nix/$shellfile"
drvfile="$depsdir/shell.drv"

mkdir -p "$depsdir"
  # HACK: Set \`IN_NIX_SHELL=1'.
  #       Make nix believe that the instantiation happens in a nix-shell.
  #       This will trigger `pkgs.lib.inNixShell' to return true, which
  #       will automatically select the `env' attribute in cabal2nix
  #       generated shell descriptions.
IN_NIX_SHELL=1 nix-instantiate --add-root "$drvfile" --indirect "$shellfile"
nix-store -r $(nix-store --query --references "$drvfile") \
    --add-root "$depsdir/dep" --indirect
nix-shell "$drvfile"
