{ lib
, callPackage
, writeShellScriptBin
, beamPackages
, mix2nix
, fetchFromGitHub
, git
, cmake
, nixosTests
, mobilizon-frontend
, ...
}:

let
  inherit (beamPackages) mixRelease;
  common = callPackage ./common.nix { };
in
mixRelease rec {
  inherit (common) pname version src;

  nativeBuildInputs = [ git cmake ];

  mixNixDeps = import ./deps.nix {
    inherit beamPackages lib;
    overrides = (final: prev:
      (lib.mapAttrs
        (_: value: value.override {
          appConfigPath = src + "/config";
        })
        prev) // {
        fast_html = prev.fast_html.override {
          nativeBuildInputs = [ cmake ];
        };
        ex_cldr = prev.ex_cldr.overrideAttrs (old: {
          # We have to use the GitHub sources, as it otherwise tries to download
          # the locales at build time.
          src = fetchFromGitHub {
            owner = "elixir-cldr";
            repo = "cldr";
            rev = "v${old.version}";
            sha256 = assert old.version == "2.40.1";
              "sha256-tKxBMFMRSXK4y8N+aVaHfmO7yNYDXX2OVP3kwbgM+qk=";
          };
          postInstall = ''
            cp $src/priv/cldr/locales/* $out/lib/erlang/lib/ex_cldr-${old.version}/priv/cldr/locales/
          '';
        });
        # Upstream issue: https://github.com/bryanjos/geo_postgis/pull/87
        geo_postgis = prev.geo_postgis.overrideAttrs (old: {
          propagatedBuildInputs = old.propagatedBuildInputs ++ [ final.ecto ];
        });
      });
  };

  # Install the compiled js part
  preBuild = ''
    cp -a "${mobilizon-frontend}/static" ./priv
    chmod 770 -R ./priv
  '';

  # https://discourse.nixos.org/t/building-mix-project-fails-after-updating-dependencies/47830
  postBuild = ''
    mix do deps.loadpaths --no-deps-check, phx.digest
  '';

  passthru = {
    tests.smoke-test = nixosTests.mobilizon;
    updateScript = writeShellScriptBin "update.sh" ''
      set -eou pipefail

      ${mix2nix}/bin/mix2nix '${src}/mix.lock' > pkgs/servers/mobilizon/mix.nix
    '';
    elixirPackage = beamPackages.elixir;
  };

  meta = with lib; {
    description = "Mobilizon is an online tool to help manage your events, your profiles and your groups";
    homepage = "https://joinmobilizon.org/";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ minijackson erictapen ];
  };
}
