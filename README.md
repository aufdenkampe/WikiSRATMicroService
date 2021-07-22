# Sub-Basin Modeling Routine for WikiWatershed / Model My Watershed

## Install instructions

This project is designed to run on Python 3.6.
To install all dependancies for this project run the following command
```
pip install requirements.txt
```

The SRAT service can be run by executing `main.py`

You will need to have the following enviromental variables set:

Variable|Explantion
--------|----------
POSTGRES_USER|User with premissions to execute SRAT functions
POSTGRES_HOST|Host for database
POSTGRES_PASSWORD|Password for POSTGRES_USER
POSTGRES_PORT|Most likely 5432
POSTGRES_DB|Most likely drwi

## Running tests

Tests for this project use the Unittests library. All tests can be found in the `tests` folder

## Deploying to AWS

There is a simple script called `deploy.py` that will create a .zip for deployment to AWS. This script uses the dependencies that are saved in dependancies.zip. If dependancies have since been updated, please update this zip. Once the `SRAT.zip` has been created, upload it to AWS lambda.

## Running the Jupyter Notebook

There is a simple demonstration called `WikiSRAT_Demo.ipynb` that will link to a database of pre-modeled results from GWLF-E, calculated through Model My Watershed. This script uses the dependencies that are saved in `WikiSRAT.yml`. To restore this environment, follow the below example. For this, you will need to have recieved a config file from ANS that has the login information.
```
conda env create -f WikiSRAT.yml
```
