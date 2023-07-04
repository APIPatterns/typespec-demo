import "@typespec/http";
import "@typespec/openapi3";
import "./api-lib.tsp";

using TypeSpec.Http;
using OpenAPI;
using APILibrary;

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

@oneOf
union widgetColors {Red:Color.Red, Blue: Color.Blue};

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

// Operations

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

@route("/wingdings")
@tag("WingDings")
interface WingDingInterface extends ResourceInterface<WingDing> {}
