# TypeSpec Demo

This repo contains a demo of the TypeSpec API Design language.

## Create a new TypeSpec project

Open the TypeSpec docs at https://aka.ms/typespec and click on the Installation tab.

Follow the steps there to create a new TypeSpec project.

## Create a new TypeSpec definition

Open the TypeSpec playground at https://aka.ms/trytypespec and select the Http service example.

View the SwaggerUI by choosing it from the dropdown in the right pane.

Make a few small changes and then copy to the main.tsp file.

## TypeSpec support for reuse

Create library.tsp with Error model and ResourceTemplate templated interface.

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

## API Guidelines -- api-version query parameter

Update all operations in the ResourceTemplate interface to support versioning with an [api-version query parameter](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#api-versioning).

✅ DO use a required query parameter named api-version on every operation for the client to specify the API version.

✅ DO use YYYY-MM-DD date values, with a -preview suffix for preview versions, as the valid values for api-version.

## Add linter for api-version

Create linter.js to check operations for api-version and import into library.tsp.

Run tsp compile to show that it flags the Widgets analyze operation as needing an api-version.
