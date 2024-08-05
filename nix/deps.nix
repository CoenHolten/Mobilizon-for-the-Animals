{ lib, beamPackages, overrides ? (x: y: { }) }:

let
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;

  defaultOverrides = (final: prev:

    let
      apps = { };

      workarounds = { };

      applyOverrides = appName: drv:
        let
          allOverridesForApp = builtins.foldl'
            (acc: workaround: acc // workarounds.${workaround} drv)
            { }
            apps.${appName};

        in
        if builtins.hasAttr appName apps
        then
          drv.override allOverridesForApp
        else
          drv;

    in
    builtins.mapAttrs applyOverrides prev);

  self = packages // (defaultOverrides self packages) // (overrides self packages);

  packages = with beamPackages; with self; {
    absinthe =
      let
        version = "1.7.8";
      in
      buildMix {
        inherit version;
        name = "absinthe";

        src = fetchHex {
          inherit version;
          pkg = "absinthe";
          sha256 = "c4085df201892a498384f997649aedb37a4ce8a726c170d5b5617ed3bf45d40b";
        };

        beamDeps = [ dataloader decimal nimble_parsec telemetry ];
      };

    absinthe_phoenix =
      let
        version = "2.0.3";
      in
      buildMix {
        inherit version;
        name = "absinthe_phoenix";

        src = fetchHex {
          inherit version;
          pkg = "absinthe_phoenix";
          sha256 = "caffaea03c17ea7419fe07e4bc04c2399c47f0d8736900623dbf4749a826fd2c";
        };

        beamDeps = [ absinthe absinthe_plug decimal phoenix phoenix_html phoenix_pubsub ];
      };

    absinthe_plug =
      let
        version = "1.5.8";
      in
      buildMix {
        inherit version;
        name = "absinthe_plug";

        src = fetchHex {
          inherit version;
          pkg = "absinthe_plug";
          sha256 = "bbb04176647b735828861e7b2705465e53e2cf54ccf5a73ddd1ebd855f996e5a";
        };

        beamDeps = [ absinthe plug ];
      };

    argon2_elixir =
      let
        version = "4.0.0";
      in
      buildMix {
        inherit version;
        name = "argon2_elixir";

        src = fetchHex {
          inherit version;
          pkg = "argon2_elixir";
          sha256 = "f9da27cf060c9ea61b1bd47837a28d7e48a8f6fa13a745e252556c14f9132c7f";
        };

        beamDeps = [ comeonin elixir_make ];
      };

    atomex =
      let
        version = "0.4.1";
      in
      buildMix {
        inherit version;
        name = "atomex";

        src = fetchHex {
          inherit version;
          pkg = "atomex";
          sha256 = "f3ac737f7493d42cfddf917f3ac49d60e0a0cf1a35c0712851b07fe8c0a05c7a";
        };

        beamDeps = [ xml_builder ];
      };

    bandit =
      let
        version = "1.5.7";
      in
      buildMix {
        inherit version;
        name = "bandit";

        src = fetchHex {
          inherit version;
          pkg = "bandit";
          sha256 = "f2dd92ae87d2cbea2fa9aa1652db157b6cba6c405cb44d4f6dd87abba41371cd";
        };

        beamDeps = [ hpax plug telemetry thousand_island websock ];
      };

    cachex =
      let
        version = "3.6.0";
      in
      buildMix {
        inherit version;
        name = "cachex";

        src = fetchHex {
          inherit version;
          pkg = "cachex";
          sha256 = "ebf24e373883bc8e0c8d894a63bbe102ae13d918f790121f5cfe6e485cc8e2e2";
        };

        beamDeps = [ eternal jumper sleeplocks unsafe ];
      };

    castore =
      let
        version = "1.0.8";
      in
      buildMix {
        inherit version;
        name = "castore";

        src = fetchHex {
          inherit version;
          pkg = "castore";
          sha256 = "0b2b66d2ee742cb1d9cb8c8be3b43c3a70ee8651f37b75a8b982e036752983f1";
        };
      };

    certifi =
      let
        version = "2.12.0";
      in
      buildRebar3 {
        inherit version;
        name = "certifi";

        src = fetchHex {
          inherit version;
          pkg = "certifi";
          sha256 = "ee68d85df22e554040cdb4be100f33873ac6051387baf6a8f6ce82272340ff1c";
        };
      };

    cldr_utils =
      let
        version = "2.28.0";
      in
      buildMix {
        inherit version;
        name = "cldr_utils";

        src = fetchHex {
          inherit version;
          pkg = "cldr_utils";
          sha256 = "e7ac4bcea0fdbc11b5295ef30dd7b18d0922512399361af06a97198e57d23742";
        };

        beamDeps = [ castore certifi decimal ];
      };

    codepagex =
      let
        version = "0.1.6";
      in
      buildMix {
        inherit version;
        name = "codepagex";

        src = fetchHex {
          inherit version;
          pkg = "codepagex";
          sha256 = "1521461097dde281edf084062f525a4edc6a5e49f4fd1f5ec41c9c4955d5bd59";
        };
      };

    combine =
      let
        version = "0.10.0";
      in
      buildMix {
        inherit version;
        name = "combine";

        src = fetchHex {
          inherit version;
          pkg = "combine";
          sha256 = "1b1dbc1790073076580d0d1d64e42eae2366583e7aecd455d1215b0d16f2451b";
        };
      };

    comeonin =
      let
        version = "5.4.0";
      in
      buildMix {
        inherit version;
        name = "comeonin";

        src = fetchHex {
          inherit version;
          pkg = "comeonin";
          sha256 = "796393a9e50d01999d56b7b8420ab0481a7538d0caf80919da493b4a6e51faf1";
        };
      };

    cors_plug =
      let
        version = "3.0.3";
      in
      buildMix {
        inherit version;
        name = "cors_plug";

        src = fetchHex {
          inherit version;
          pkg = "cors_plug";
          sha256 = "3f2d759e8c272ed3835fab2ef11b46bddab8c1ab9528167bd463b6452edf830d";
        };

        beamDeps = [ plug ];
      };

    dataloader =
      let
        version = "2.0.0";
      in
      buildMix {
        inherit version;
        name = "dataloader";

        src = fetchHex {
          inherit version;
          pkg = "dataloader";
          sha256 = "09d61781b76ce216e395cdbc883ff00d00f46a503e215c22722dba82507dfef0";
        };

        beamDeps = [ ecto telemetry ];
      };

    db_connection =
      let
        version = "2.7.0";
      in
      buildMix {
        inherit version;
        name = "db_connection";

        src = fetchHex {
          inherit version;
          pkg = "db_connection";
          sha256 = "dcf08f31b2701f857dfc787fbad78223d61a32204f217f15e881dd93e4bdd3ff";
        };

        beamDeps = [ telemetry ];
      };

    decimal =
      let
        version = "2.1.1";
      in
      buildMix {
        inherit version;
        name = "decimal";

        src = fetchHex {
          inherit version;
          pkg = "decimal";
          sha256 = "53cfe5f497ed0e7771ae1a475575603d77425099ba5faef9394932b35020ffcc";
        };
      };

    digital_token =
      let
        version = "0.6.0";
      in
      buildMix {
        inherit version;
        name = "digital_token";

        src = fetchHex {
          inherit version;
          pkg = "digital_token";
          sha256 = "2455d626e7c61a128b02a4a8caddb092548c3eb613ac6f6a85e4cbb6caddc4d1";
        };

        beamDeps = [ cldr_utils jason ];
      };

    eblurhash =
      let
        version = "1.2.2";
      in
      buildRebar3 {
        inherit version;
        name = "eblurhash";

        src = fetchHex {
          inherit version;
          pkg = "eblurhash";
          sha256 = "8c20ca00904de023a835a9dcb7b7762fed32264c85a80c3cafa85288e405044c";
        };
      };

    ecto =
      let
        version = "3.11.2";
      in
      buildMix {
        inherit version;
        name = "ecto";

        src = fetchHex {
          inherit version;
          pkg = "ecto";
          sha256 = "3c38bca2c6f8d8023f2145326cc8a80100c3ffe4dcbd9842ff867f7fc6156c65";
        };

        beamDeps = [ decimal jason telemetry ];
      };

    ecto_autoslug_field =
      let
        version = "3.1.0";
      in
      buildMix {
        inherit version;
        name = "ecto_autoslug_field";

        src = fetchHex {
          inherit version;
          pkg = "ecto_autoslug_field";
          sha256 = "b6ddd614805263e24b5c169532c934440d0289181cce873061fca3a8e92fd9ff";
        };

        beamDeps = [ ecto slugify ];
      };

    ecto_dev_logger =
      let
        version = "0.7.2";
      in
      buildMix {
        inherit version;
        name = "ecto_dev_logger";

        src = fetchHex {
          inherit version;
          pkg = "ecto_dev_logger";
          sha256 = "139dee38a77cc554fefcb72ccab880b3312589527afc4780cff1478b69402bfa";
        };

        beamDeps = [ ecto jason ];
      };

    ecto_enum =
      let
        version = "1.4.0";
      in
      buildMix {
        inherit version;
        name = "ecto_enum";

        src = fetchHex {
          inherit version;
          pkg = "ecto_enum";
          sha256 = "8fb55c087181c2b15eee406519dc22578fa60dd82c088be376d0010172764ee4";
        };

        beamDeps = [ ecto ecto_sql postgrex ];
      };

    ecto_shortuuid =
      let
        version = "0.1.5";
      in
      buildMix {
        inherit version;
        name = "ecto_shortuuid";

        src = fetchHex {
          inherit version;
          pkg = "ecto_shortuuid";
          sha256 = "c998a0569a17b42ee3e7e68f264c3bb0db8f6e587d4ae99a740df883695196dc";
        };

        beamDeps = [ ecto shortuuid ];
      };

    ecto_sql =
      let
        version = "3.11.3";
      in
      buildMix {
        inherit version;
        name = "ecto_sql";

        src = fetchHex {
          inherit version;
          pkg = "ecto_sql";
          sha256 = "e5f36e3d736b99c7fee3e631333b8394ade4bafe9d96d35669fca2d81c2be928";
        };

        beamDeps = [ db_connection ecto postgrex telemetry ];
      };

    elixir_make =
      let
        version = "0.8.4";
      in
      buildMix {
        inherit version;
        name = "elixir_make";

        src = fetchHex {
          inherit version;
          pkg = "elixir_make";
          sha256 = "6e7f1d619b5f61dfabd0a20aa268e575572b542ac31723293a4c1a567d5ef040";
        };

        beamDeps = [ castore certifi ];
      };

    erlport =
      let
        version = "0.11.0";
      in
      buildRebar3 {
        inherit version;
        name = "erlport";

        src = fetchHex {
          inherit version;
          pkg = "erlport";
          sha256 = "8eb136ccaf3948d329b8d1c3278ad2e17e2a7319801bc4cc2da6db278204eee4";
        };
      };

    eternal =
      let
        version = "1.2.2";
      in
      buildMix {
        inherit version;
        name = "eternal";

        src = fetchHex {
          inherit version;
          pkg = "eternal";
          sha256 = "2c9fe32b9c3726703ba5e1d43a1d255a4f3f2d8f8f9bc19f094c7cb1a7a9e782";
        };
      };

    ex_cldr =
      let
        version = "2.40.0";
      in
      buildMix {
        inherit version;
        name = "ex_cldr";

        src = fetchHex {
          inherit version;
          pkg = "ex_cldr";
          sha256 = "113394b6dd23aaf7912da583aab103d9cf082b9821bc4a6e287543a895af7cb4";
        };

        beamDeps = [ cldr_utils decimal gettext jason nimble_parsec ];
      };

    ex_cldr_calendars =
      let
        version = "1.26.0";
      in
      buildMix {
        inherit version;
        name = "ex_cldr_calendars";

        src = fetchHex {
          inherit version;
          pkg = "ex_cldr_calendars";
          sha256 = "6ace2824ae10c3f456714f031a5de168da05253baf9119582c87b2daa823af46";
        };

        beamDeps = [ ex_cldr_numbers jason ];
      };

    ex_cldr_currencies =
      let
        version = "2.16.2";
      in
      buildMix {
        inherit version;
        name = "ex_cldr_currencies";

        src = fetchHex {
          inherit version;
          pkg = "ex_cldr_currencies";
          sha256 = "2ccfac2838f4df8c8e5424dbc68eb2f3ac9eeb45e10365050901f7ac7a914ce1";
        };

        beamDeps = [ ex_cldr jason ];
      };

    ex_cldr_dates_times =
      let
        version = "2.20.2";
      in
      buildMix {
        inherit version;
        name = "ex_cldr_dates_times";

        src = fetchHex {
          inherit version;
          pkg = "ex_cldr_dates_times";
          sha256 = "b15fdab0fdf38c2e85dac861c53995408bdb07ac20ab12dd464dad45ed57bc2f";
        };

        beamDeps = [ ex_cldr ex_cldr_calendars jason ];
      };

    ex_cldr_languages =
      let
        version = "0.3.3";
      in
      buildMix {
        inherit version;
        name = "ex_cldr_languages";

        src = fetchHex {
          inherit version;
          pkg = "ex_cldr_languages";
          sha256 = "22fb1fef72b7b4b4872d243b34e7b83734247a78ad87377986bf719089cc447a";
        };

        beamDeps = [ ex_cldr jason ];
      };

    ex_cldr_numbers =
      let
        version = "2.33.2";
      in
      buildMix {
        inherit version;
        name = "ex_cldr_numbers";

        src = fetchHex {
          inherit version;
          pkg = "ex_cldr_numbers";
          sha256 = "49f1dbaddc1ad6e3f496a97fa425d25b3ae89e8178ce0416d9909deaf2e5ad80";
        };

        beamDeps = [ decimal digital_token ex_cldr ex_cldr_currencies jason ];
      };

    ex_cldr_plugs =
      let
        version = "1.3.3";
      in
      buildMix {
        inherit version;
        name = "ex_cldr_plugs";

        src = fetchHex {
          inherit version;
          pkg = "ex_cldr_plugs";
          sha256 = "23ebfa8d7a9991b71515c865ddf00099c9a23425767fb5dcbbca636df4aaeaab";
        };

        beamDeps = [ ex_cldr gettext jason plug ];
      };

    ex_ical =
      let
        version = "0.2.0";
      in
      buildMix {
        inherit version;
        name = "ex_ical";

        src = fetchHex {
          inherit version;
          pkg = "ex_ical";
          sha256 = "db76473b2ae0259e6633c6c479a5a4d8603f09497f55c88f9ef4d53d2b75befb";
        };

        beamDeps = [ timex ];
      };

    ex_optimizer =
      let
        version = "0.1.1";
      in
      buildMix {
        inherit version;
        name = "ex_optimizer";

        src = fetchHex {
          inherit version;
          pkg = "ex_optimizer";
          sha256 = "e6f5c059bcd58b66be2f6f257fdc4f69b74b0fa5c9ddd669486af012e4b52286";
        };

        beamDeps = [ file_info ];
      };

    exgravatar =
      let
        version = "2.0.3";
      in
      buildMix {
        inherit version;
        name = "exgravatar";

        src = fetchHex {
          inherit version;
          pkg = "exgravatar";
          sha256 = "aca18ff9bd8991d3be3e5446d3bdefc051be084c1ffc9ab2d43b3e65339300e1";
        };
      };

    exkismet =
      let
        version = "8b5485fde00fafbde20f315bec387a77f7358334";
      in
      buildMix {
        inherit version;
        name = "exkismet";

        src = builtins.fetchGit {
          url = "https://github.com/tcitworld/exkismet.git";
          rev = "8b5485fde00fafbde20f315bec387a77f7358334";
        };

        beamDeps = [ httpoison ];
      };

    expo =
      let
        version = "0.5.2";
      in
      buildMix {
        inherit version;
        name = "expo";

        src = fetchHex {
          inherit version;
          pkg = "expo";
          sha256 = "8c9bfa06ca017c9cb4020fabe980bc7fdb1aaec059fd004c2ab3bff03b1c599c";
        };
      };

    export =
      let
        version = "0.1.1";
      in
      buildMix {
        inherit version;
        name = "export";

        src = fetchHex {
          inherit version;
          pkg = "export";
          sha256 = "3da7444ff4053f1824352f4bdb13fbd2c28c93c2011786fb686b649fdca1021f";
        };

        beamDeps = [ erlport ];
      };

    fast_html =
      let
        version = "1.0.3";
      in
      buildMix {
        inherit version;
        name = "fast_html";

        src = fetchHex {
          inherit version;
          pkg = "fast_html";
          sha256 = "ab3d782b639d3c4655fbaec0f9d032c91f8cab8dd791ac7469c2381bc7c32f85";
        };
      };

    fast_sanitize =
      let
        version = "0.1.7";
      in
      buildMix {
        inherit version;
        name = "fast_sanitize";

        src = fetchHex {
          inherit version;
          pkg = "fast_sanitize";
          sha256 = "f39fe8ea08fbac17487c30bf09b7d9f3e12472e51fb07a88ffeb8fd17da8ab67";
        };

        beamDeps = [ fast_html plug ];
      };

    file_info =
      let
        version = "0.0.4";
      in
      buildMix {
        inherit version;
        name = "file_info";

        src = fetchHex {
          inherit version;
          pkg = "file_info";
          sha256 = "50e7ad01c2c8b9339010675fe4dc4a113b8d6ca7eddce24d1d74fd0e762781a5";
        };

        beamDeps = [ mimetype_parser ];
      };

    floki =
      let
        version = "0.31.0";
      in
      buildMix {
        inherit version;
        name = "floki";

        src = fetchHex {
          inherit version;
          pkg = "floki";
          sha256 = "b05afa372f5c345a5bf240ac25ea1f0f3d5fcfd7490ac0beeb4a203f9444891e";
        };

        beamDeps = [ html_entities ];
      };

    gen_smtp =
      let
        version = "1.2.0";
      in
      buildRebar3 {
        inherit version;
        name = "gen_smtp";

        src = fetchHex {
          inherit version;
          pkg = "gen_smtp";
          sha256 = "5ee0375680bca8f20c4d85f58c2894441443a743355430ff33a783fe03296779";
        };

        beamDeps = [ ranch ];
      };

    geo =
      let
        version = "3.6.0";
      in
      buildMix {
        inherit version;
        name = "geo";

        src = fetchHex {
          inherit version;
          pkg = "geo";
          sha256 = "1dbdebf617183b54bc3c8ad7a36531a9a76ada8ca93f75f573b0ae94006168da";
        };

        beamDeps = [ jason ];
      };

    geo_postgis =
      let
        version = "3.7.0";
      in
      buildMix {
        inherit version;
        name = "geo_postgis";

        src = fetchHex {
          inherit version;
          pkg = "geo_postgis";
          sha256 = "e4e692c515d7d92381e7d0256f1bb7f8fe8760a254b7cd0c37a19c8f4a397904";
        };

        beamDeps = [ ecto geo jason postgrex ];
      };

    geohax =
      let
        version = "1.0.2";
      in
      buildMix {
        inherit version;
        name = "geohax";

        src = fetchHex {
          inherit version;
          pkg = "geohax";
          sha256 = "4c782de1e1ee781e2fa07ba6ebfbfb66b91c215b901073defe6196184b8b60a4";
        };
      };

    geolix =
      let
        version = "2.0.0";
      in
      buildMix {
        inherit version;
        name = "geolix";

        src = fetchHex {
          inherit version;
          pkg = "geolix";
          sha256 = "8742bf588ed0bb7def2c443204d09d355990846c6efdff96ded66aac24c301df";
        };
      };

    geolix_adapter_mmdb2 =
      let
        version = "0.6.0";
      in
      buildMix {
        inherit version;
        name = "geolix_adapter_mmdb2";

        src = fetchHex {
          inherit version;
          pkg = "geolix_adapter_mmdb2";
          sha256 = "06ff962feae8a310cffdf86b74bfcda6e2d0dccb439bb1f62df2b657b1c0269b";
        };

        beamDeps = [ geolix mmdb2_decoder ];
      };

    gettext =
      let
        version = "0.24.0";
      in
      buildMix {
        inherit version;
        name = "gettext";

        src = fetchHex {
          inherit version;
          pkg = "gettext";
          sha256 = "bdf75cdfcbe9e4622dd18e034b227d77dd17f0f133853a1c73b97b3d6c770e8b";
        };

        beamDeps = [ expo ];
      };

    guardian =
      let
        version = "2.3.2";
      in
      buildMix {
        inherit version;
        name = "guardian";

        src = fetchHex {
          inherit version;
          pkg = "guardian";
          sha256 = "b189ff38cd46a22a8a824866a6867ca8722942347f13c33f7d23126af8821b52";
        };

        beamDeps = [ jose plug ];
      };

    guardian_db =
      let
        version = "3.0.0";
      in
      buildMix {
        inherit version;
        name = "guardian_db";

        src = fetchHex {
          inherit version;
          pkg = "guardian_db";
          sha256 = "9c2ec4278efa34f9f1cc6ba795e552d41fdc7ffba5319d67eeb533b89392d183";
        };

        beamDeps = [ ecto ecto_sql guardian postgrex ];
      };

    guardian_phoenix =
      let
        version = "2.0.1";
      in
      buildMix {
        inherit version;
        name = "guardian_phoenix";

        src = fetchHex {
          inherit version;
          pkg = "guardian_phoenix";
          sha256 = "21f439246715192b231f228680465d1ed5fbdf01555a4a3b17165532f5f9a08c";
        };

        beamDeps = [ guardian phoenix ];
      };

    hackney =
      let
        version = "1.20.1";
      in
      buildRebar3 {
        inherit version;
        name = "hackney";

        src = fetchHex {
          inherit version;
          pkg = "hackney";
          sha256 = "fe9094e5f1a2a2c0a7d10918fee36bfec0ec2a979994cff8cfe8058cd9af38e3";
        };

        beamDeps = [ certifi idna metrics mimerl parse_trans ssl_verify_fun unicode_util_compat ];
      };

    hammer =
      let
        version = "6.2.1";
      in
      buildMix {
        inherit version;
        name = "hammer";

        src = fetchHex {
          inherit version;
          pkg = "hammer";
          sha256 = "b9476d0c13883d2dc0cc72e786bac6ac28911fba7cc2e04b70ce6a6d9c4b2bdc";
        };

        beamDeps = [ poolboy ];
      };

    haversine =
      let
        version = "0.1.0";
      in
      buildMix {
        inherit version;
        name = "haversine";

        src = fetchHex {
          inherit version;
          pkg = "haversine";
          sha256 = "54dc48e895bc18a59437a37026c873634e17b648a64cb87bfafb96f64d607060";
        };
      };

    hpax =
      let
        version = "1.0.0";
      in
      buildMix {
        inherit version;
        name = "hpax";

        src = fetchHex {
          inherit version;
          pkg = "hpax";
          sha256 = "7f1314731d711e2ca5fdc7fd361296593fc2542570b3105595bb0bc6d0fad601";
        };
      };

    html_entities =
      let
        version = "0.5.2";
      in
      buildMix {
        inherit version;
        name = "html_entities";

        src = fetchHex {
          inherit version;
          pkg = "html_entities";
          sha256 = "c53ba390403485615623b9531e97696f076ed415e8d8058b1dbaa28181f4fdcc";
        };
      };

    http_signatures =
      let
        version = "0.1.2";
      in
      buildMix {
        inherit version;
        name = "http_signatures";

        src = fetchHex {
          inherit version;
          pkg = "http_signatures";
          sha256 = "f08aa9ac121829dae109d608d83c84b940ef2f183ae50f2dd1e9a8bc619d8be7";
        };
      };

    httpoison =
      let
        version = "1.8.2";
      in
      buildMix {
        inherit version;
        name = "httpoison";

        src = fetchHex {
          inherit version;
          pkg = "httpoison";
          sha256 = "2bb350d26972e30c96e2ca74a1aaf8293d61d0742ff17f01e0279fef11599921";
        };

        beamDeps = [ hackney ];
      };

    icalendar =
      let
        version = "1033d922c82a7223db0ec138e2316557b70ff49f";
      in
      buildMix {
        inherit version;
        name = "icalendar";

        src = builtins.fetchGit {
          url = "https://github.com/tcitworld/icalendar.git";
          rev = "1033d922c82a7223db0ec138e2316557b70ff49f";
        };

        beamDeps = [ timex ];
      };

    idna =
      let
        version = "6.1.1";
      in
      buildRebar3 {
        inherit version;
        name = "idna";

        src = fetchHex {
          inherit version;
          pkg = "idna";
          sha256 = "92376eb7894412ed19ac475e4a86f7b413c1b9fbb5bd16dccd57934157944cea";
        };

        beamDeps = [ unicode_util_compat ];
      };

    inet_cidr =
      let
        version = "1.0.8";
      in
      buildMix {
        inherit version;
        name = "inet_cidr";

        src = fetchHex {
          inherit version;
          pkg = "inet_cidr";
          sha256 = "d5b26da66603bb56c933c65214c72152f0de9a6ea53618b56d63302a68f6a90e";
        };
      };

    ip_reserved =
      let
        version = "0.1.1";
      in
      buildMix {
        inherit version;
        name = "ip_reserved";

        src = fetchHex {
          inherit version;
          pkg = "ip_reserved";
          sha256 = "55fcd2b6e211caef09ea3f54ef37d43030bec486325d12fe865ab5ed8140a4fe";
        };

        beamDeps = [ inet_cidr ];
      };

    jason =
      let
        version = "1.4.4";
      in
      buildMix {
        inherit version;
        name = "jason";

        src = fetchHex {
          inherit version;
          pkg = "jason";
          sha256 = "c5eb0cab91f094599f94d55bc63409236a8ec69a21a67814529e8d5f6cc90b3b";
        };

        beamDeps = [ decimal ];
      };

    jose =
      let
        version = "1.11.10";
      in
      buildMix {
        inherit version;
        name = "jose";

        src = fetchHex {
          inherit version;
          pkg = "jose";
          sha256 = "0d6cd36ff8ba174db29148fc112b5842186b68a90ce9fc2b3ec3afe76593e614";
        };
      };

    jumper =
      let
        version = "1.0.2";
      in
      buildMix {
        inherit version;
        name = "jumper";

        src = fetchHex {
          inherit version;
          pkg = "jumper";
          sha256 = "9b7782409021e01ab3c08270e26f36eb62976a38c1aa64b2eaf6348422f165e1";
        };
      };

    linkify =
      let
        version = "0.3.0";
      in
      buildMix {
        inherit version;
        name = "linkify";

        src = fetchHex {
          inherit version;
          pkg = "linkify";
          sha256 = "47e6a6e2c98815b238017331c3fbcf04aaa0644e323e6c260ee0111ed43f696c";
        };
      };

    metrics =
      let
        version = "1.0.1";
      in
      buildRebar3 {
        inherit version;
        name = "metrics";

        src = fetchHex {
          inherit version;
          pkg = "metrics";
          sha256 = "69b09adddc4f74a40716ae54d140f93beb0fb8978d8636eaded0c31b6f099f16";
        };
      };

    mime =
      let
        version = "2.0.6";
      in
      buildMix {
        inherit version;
        name = "mime";

        src = fetchHex {
          inherit version;
          pkg = "mime";
          sha256 = "c9945363a6b26d747389aac3643f8e0e09d30499a138ad64fe8fd1d13d9b153e";
        };
      };

    mimerl =
      let
        version = "1.3.0";
      in
      buildRebar3 {
        inherit version;
        name = "mimerl";

        src = fetchHex {
          inherit version;
          pkg = "mimerl";
          sha256 = "a1e15a50d1887217de95f0b9b0793e32853f7c258a5cd227650889b38839fe9d";
        };
      };

    mimetype_parser =
      let
        version = "0.1.3";
      in
      buildMix {
        inherit version;
        name = "mimetype_parser";

        src = fetchHex {
          inherit version;
          pkg = "mimetype_parser";
          sha256 = "7d8f80c567807ce78cd93c938e7f4b0a20b1aaaaab914bf286f68457d9f7a852";
        };
      };

    mmdb2_decoder =
      let
        version = "3.0.1";
      in
      buildMix {
        inherit version;
        name = "mmdb2_decoder";

        src = fetchHex {
          inherit version;
          pkg = "mmdb2_decoder";
          sha256 = "316af0f388fac824782d944f54efe78e7c9691bbbdb0afd5cccdd0510adf559d";
        };
      };

    mogrify =
      let
        version = "0.9.3";
      in
      buildMix {
        inherit version;
        name = "mogrify";

        src = fetchHex {
          inherit version;
          pkg = "mogrify";
          sha256 = "0189b1e1de27455f2b9ae8cf88239cefd23d38de9276eb5add7159aea51731e6";
        };
      };

    nimble_csv =
      let
        version = "1.2.0";
      in
      buildMix {
        inherit version;
        name = "nimble_csv";

        src = fetchHex {
          inherit version;
          pkg = "nimble_csv";
          sha256 = "d0628117fcc2148178b034044c55359b26966c6eaa8e2ce15777be3bbc91b12a";
        };
      };

    nimble_parsec =
      let
        version = "1.4.0";
      in
      buildMix {
        inherit version;
        name = "nimble_parsec";

        src = fetchHex {
          inherit version;
          pkg = "nimble_parsec";
          sha256 = "9c565862810fb383e9838c1dd2d7d2c437b3d13b267414ba6af33e50d2d1cf28";
        };
      };

    oauth2 =
      let
        version = "2.1.0";
      in
      buildMix {
        inherit version;
        name = "oauth2";

        src = fetchHex {
          inherit version;
          pkg = "oauth2";
          sha256 = "8ac07f85b3307dd1acfeb0ec852f64161b22f57d0ce0c15e616a1dfc8ebe2b41";
        };

        beamDeps = [ tesla ];
      };

    oauther =
      let
        version = "1.3.0";
      in
      buildMix {
        inherit version;
        name = "oauther";

        src = fetchHex {
          inherit version;
          pkg = "oauther";
          sha256 = "78eb888ea875c72ca27b0864a6f550bc6ee84f2eeca37b093d3d833fbcaec04e";
        };
      };

    oban =
      let
        version = "2.18.0";
      in
      buildMix {
        inherit version;
        name = "oban";

        src = fetchHex {
          inherit version;
          pkg = "oban";
          sha256 = "aace1eff6f8227ae38d4274af967d96f051c2f0a5152f2ef9809dd1f97866745";
        };

        beamDeps = [ ecto_sql jason postgrex telemetry ];
      };

    paasaa =
      let
        version = "0.6.0";
      in
      buildMix {
        inherit version;
        name = "paasaa";

        src = fetchHex {
          inherit version;
          pkg = "paasaa";
          sha256 = "732ddfc21bac0831edb26aec468af3ec2b8997d74f6209810b1cc53199c29f2e";
        };
      };

    parse_trans =
      let
        version = "3.4.1";
      in
      buildRebar3 {
        inherit version;
        name = "parse_trans";

        src = fetchHex {
          inherit version;
          pkg = "parse_trans";
          sha256 = "620a406ce75dada827b82e453c19cf06776be266f5a67cff34e1ef2cbb60e49a";
        };
      };

    phoenix =
      let
        version = "1.7.14";
      in
      buildMix {
        inherit version;
        name = "phoenix";

        src = fetchHex {
          inherit version;
          pkg = "phoenix";
          sha256 = "c7859bc56cc5dfef19ecfc240775dae358cbaa530231118a9e014df392ace61a";
        };

        beamDeps = [ castore jason phoenix_pubsub phoenix_template phoenix_view plug plug_crypto telemetry websock_adapter ];
      };

    phoenix_ecto =
      let
        version = "4.6.2";
      in
      buildMix {
        inherit version;
        name = "phoenix_ecto";

        src = fetchHex {
          inherit version;
          pkg = "phoenix_ecto";
          sha256 = "3f94d025f59de86be00f5f8c5dd7b5965a3298458d21ab1c328488be3b5fcd59";
        };

        beamDeps = [ ecto phoenix_html plug postgrex ];
      };

    phoenix_html =
      let
        version = "3.3.4";
      in
      buildMix {
        inherit version;
        name = "phoenix_html";

        src = fetchHex {
          inherit version;
          pkg = "phoenix_html";
          sha256 = "0249d3abec3714aff3415e7ee3d9786cb325be3151e6c4b3021502c585bf53fb";
        };

        beamDeps = [ plug ];
      };

    phoenix_live_view =
      let
        version = "0.20.12";
      in
      buildMix {
        inherit version;
        name = "phoenix_live_view";

        src = fetchHex {
          inherit version;
          pkg = "phoenix_live_view";
          sha256 = "ae3a143cc33325f3a4c192b7da1726e6665e154c50e1461af4cd7d561ccfd9ab";
        };

        beamDeps = [ jason phoenix phoenix_html phoenix_template phoenix_view plug telemetry ];
      };

    phoenix_pubsub =
      let
        version = "2.1.3";
      in
      buildMix {
        inherit version;
        name = "phoenix_pubsub";

        src = fetchHex {
          inherit version;
          pkg = "phoenix_pubsub";
          sha256 = "bba06bc1dcfd8cb086759f0edc94a8ba2bc8896d5331a1e2c2902bf8e36ee502";
        };
      };

    phoenix_swoosh =
      let
        version = "1.2.1";
      in
      buildMix {
        inherit version;
        name = "phoenix_swoosh";

        src = fetchHex {
          inherit version;
          pkg = "phoenix_swoosh";
          sha256 = "4000eeba3f9d7d1a6bf56d2bd56733d5cadf41a7f0d8ffe5bb67e7d667e204a2";
        };

        beamDeps = [ hackney phoenix phoenix_html phoenix_view swoosh ];
      };

    phoenix_template =
      let
        version = "1.0.4";
      in
      buildMix {
        inherit version;
        name = "phoenix_template";

        src = fetchHex {
          inherit version;
          pkg = "phoenix_template";
          sha256 = "2c0c81f0e5c6753faf5cca2f229c9709919aba34fab866d3bc05060c9c444206";
        };

        beamDeps = [ phoenix_html ];
      };

    phoenix_view =
      let
        version = "2.0.4";
      in
      buildMix {
        inherit version;
        name = "phoenix_view";

        src = fetchHex {
          inherit version;
          pkg = "phoenix_view";
          sha256 = "4e992022ce14f31fe57335db27a28154afcc94e9983266835bb3040243eb620b";
        };

        beamDeps = [ phoenix_html phoenix_template ];
      };

    plug =
      let
        version = "1.16.1";
      in
      buildMix {
        inherit version;
        name = "plug";

        src = fetchHex {
          inherit version;
          pkg = "plug";
          sha256 = "a13ff6b9006b03d7e33874945b2755253841b238c34071ed85b0e86057f8cddc";
        };

        beamDeps = [ mime plug_crypto telemetry ];
      };

    plug_crypto =
      let
        version = "2.1.0";
      in
      buildMix {
        inherit version;
        name = "plug_crypto";

        src = fetchHex {
          inherit version;
          pkg = "plug_crypto";
          sha256 = "131216a4b030b8f8ce0f26038bc4421ae60e4bb95c5cf5395e1421437824c4fa";
        };
      };

    poolboy =
      let
        version = "1.5.2";
      in
      buildRebar3 {
        inherit version;
        name = "poolboy";

        src = fetchHex {
          inherit version;
          pkg = "poolboy";
          sha256 = "dad79704ce5440f3d5a3681c8590b9dc25d1a561e8f5a9c995281012860901e3";
        };
      };

    postgrex =
      let
        version = "0.19.0";
      in
      buildMix {
        inherit version;
        name = "postgrex";

        src = fetchHex {
          inherit version;
          pkg = "postgrex";
          sha256 = "dba2d2a0a8637defbf2307e8629cb2526388ba7348f67d04ec77a5d6a72ecfae";
        };

        beamDeps = [ db_connection decimal jason ];
      };

    progress_bar =
      let
        version = "3.0.0";
      in
      buildMix {
        inherit version;
        name = "progress_bar";

        src = fetchHex {
          inherit version;
          pkg = "progress_bar";
          sha256 = "6981c2b25ab24aecc91a2dc46623658e1399c21a2ae24db986b90d678530f2b7";
        };

        beamDeps = [ decimal ];
      };

    rajska =
      let
        version = "0c036448e261e8be6a512581c592fadf48982d84";
      in
      buildMix {
        inherit version;
        name = "rajska";

        src = builtins.fetchGit {
          url = "https://github.com/tcitworld/rajska.git";
          rev = "0c036448e261e8be6a512581c592fadf48982d84";
        };

        beamDeps = [ absinthe hammer ];
      };

    ranch =
      let
        version = "2.1.0";
      in
      buildRebar3 {
        inherit version;
        name = "ranch";

        src = fetchHex {
          inherit version;
          pkg = "ranch";
          sha256 = "244ee3fa2a6175270d8e1fc59024fd9dbc76294a321057de8f803b1479e76916";
        };
      };

    remote_ip =
      let
        version = "1.2.0";
      in
      buildMix {
        inherit version;
        name = "remote_ip";

        src = fetchHex {
          inherit version;
          pkg = "remote_ip";
          sha256 = "2ff91de19c48149ce19ed230a81d377186e4412552a597d6a5137373e5877cb7";
        };

        beamDeps = [ combine plug ];
      };

    replug =
      let
        version = "0.1.0";
      in
      buildMix {
        inherit version;
        name = "replug";

        src = fetchHex {
          inherit version;
          pkg = "replug";
          sha256 = "f71f7a57e944e854fe4946060c6964098e53958074c69fb844b96e0bd58cfa60";
        };

        beamDeps = [ plug ];
      };

    sentry =
      let
        version = "8.1.0";
      in
      buildMix {
        inherit version;
        name = "sentry";

        src = fetchHex {
          inherit version;
          pkg = "sentry";
          sha256 = "f9fc7641ef61e885510f5e5963c2948b9de1de597c63f781e9d3d6c9c8681ab4";
        };

        beamDeps = [ hackney jason plug ];
      };

    shortuuid =
      let
        version = "2.1.2";
      in
      buildMix {
        inherit version;
        name = "shortuuid";

        src = fetchHex {
          inherit version;
          pkg = "shortuuid";
          sha256 = "d9b0c4f37500ea5199b6275ece872e213e9f45a015caf4aa777cec84f63ad353";
        };
      };

    sitemapper =
      let
        version = "0.6.0";
      in
      buildMix {
        inherit version;
        name = "sitemapper";

        src = fetchHex {
          inherit version;
          pkg = "sitemapper";
          sha256 = "7392a8af265932ef58af4e1bb950ada826eff8d56277e1187a130f1bda6883e5";
        };

        beamDeps = [ xml_builder ];
      };

    sleeplocks =
      let
        version = "1.1.3";
      in
      buildRebar3 {
        inherit version;
        name = "sleeplocks";

        src = fetchHex {
          inherit version;
          pkg = "sleeplocks";
          sha256 = "d3b3958552e6eb16f463921e70ae7c767519ef8f5be46d7696cc1ed649421321";
        };
      };

    slugger =
      let
        version = "0.3.0";
      in
      buildMix {
        inherit version;
        name = "slugger";

        src = fetchHex {
          inherit version;
          pkg = "slugger";
          sha256 = "20d0ded0e712605d1eae6c5b4889581c3460d92623a930ddda91e0e609b5afba";
        };
      };

    slugify =
      let
        version = "1.3.1";
      in
      buildMix {
        inherit version;
        name = "slugify";

        src = fetchHex {
          inherit version;
          pkg = "slugify";
          sha256 = "cb090bbeb056b312da3125e681d98933a360a70d327820e4b7f91645c4d8be76";
        };
      };

    ssl_verify_fun =
      let
        version = "1.1.7";
      in
      buildMix {
        inherit version;
        name = "ssl_verify_fun";

        src = fetchHex {
          inherit version;
          pkg = "ssl_verify_fun";
          sha256 = "fe4c190e8f37401d30167c8c405eda19469f34577987c76dde613e838bbc67f8";
        };
      };

    struct_access =
      let
        version = "1.1.2";
      in
      buildMix {
        inherit version;
        name = "struct_access";

        src = fetchHex {
          inherit version;
          pkg = "struct_access";
          sha256 = "e4c411dcc0226081b95709909551fc92b8feb1a3476108348ea7e3f6c12e586a";
        };
      };

    sweet_xml =
      let
        version = "0.7.4";
      in
      buildMix {
        inherit version;
        name = "sweet_xml";

        src = fetchHex {
          inherit version;
          pkg = "sweet_xml";
          sha256 = "e7c4b0bdbf460c928234951def54fe87edf1a170f6896675443279e2dbeba167";
        };
      };

    swoosh =
      let
        version = "1.16.10";
      in
      buildMix {
        inherit version;
        name = "swoosh";

        src = fetchHex {
          inherit version;
          pkg = "swoosh";
          sha256 = "756be04db173c0cbe318f1dfe2bcc88aa63aed78cf5a4b02b61b36ee11fc716a";
        };

        beamDeps = [ bandit gen_smtp hackney jason mime plug telemetry ];
      };

    telemetry =
      let
        version = "1.2.1";
      in
      buildRebar3 {
        inherit version;
        name = "telemetry";

        src = fetchHex {
          inherit version;
          pkg = "telemetry";
          sha256 = "dad9ce9d8effc621708f99eac538ef1cbe05d6a874dd741de2e689c47feafed5";
        };
      };

    tesla =
      let
        version = "1.12.0";
      in
      buildMix {
        inherit version;
        name = "tesla";

        src = fetchHex {
          inherit version;
          pkg = "tesla";
          sha256 = "2fd07d9e3fdb0e39dd2cb16064e28ce02808a26cf33a44d269ef3b1fc20fc914";
        };

        beamDeps = [ castore hackney jason mime telemetry ];
      };

    thousand_island =
      let
        version = "1.3.5";
      in
      buildMix {
        inherit version;
        name = "thousand_island";

        src = fetchHex {
          inherit version;
          pkg = "thousand_island";
          sha256 = "2be6954916fdfe4756af3239fb6b6d75d0b8063b5df03ba76fd8a4c87849e180";
        };

        beamDeps = [ telemetry ];
      };

    timex =
      let
        version = "3.7.11";
      in
      buildMix {
        inherit version;
        name = "timex";

        src = fetchHex {
          inherit version;
          pkg = "timex";
          sha256 = "8b9024f7efbabaf9bd7aa04f65cf8dcd7c9818ca5737677c7b76acbc6a94d1aa";
        };

        beamDeps = [ combine gettext tzdata ];
      };

    tls_certificate_check =
      let
        version = "1.23.0";
      in
      buildRebar3 {
        inherit version;
        name = "tls_certificate_check";

        src = fetchHex {
          inherit version;
          pkg = "tls_certificate_check";
          sha256 = "79d0c84effc7c81ac1e85fa38b1c33572fe2976fb8fafdfb2f0140de0442d494";
        };

        beamDeps = [ ssl_verify_fun ];
      };

    tz_world =
      let
        version = "1.3.3";
      in
      buildMix {
        inherit version;
        name = "tz_world";

        src = fetchHex {
          inherit version;
          pkg = "tz_world";
          sha256 = "dae9f255954c767fa4e36fa68b2927310a7192b525e10f860a6f4656aab23746";
        };

        beamDeps = [ castore certifi geo jason ];
      };

    tzdata =
      let
        version = "1.1.1";
      in
      buildMix {
        inherit version;
        name = "tzdata";

        src = fetchHex {
          inherit version;
          pkg = "tzdata";
          sha256 = "a69cec8352eafcd2e198dea28a34113b60fdc6cb57eb5ad65c10292a6ba89787";
        };

        beamDeps = [ hackney ];
      };

    ueberauth =
      let
        version = "0.10.8";
      in
      buildMix {
        inherit version;
        name = "ueberauth";

        src = fetchHex {
          inherit version;
          pkg = "ueberauth";
          sha256 = "f2d3172e52821375bccb8460e5fa5cb91cfd60b19b636b6e57e9759b6f8c10c1";
        };

        beamDeps = [ plug ];
      };

    ueberauth_cas =
      let
        version = "2.3.1";
      in
      buildMix {
        inherit version;
        name = "ueberauth_cas";

        src = fetchHex {
          inherit version;
          pkg = "ueberauth_cas";
          sha256 = "5068ae2b9e217c2f05aa9a67483a6531e21ba0be9a6f6c8749bb7fd1599be321";
        };

        beamDeps = [ httpoison sweet_xml ueberauth ];
      };

    ueberauth_discord =
      let
        version = "0.7.0";
      in
      buildMix {
        inherit version;
        name = "ueberauth_discord";

        src = fetchHex {
          inherit version;
          pkg = "ueberauth_discord";
          sha256 = "d6f98ef91abb4ddceada4b7acba470e0e68c4d2de9735ff2f24172a8e19896b4";
        };

        beamDeps = [ oauth2 ueberauth ];
      };

    ueberauth_facebook =
      let
        version = "0.9.0";
      in
      buildMix {
        inherit version;
        name = "ueberauth_facebook";

        src = fetchHex {
          inherit version;
          pkg = "ueberauth_facebook";
          sha256 = "f2a0fc914a194431b4578b16cba7a2cfce2298f7cfbefb3aa744283cf1eb47ff";
        };

        beamDeps = [ oauth2 ueberauth ];
      };

    ueberauth_github =
      let
        version = "0.8.3";
      in
      buildMix {
        inherit version;
        name = "ueberauth_github";

        src = fetchHex {
          inherit version;
          pkg = "ueberauth_github";
          sha256 = "ae0ab2879c32cfa51d7287a48219b262bfdab0b7ec6629f24160564247493cc6";
        };

        beamDeps = [ oauth2 ueberauth ];
      };

    ueberauth_gitlab_strategy =
      let
        version = "0.4.0";
      in
      buildMix {
        inherit version;
        name = "ueberauth_gitlab_strategy";

        src = fetchHex {
          inherit version;
          pkg = "ueberauth_gitlab_strategy";
          sha256 = "e86e2e794bb063c07c05a6b1301b73f2be3ba9308d8f47ecc4d510ef9226091e";
        };

        beamDeps = [ oauth2 ueberauth ];
      };

    ueberauth_google =
      let
        version = "0.12.1";
      in
      buildMix {
        inherit version;
        name = "ueberauth_google";

        src = fetchHex {
          inherit version;
          pkg = "ueberauth_google";
          sha256 = "7f7deacd679b2b66e3bffb68ecc77aa1b5396a0cbac2941815f253128e458c38";
        };

        beamDeps = [ oauth2 ueberauth ];
      };

    ueberauth_keycloak_strategy =
      let
        version = "0.4.0";
      in
      buildMix {
        inherit version;
        name = "ueberauth_keycloak_strategy";

        src = fetchHex {
          inherit version;
          pkg = "ueberauth_keycloak_strategy";
          sha256 = "c03027937bddcbd9ff499e457f9bb05f79018fa321abf79ebcfed2af0007211b";
        };

        beamDeps = [ oauth2 ueberauth ];
      };

    ueberauth_twitter =
      let
        version = "0.4.1";
      in
      buildMix {
        inherit version;
        name = "ueberauth_twitter";

        src = fetchHex {
          inherit version;
          pkg = "ueberauth_twitter";
          sha256 = "83ca8ea3e1a3f976f1adbebfb323b9ebf53af453fbbf57d0486801a303b16065";
        };

        beamDeps = [ httpoison oauther ueberauth ];
      };

    unicode_util_compat =
      let
        version = "0.7.0";
      in
      buildRebar3 {
        inherit version;
        name = "unicode_util_compat";

        src = fetchHex {
          inherit version;
          pkg = "unicode_util_compat";
          sha256 = "25eee6d67df61960cf6a794239566599b09e17e668d3700247bc498638152521";
        };
      };

    unplug =
      let
        version = "1.1.0";
      in
      buildMix {
        inherit version;
        name = "unplug";

        src = fetchHex {
          inherit version;
          pkg = "unplug";
          sha256 = "a3b302125ed60b658a9a7c0dff6941050bfc56dc77a0bca72facdb743159898f";
        };

        beamDeps = [ plug ];
      };

    unsafe =
      let
        version = "1.0.2";
      in
      buildMix {
        inherit version;
        name = "unsafe";

        src = fetchHex {
          inherit version;
          pkg = "unsafe";
          sha256 = "b485231683c3ab01a9cd44cb4a79f152c6f3bb87358439c6f68791b85c2df675";
        };
      };

    vite_phx =
      let
        version = "0.2.3";
      in
      buildMix {
        inherit version;
        name = "vite_phx";

        src = fetchHex {
          inherit version;
          pkg = "vite_phx";
          sha256 = "4252539d845bf54d604651a3d3a6a321825cc7713c45daa9db2dc8ed39976185";
        };

        beamDeps = [ jason phoenix ];
      };

    web_push_encryption =
      let
        version = "6e143dcde0a2854c4f0d72816b7ecab696432779";
      in
      buildMix {
        inherit version;
        name = "web_push_encryption";

        src = builtins.fetchGit {
          url = "https://github.com/danhper/elixir-web-push-encryption.git";
          rev = "6e143dcde0a2854c4f0d72816b7ecab696432779";
        };

        beamDeps = [ httpoison jose ];
      };

    websock =
      let
        version = "0.5.3";
      in
      buildMix {
        inherit version;
        name = "websock";

        src = fetchHex {
          inherit version;
          pkg = "websock";
          sha256 = "6105453d7fac22c712ad66fab1d45abdf049868f253cf719b625151460b8b453";
        };
      };

    websock_adapter =
      let
        version = "0.5.6";
      in
      buildMix {
        inherit version;
        name = "websock_adapter";

        src = fetchHex {
          inherit version;
          pkg = "websock_adapter";
          sha256 = "e04378d26b0af627817ae84c92083b7e97aca3121196679b73c73b99d0d133ea";
        };

        beamDeps = [ bandit plug websock ];
      };

    xml_builder =
      let
        version = "2.3.0";
      in
      buildMix {
        inherit version;
        name = "xml_builder";

        src = fetchHex {
          inherit version;
          pkg = "xml_builder";
          sha256 = "972ec33346a225cd5acd14ab23d4e79042bd37cb904e07e24cd06992dde1a0ed";
        };
      };
  };
in
self
