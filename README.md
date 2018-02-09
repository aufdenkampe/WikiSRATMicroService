# SRAT

## Install instructions

This project is designed to run on Python 3.6.
To install all dependancies for this project run the following command
```
pip install requirements.txt
```

The SRAT service can be run by executing `main.py`

## Running tests

Tests for this project use the Unittests library. All tests can be found in the `tests` folder

## Deploying to AWS

There is a simple script called `deploy.py` that will create a .zip for deployment to AWS. This script uses the dependencies that are saved in dependancies.zip. If dependancies have since been updated, please update this zip. Once the `SRAT.zip` has been created, upload it to AWS lambda.
