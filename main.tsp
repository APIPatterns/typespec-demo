import "@typespec/http";
import "@typespec/openapi3";

using TypeSpec.Http;
using OpenAPI;

@service({
  title: "Widget Service",
  version: "1.0.0",
})
namespace DemoService;

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

// Add a new WingDing model
model WingDing extends BaseThingymajig {
  height: float32;
  width: float32;
  color?: Color;
}

@error
model Error {
  code: int32;
  message: string;
}

// Operations

// Create a reusable ResourceInterface, with T parameter
interface ResourceInterface<T> {
  @get list(): T[] | Error;
  @get read(@path id: string): T | Error;
  @post create(...T): T | Error;
  @patch update(...T): T | Error;
  @delete delete(@path id: string): void | Error;
}

// Refactor Widgets and Gadgets to use new ResourceInterface
@route("/widgets")
@tag("Widgets")
interface Widgets extends ResourceInterface<Widget> {
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}

@route("/gadgets")
@tag("Gadgets")
interface Gadgets extends ResourceInterface<Gadget> {
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}

// Add operations for WingDings using the new ResourceInterface 
@route("/wingdings")
@tag("WingDings")
interface WingDingInterface extends ResourceInterface<WingDing> {}
