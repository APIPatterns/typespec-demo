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

interface ResourceInterface<T> {
  @get list(): T[] | Error;
  @get read(@path id: string): T | Error;
  @post create(...T): T | Error;
  @patch update(...T): T | Error;
  @delete delete(@path id: string): void | Error;
}
