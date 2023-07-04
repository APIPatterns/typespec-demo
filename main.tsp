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
