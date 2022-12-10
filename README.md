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

## API Guidelines -- standard operations

Update list operation to conform to [Azures guidelines for operations on collections](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections), in particular:

✅ DO structure the response to a list operation as an object with a top-level array field containing the set (or subset) of resources.

✅ DO return a nextLink field with an absolute URL that the client can GET in order to retrieve the next page of the collection.

☑️ YOU SHOULD use value as the name of the top-level array field unless a more appropriate name is available.

Change the create operation from post to put to [ensure idempotency](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#exactly-once-behavior--client-retries--service-idempotency).

✅ DO ensure that all HTTP methods are idempotent.

☑️ YOU SHOULD use PUT or PATCH to create a resource as these HTTP methods are easy to implement, allow the customer to name their own resource, and are idempotent.

Include an update operation (patch) that accepts JSON merge patch and a delete operation that returns a 204 response.

 DO create and update resources using PATCH [RFC5789] with JSON Merge Patch (RFC7396) request body.

✅ DO return a 204-No Content without a resource/body for a DELETE operation
