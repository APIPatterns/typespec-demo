import "@typespec/http";
import "@typespec/openapi3";

using TypeSpec.Http;
using OpenAPI;

@service({
  title: "Widget Service",
  version: "1.0.0",
})
namespace DemoService;

// Added a base model for common fields.
model BaseThingymajig {
  @visibility("read", "update")
  @path
  id: string;
  color?: Color;
  manufacturer: Manufacturer;
  ...ResourceMetadata;
}

// Added an enumeration for color.
enum Color {
  Red,
  Yellow,
  Purple,
  Green,
  Orange,
  Blue,
}

// Added a model for manufacturer.
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

// oneOf decorator for union types
@oneOf
union widgetColors {Red:Color.Red, Blue: Color.Blue};

// Now Widget and Gadget extend BaseThingamajig
model Widget extends BaseThingymajig {
  weight: int32;
  color?: widgetColors;
}

model Gadget extends BaseThingymajig {
  maxRPM: int32;
  color?: Color.Yellow | Color.Green;
}

@error
model Error {
  code: int32;
  message: string;
}

@route("/widgets")
@tag("Widgets")
interface Widgets {
  @get list(): Widget[] | Error;
  @get read(@path id: string): Widget | Error;
  @post create(...Widget): Widget | Error;
  @patch update(...Widget): Widget | Error;
  @delete delete(@path id: string): void | Error;
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}

@route("/gadgets")
@tag("Gadgets")
interface Gadgets {
  @get list(): Gadget[] | Error;
  @get read(@path id: string): Gadget | Error;
  @post create(...Gadget): Gadget | Error;
  @patch update(...Gadget): Gadget | Error;
  @delete delete(@path id: string): void | Error;
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}
