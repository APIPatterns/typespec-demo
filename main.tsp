import "@typespec/http";
import "@typespec/openapi3";

using TypeSpec.Http;
using OpenAPI;

// Service definition
@service({
  title: "Widget Service",
  version: "1.0.0",
})
namespace DemoService;


// Models

// Added an enumeration for color.
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

// Defined a common metadata model.
@doc("Common metadata for resources")
model ResourceMetadata {
  @doc("Date and time that the resource was created")
  @visibility("read")
  createdOn: utcDateTime;
  @doc("Date and time that the resource was last updated")
  @visibility("read")
  updatedOn: utcDateTime;
}

// Added a base model for common fields.
model BaseThingymajig {
  @visibility("read", "update")
  @path
  id: string;
  color?: Color;
  manufacturer: Manufacturer;
  ...ResourceMetadata;
}

@oneOf
union widgetColors{Red:Color.Red, Blue: Color.Blue};
model Widget extends BaseThingymajig {
  weight: int32;
  color?: widgetColors;
}

model Gadget extends BaseThingymajig {
  maxRPM: int32;
  color?: Color.Yellow | Color.Green;
}

model WingDing extends BaseThingymajig {
  height: float32;
  width: float32;
  color?: Color;
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



// Operations

//Common Interface
interface ResourceInterface<T> {
  @get list(): T[] | Error;
  @get read(@path id: string): T | Error;
  @post create(...T): T | Error;
  @patch update(...T): T | Error;
  @delete delete(@path id: string): void | Error;
}


@route("/widgets")
@tag("Widgets")
interface WidgetsInterface extends ResourceInterface<Widget>{
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}

@route("/gadgets")
@tag("Gadgets")
interface GadgetsInterface extends ResourceInterface<Gadget>{
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}

/* 
Added a new interface for WingDings.
Who said cut/paste/replace was tedious and error prone? 
Wingding DO NOT have an analyze operation!!!
*/
@route("/wingdings")
@tag("WingDing")
interface WingDingInterface extends ResourceInterface<WingDing>{};
