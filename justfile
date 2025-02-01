
PYTHON := "./venv/bin/python3"
PYTEST := "./venv/bin/pytest"
PACT_VERIFIER := "./venv/bin/pact-verifier"
DOCKER_COMPOSE := "docker compose"

venv:
	rm -rf venv
	python3 -m venv ./venv

requirements:
	{{PYTHON}} -m pip install -r requirements.txt

test-client:
	{{PYTEST}}

start-server:
	{{PYTHON}} pact_python_demo/user-app.py &

stop-server:
	./kill-by-name.sh "user-app.py"

# verify the pact against the server
# make sure the server is running
# - just start-server
verify-client:
	{{PACT_VERIFIER}} --provider-base-url=http://localhost:5001 --pact-url=tests/userserviceclient-userservice.json --provider-states-setup-url=http://localhost:5001/_pact/provider_states

start-broker:
	cd broker; {{DOCKER_COMPOSE}} up

stop-broker:
	cd broker; {{DOCKER_COMPOSE}} down

# verify the pact through the broker
# make sure the broker and server are running, and the venv is loaded
# - just start-broker
# - just start-server
# - source ./venv/bin/activaate
test-full:
	{{PYTEST}} --publish-pact 0.1
	./verify_pact.sh 0.2


