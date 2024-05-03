{
  description = "Mobilizon";

  inputs = {};

  outputs = { self }: {
    nixosModules.default = { ... }: {
      nixpkgs.overlays = [ (final: prev: {
        # copied from top-level/all-packages.nix
        mobilizon = prev.callPackage ./nix {
          elixir = prev.elixir_1_15;
          beamPackages = prev.beamPackages.extend (self: super: { elixir = prev.elixir_1_15; });
          mobilizon-frontend = prev.callPackage ./nix/frontend.nix { };
        };
      })];
    };
  };
}
