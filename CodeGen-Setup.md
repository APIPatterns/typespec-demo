## Work in progress
This branch gives us the setup and instructions for doing code generation with the Azure Devloper CLI.

Pre-requisites:
- Docker installed on the machine that will run the devcontainer
- Remote containers extension installed in VSCode

Steps
- azd init --template https://github.com/APIPatterns/typespec-demo-api-service
- azd provision
- open in dev container
- run genny.sh
  - `./.api-generator/genny.sh --typespec-file main.tsp`
  - Note: may need to chmod to make it executable 
- create api sample implementation


- azd deploy
- new python client
- generate client library from deployed api spec
- create main.py to show working api/client in practice
