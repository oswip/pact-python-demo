# python-pact demo

https://github.com/bsquizz/pact-python-demo

Review the readme
https://github.com/bsquizz/pact-python-demo/blob/master/README.md

## Run client tests
This corresponds to https://github.com/bsquizz/pact-python-demo/blob/master/README.md#creatingvalidating-pacts-without-the-broker

Clone repo

```
git clone https://github.com/bsquizz/pact-python-demo.git
cd pact-python-demo
```

Create a venv

```
python3 -m venv ./venv
source ./venv/bin/activate
``` 

Install dependencies

```
python3 -m pip install pytest
python3 -m pip install requests
python3 -m pip install pact-python
python3 -m pip install flask
```

Enter virtual environment

```
source ./venv/bin/activate
```

Note the files in the tests folder

```
ls tests
```

Run pytest

```
pytest
```

Notice the new file (`userserviceclient-userservice.json`) created in the tests folder
That file is the contract as defined by the consumer
The provider should ensure that it abides by that contract to avoid breaking the consumer

```
ls tests
```

## Verify the provider

Start the server

```
python pact_python_demo/user-app.py
```

Run the tests

```
pact-verifier --provider-base-url=http://localhost:5001 \
            --pact-url=tests/userserviceclient-userservice.json \
            --provider-states-setup-url=http://localhost:5001/_pact/provider_states
```

## Publishing results to the broker
This corresponds to https://github.com/bsquizz/pact-python-demo/blob/master/README.md#creatingvalidating-pacts-and-publishing-results-to-the-pact-broker

Start broker (broker, nginx, postgres)

```
cd broker
docker compose up
```

View the UI at http://127.0.0.1 (user: pactbroker, pass:pacbroker)

Run the test, but this time publish to the broker

```
pytest --publish-pact 0.1
```











