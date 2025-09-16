{
  description = "C++ OpenCL dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      platform = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${platform};
    in
    {
      devShells.${platform}.default = pkgs.mkShell {
        name = "c++-opencl-dev-shell";

        buildInputs = with pkgs; [
          gcc
          cmake
          clinfo
          ocl-icd
          intel-compute-runtime
          pocl
        ];

        LD_LIBRARY_PATH = "${pkgs.ocl-icd}/lib:${pkgs.stdenv.cc.cc.lib}/lib";

        shellHook = ''
          echo "C++ OpenCL dev shell started. OpenCL platforms:"
          clinfo -l
        '';
      };
    };
}
