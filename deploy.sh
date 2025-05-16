#!/bin/bash
set -e

AWS_ACCOUNT_ID="749670524656"  # Replace this!

LAYER_NAME_PREFIX="psycopg2"
REGIONS=("us-east-1" "us-west-2" "eu-west-1" "ap-south-1")

for PY_VERSION in "311" "312"
do
  ZIP_FILE="layers/psycopg2-py${PY_VERSION}/psycopg2_py${PY_VERSION}_layer.zip"
  LAYER_NAME="${LAYER_NAME_PREFIX}-py${PY_VERSION}"

  if [[ ! -f "$ZIP_FILE" ]]; then
    echo "ERROR: ZIP file not found: $ZIP_FILE"
    exit 1
  fi

  for REGION in "${REGIONS[@]}"
  do
    echo "Publishing $LAYER_NAME to $REGION ..."

    VERSION=$(aws lambda publish-layer-version \
      --layer-name "$LAYER_NAME" \
      --zip-file "fileb://$ZIP_FILE" \
      --compatible-runtimes "python3.${PY_VERSION:0:1}.${PY_VERSION:1}" \
      --region "$REGION" \
      --query Version --output text)

    echo "Published version $VERSION in $REGION"

    aws lambda add-layer-version-permission \
      --layer-name "$LAYER_NAME" \
      --version-number "$VERSION" \
      --statement-id "public-access-${REGION}-${VERSION}" \
      --action lambda:GetLayerVersion \
      --principal "*" \
      --region "$REGION" || echo "Permission might already exist"

    echo "Layer ARN: arn:aws:lambda:$REGION:$AWS_ACCOUNT_ID:layer:$LAYER_NAME:$VERSION"
  done

  echo "-----------------------------"
done
