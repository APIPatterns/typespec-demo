import "@typespec/http";
import "@typespec/openapi3";

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

@error
model Error {
  code: int32;
  message: string;
}

// Add templates for individual operations
@get op list<T>(): T[] | Error;

@get op read<T>(@path id: string): T | Error;

@post op create<T>(...T): T | Error;

@patch op update<T>(...T): T | Error;

@delete op delete(@path id: string): void | Error;

// Leverage operation templates in ResourceInterface
interface ResourceInterface<T> {
  list is list<T>;
  read is read<T>;
  create is create<T>;
  update is update<T>;
  delete is delete;
}
