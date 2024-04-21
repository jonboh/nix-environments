{pkgs ? import <nixpkgs> {}}: let
  prettytable = pkgs.python3Packages.prettytable;

  euclid3 = pkgs.python3Packages.euclid3;

  ply = pkgs.python3Packages.ply;

  pypng = pkgs.python3Packages.pypng;

  solidpython2 = pkgs.python3.pkgs.buildPythonPackage rec {
    pname = "solidpython2";
    version = "2.1.0a0";
    format = "wheel";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/52/3d/22fb15a811ff44290c238a66ef85c1172590f89904a1155ddf8c3108ea43/solidpython2-2.1.0a0-py3-none-any.whl";
      hash = "sha256-K6GefDpWJobkBVXpHsAxv0I1wiUihN9Dh1f9OOorVF8=";
    };

    propagatedBuildInputs = [
      prettytable
      euclid3
      ply
      pypng
      pkgs.python3.pkgs.setuptools
    ];
    doCheck = false;

    meta = {
      homepage = "https://github.com/SolidCode/SolidPython";
      description = "A python frontend for solid modelling that compiles to OpenSCAD";
    };
  };
in
  solidpython2
