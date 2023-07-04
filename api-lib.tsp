import "@typespec/http";
import "@typespec/openapi3";
import "./linter.js";

using TypeSpec.Http;
using OpenAPI;

namespace APILibrary;

model BaseThingymajig {
  @visibility("read", "update")
  @path
  id: string;
  color?: Color;
  manufacturer: Manufacturer;
  ...ResourceMetadata;
}

enum Color {
  Red,
  Yellow,
  Purple,
  Green,
  Orange,
  Blue,
}

model Manufacturer {
  name: string;
  address: string;
}

@doc("Common metadata for resources")
model ResourceMetadata {
  @doc("Date and time that the resource was created")
  @visibility("read")
  createdOn: utcDateTime;
  @doc("Date and time that the resource was last updated")
  @visibility("read")
  updatedOn: utcDateTime;
}

// Common Error Model
@error
@doc("Error response")
model Error {
  @doc("A server-defined code that uniquely identifies the error.")
  @header("x-ms-error-code")
  code: string;
  @doc("Top-level error object")
  error: ErrorDetail;
}

@doc("Error details")
model ErrorDetail {
  @doc("A server-defined code that uniquely identifies the error.")
  code: string;
  @doc("A human-readable representation of the error.")
  message: string;
  @doc("An array of details about specific errors that led to this reported error.")
  details?: ErrorDetail[];
}

// Each operation should have an api-version query parameter
model ApiVersion {
  @doc("The version of the API in the form YYYY-MM-DD")
  @query("api-version") apiVersion: string;
}

// List operations should return an object with nextLink -- not a bare array
model List<T> {
  @doc("List of elements")
  value: T[];
  @doc("A link to the next page of results if present.")
  nextLink?: url;
}
@get op list<T>(...ApiVersion): List<T> | Error;

@get op read<T>(@path id: string, ...ApiVersion): T | Error;

@post op create<T>(...T, ...ApiVersion): T | Error;

// Patch operations should accept a json-merge+patch body
model MergePatch<T> {
  @header contentType: "application/merge-patch+json";
  ...T;
}
@patch op update<T>(@body body: MergePatch<T>, ...ApiVersion): T | Error;

@delete op delete(@path id: string, ...ApiVersion): void | Error;

interface ResourceInterface<T> {
  list is list<T>;
  read is read<T>;
  create is create<T>;
  update is update<T>;
  delete is delete;
}
