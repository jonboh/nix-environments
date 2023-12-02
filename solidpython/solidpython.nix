{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "solidpython";
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs; [
    pyright
    ruff
    (
      let
        prettytable = python310.pkgs.buildPythonPackage rec {
          pname = "prettytable";
          version = "0.7.2";
          format = "setuptools";
          src = fetchPypi {
            inherit pname version;
            hash = "sha256-LVRg3J23SjK8yPn2feaLLE9NLwH6O9UYdkxpFW2crNk=";
          };
          doCheck = false;
          meta = {
            homepage = "https://github.com/jazzband/prettytable";
            description = "Display tabular data in a visually appealing ASCII table format";
          };
        };

        euclid3 = python310.pkgs.buildPythonPackage rec {
          pname = "euclid3";
          version = "0.01";
          format = "setuptools";
          src = fetchPypi {
            inherit pname version;
            hash = "sha256-JbgnpXrb/Zo/qGJeQ6vD6Qf2HeYiND5+U4SC75tG/Qs=";
          };
          doCheck = false;
          meta = {
            homepage = "https://pypi.org/project/euclid3/0.01/";
            description = "2D and 3D maths module for Python";
          };
        };

        ply = python310.pkgs.buildPythonPackage rec {
          pname = "ply";
          version = "3.11";
          src = fetchurl {
            url = "https://files.pythonhosted.org/packages/a3/58/35da89ee790598a0700ea49b2a66594140f44dec458c07e8e3d4979137fc/ply-3.11-py2.py3-none-any.whl";
            sha256 = "1kh7m0i2ghjhrbzi6a28yw3rcnzy5r2i4srls4pvspmna21rnvq9";
          };
          format = "wheel";
          doCheck = false;
          buildInputs = [ ];
          checkInputs = [ ];
          nativeBuildInputs = [ ];
          propagatedBuildInputs = [ ];
        };

        pypng = python310.pkgs.buildPythonPackage rec {
          pname = "pypng";
          version = "0.0.19";
          format = "setuptools";

          src = fetchPypi {
            inherit pname version;
            hash = "sha256-MUXQQpR/qBIea9Wn5ZFJhxv4wTZ1xCNx4Sl3SZ1/OSY=";
          };

          doCheck = false;

          meta = {
            homepage = "https://pypi.org/project/pypng/0.0.19/";
            description = "PyPNG allows PNG image files to be read and written using pure Python.";
          };
        };

        solidpython = python310.pkgs.buildPythonPackage rec {
          pname = "solidpython";
          version = "1.1.2";
          format = "setuptools";

          src = fetchPypi {
            inherit pname version;
            hash = "sha256-kyW6VFIz4wiZPpdHL/PL7UJfxNuRg9lROiNg6Mo39r0=";
          };

          propagatedBuildInputs = [
            prettytable
            euclid3
            ply
            pypng
          ];
          doCheck = false;

          meta = {
            homepage = "https://github.com/SolidCode/SolidPython";
            description = "A python frontend for solid modelling that compiles to OpenSCAD";
          };
        };
      in
      python310.withPackages (ps: with ps; [
        ruff-lsp
        autopep8
        debugpy
        setuptools
        solidpython
        numpy
      ])
    )
  ];
}
