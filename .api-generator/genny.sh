#!/bin/bash
set -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

help()
{
    echo ""
      echo "<The command will allow you to use a spec first approach to developing APIs>"
      echo ""
      echo "Command"
      echo "    genny.sh : used to generate models and controllers based on the typespec defined."
      echo ""
      echo "Arguments"
      echo "    --output-dir, -o      The dirctory to generate the API in [default: ./src/WebApi/]"
      echo "    --typespec-file, -t       Path to the TypeSpec file to generate from [default: main.tsp]"
      echo "    --spec-version, -v    Spec version to generate files for [default: v1]"
      echo ""
      exit 1
}

SHORT=h
LONG=typespec-file:,spec-version:,output-dir:help
OPTS=$(getopt -a -n files --options $SHORT --longoptions $LONG -- "$@")

eval set -- "$OPTS"

OUTPUT_DIR='./src/WebApi/'
GENERATOR_DIR='./.api-generator'
SPEC_FILE='main.tsp'
SPEC_VERSION='v1'
while :
do
  case "$1" in
    -o | --output_dir )
      OUTPUT_DIR="$2"
      shift 2
      ;;
    -t | --typespec-file )
      SPEC_FILE="$2"
      shift 2
      ;;
    -v | --spec-version )
      SPEC_VERSION="$2"
      shift 2
      ;;
    -h | --help)
      help
      ;;
    --)
      shift;
      break
      ;;
    *)
      echo "Unexpected option: $1"
      ;;
  esac
done

## Create the output directory if it doesn't already exist
if [ ! -d $OUTPUT_DIR ]
then
  mkdir -p $OUTPUT_DIR
fi

echo "Generatoring OpenAPI spec from $SPEC_FILE"

OPENAPI_SPEC_FILE=openapi.json
## Emit the open api spec from the typespec file
tsp compile $SPEC_FILE --emit @typespec/openapi3

PACKAGE_NAME=$(jq -r '.packageName' "$GENERATOR_DIR/genny.json")

GENERATOR_NAME=$(jq -r '.generatorName' "$GENERATOR_DIR/genny.json")

TEMPLATE_PATH=$(jq -r '.templatePath' "$GENERATOR_DIR/genny.json")

OPENAPI_FILE_PATH=$OUTPUT_DIR/spec/openapi.json

echo "Generating Models of WebAPI"

## Generate the Models
openapi-generator-cli generate -g $GENERATOR_NAME \
    -o ./temp -i $OPENAPI_FILE_PATH \
    --package-name $PACKAGE_NAME -t $TEMPLATE_PATH \
    --global-property=models

echo "Generating controllers for WebAPI"

## Generate the apis
openapi-generator-cli generate -g $GENERATOR_NAME \
    -o ./temp -i $OPENAPI_FILE_PATH \
    --package-name $PACKAGE_NAME -t $TEMPLATE_PATH \
    --global-property=apis

echo "Moving generated files to $OUTPUT_DIR"

## Copy generated files
for MOVABLE in $(jq -c '.movables[]' "$GENERATOR_DIR/genny.json"); do
    FROM=$(echo ${MOVABLE} | jq -r '.from')
    TO=$(echo ${MOVABLE} | jq -r '.to')
    FROM_DIR="./temp$FROM"
    TO_DIR="$OUTPUT_DIR$TO"
    echo "Copying files from ${FROM_DIR} to ${TO_DIR}"

    cp -R "$FROM_DIR/." $TO_DIR
done

echo "Cleaning up temporary resources"
## Clean Up temporary files used to generate code
rm -rf ./temp
rm ./openapitools.json
