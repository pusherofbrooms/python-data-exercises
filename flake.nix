{
  description = "Python development environment with Jupyter and configurable packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Customize these packages as needed
        pythonPackages = ps: with ps; [
          # Don't remove jupyter. It's pretty core.
          jupyter

          # packages we'd like to import for our learnings
          numpy
          pandas
          torch
          torchvision
          matplotlib
          scikit-learn
        ];

        pythonEnv = pkgs.python312.withPackages pythonPackages;
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pythonEnv
           ];

          shellHook = ''
            echo "Python Jupyter Development Environment"
            python --version
            jupyter --version
            
            jupyter notebook
          '';
        };
      }
    );
}