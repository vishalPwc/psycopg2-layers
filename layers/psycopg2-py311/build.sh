#!/bin/bash

set -e

LAYER_NAME="psycopg2"
PYTHON_VERSION="3.11"

mkdir -p python/lib/python${PYTHON_VERSION}/site-packages

pip install psycopg2-binary -t python/lib/python${PYTHON_VERSION}/site-packages

zip -r ${LAYER_NAME}_layer.zip python
