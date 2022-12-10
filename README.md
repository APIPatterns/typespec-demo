# Cadl Demo

This repo contains a demo of the Cadl API Design language.

## Create a new Cadl project

Open the Cadl docs at https://aka.ms/cadl and click on the Installation tab.

Follow the steps there to create a new Cadl project.

## Create a new Cadl definition

Open the Cadl playground at https://aka.ms/trycadl and select the Http service example.

View the SwaggerUI by choosing it from the dropdown in the right pane.

Make a few small changes and then copy to the main.cadl file.

## Cadl support for reuse

Create library.cadl with Error model and ResourceTemplate templated interface.

Refactor Widgets interface to use ResourceTemplate then add Gadgets interface.

## API Guidelines -- error response

Make the standard error response conform to the [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#handling-errors), in particular:

✅ DO return an x-ms-error-code response header with a string error code indicating what went wrong.

✅ DO provide a response body with the following structure:
