{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, importlib-metadata
, pyyaml
, python
}:

buildPythonPackage rec {
  pname = "markdown";
  version = "3.3.5";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    pname = "Markdown";
    inherit version;
    sha256 = "sha256-JulUa/vN5fzQcr2PYSycG24md8uKrb32UgZnT0bd4Gk=";
  };

  propagatedBuildInputs = lib.optionals (pythonOlder "3.10") [
    importlib-metadata
  ];

  checkInputs = [ pyyaml ];

  checkPhase = ''
    ${python.interpreter} -m unittest discover
  '';

  meta = with lib; {
    description = "A Python implementation of John Gruber's Markdown with Extension support";
    homepage = "https://github.com/Python-Markdown/markdown";
    license = licenses.bsd3;
    maintainers = with maintainers; [ dotlambda ];
  };
}
