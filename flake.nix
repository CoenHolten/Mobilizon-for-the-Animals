{
  description = "Mobilizon";

  inputs = {};

  outputs = { self, nixpkgs }: {
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
    defaultPackage.x86_64-linux = 
      with import nixpkgs { system = "x86_64-linux"; };
      callPackage ./nix {
          elixir = elixir_1_15;
          beamPackages = beamPackages.extend (self: super: { elixir = elixir_1_15; });
          mobilizon-frontend = callPackage ./nix/frontend.nix { };
      };
  };
}
