{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell/main";
    ftxui = {
      url = "github:ArthurSonzogni/FTXUI/master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        devshell.follows = "devshell";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ftxui,
    devshell,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [devshell.overlays.default];
      };
      libs = [
        ftxui.packages.${system}.ftxui
      ];
      dev-deps = with pkgs; [glibc libcxx doxygen graphviz];
      package-config = rec {
        pname = "ftxui-starter";
        packages-name = pname;
        version = "v0.0.0";
        src = ./.;
      };
      packages = {
        ${package-config.packages-name} = pkgs.stdenv.mkDerivation {
          inherit (package-config) pname version src;

          nativeBuildInputs = with pkgs; [cmake];
          buildInputs = libs;

          cmakeFlags = [
            "-DENABLE_INSTALL=ON"
            "-Dftxui_POPULATED=YES"
          ];

          meta = with pkgs.lib; {
            homepage = "";
            description = "";
            longDescription = "";
            platforms = platforms.linux;
          };
        };
        default = self.packages.${system}.${package-config.packages-name};
      };
      default-app = {
        type = "app";
        program = self.packages.${system}.default + "/bin/${package-config.pname}";
      };
    in {
      apps.default = default-app;
      devShell = pkgs.devshell.mkShell {
        name = package-config.pname;
        imports = ["${devshell}/extra/language/c.nix"];
        packages = dev-deps;

        language.c = {
          libraries = libs;
          includes = libs;
          compiler = pkgs.gcc;
        };
        commands = [
          {
            name = "compile";
            category = "c++";
            help = "Build the project using cmake";
            command = ''
              ${pkgs.cmake}/bin/cmake -S . -B build
              ${pkgs.cmake}/bin/cmake --build build
            '';
          }
        ];
        bash = {
          extra = ''
            export CPLUS_INCLUDE_PATH="$C_INCLUDE_PATH"
            export LIBRARY_PATH="$LD_LIBRARY_PATH"
          '';
        };
      };

      defaultPackage = self.packages.${system}.default;

      inherit packages;
    });
}
