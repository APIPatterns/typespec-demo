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
/*
We will often see slight "typos" in an API spec, e.g.
yellow vs. Yellow
*/
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
// Notice the visibility read -- this is what affects the "Request Body Model" and the "Response Body Model".
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
// Notice the spread operator
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

/*
Often, we will see teams use slight different error models.
Sometimes, it's different fields, other times, it's an entirely different structure. 

Consistentcy is really important for developer experience. 
If each team does something slightly differently, then every downstream consumer has to do something slightly differently.
*/

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

// Adopted naming convention for interfaces, e.g. WidgetsInterface, GadgetsInterface, WingDingInterface
@route("/widgets")
@tag("Widgets")
interface WidgetsInterface {
  @get list(): Widget[] | Error;
  @get read(@path id: string): Widget | Error;
  @post create(...Widget): Widget | Error;
  @patch update(...Widget): Widget | Error;
  @delete delete(@path id: string): void | Error;
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}

@route("/gadgets")
@tag("Gadgets")
interface GadgetsInterface {
  @get list(): Gadget[] | Error;
  @get read(@path id: string): Gadget | Error;
  @post create(...Gadget): Gadget | Error;
  @patch update(...Gadget): Gadget | Error;
  @delete delete(@path id: string): void | Error;
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}

/* 
Added a new interface for WingDings.
Who said cut/paste/replace was tedious and error prone? 
*/
@route("/wingdings")
@tag("WingDing")
interface WingDingInterface {
  @get list(): WingDing[] | Error;
  @get read(@path id: string): WingDing | Error;
  @post create(...WingDing): WingDing | Error;
  @patch update(...WingDing): WingDing | Error;
  @delete delete(@path id: string): void | Error;
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}
