import "@typespec/http";
import "@typespec/openapi3";
import "./api-lib.tsp";
// import "./linter.js";

using TypeSpec.Http;
using OpenAPI;
using APILibrary;

// Service definition
@service({
  title: "Widget Service",
  version: "1.0.0",
})
namespace DemoService;


// Models


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

@oneOf
union gadgetColors{Yellow:Color.Yellow, Green: Color.Green};

model Gadget extends BaseThingymajig {
  maxRPM: int32;
  color?: gadgetColors;
}

model WingDing extends BaseThingymajig {
  height: float32;
  width: float32;
  color?: Color;
}

// Operations
// Notice that the custom routes now have an error
// This is because our linter is catching the fact that we do not have an api version as a query param!
// Resource Interfaces
@route("/widgets")
@tag("Widgets")
interface WidgetsInterface extends ResourceInterface<Widget> {
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}

@route("/gadgets")
@tag("Gadgets")
interface GadgetsInterface {
  getGadgets is list<Gadget>;
  getGadgetById is read<Gadget>;
  updateGadget is update<Gadget>;
  deleteGadget is delete;
  @post op createGadget(@body body: Gadget): Gadget | Error;

}

@route("/wingdings")
@tag("WingDing")
interface WingDingInterface {
  getWingDings is list<WingDing>;
  getWingDing is read<WingDing>;
  deleteWingDing is delete;
};
