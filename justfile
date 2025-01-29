
PYTHON := "./venv/bin/python3"
PYTEST := "./venv/bin/pytest"
PACT_VERIFIER := "./venv/bin/pact-verifier"

venv:
	rm -rf venv
	python3 -m venv ./venv

requirements:
	{{PYTHON}} -m pip install -r requirements.txt

test-client:
	{{PYTEST}}

start-server:
	{{PYTHON}} pact_python_demo/user-app.py

verifier:
	{{PACT_VERIFIER}} --provider-base-url=http://localhost:5001 --pact-url=tests/userserviceclient-userservice.json --provider-states-setup-url=http://localhost:5001/_pact/provider_states


	
