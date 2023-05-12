import "@typespec/http";

using TypeSpec.Http;

// Service definition
@service({
  title: "Widget Service",
  version: "1.0.0",
})
namespace DemoService;


/*
Added tsp-output to .gitignore. This treats the output of emitters as generated artifacts
and emphasizes that they should not be hand-edited.
*/

// Models

// Added a new property to all the models, createdOn. 

model Widget {
  @visibility("read", "update")
  @path
  id: string;
  createdOn: utcDateTime;
  weight: int32;
  color: "red" | "blue";
}

// Added a maxRPM field to the Gadget model
model Gadget {
  @visibility("read", "update")
  @path
  id: string;
  createdOn: utcDateTime;
  maxRPM: int32;
  color: "yellow" | "green";
}

// Added a new model for WingDings
model WingDing {
  @path id: string;
  createdOn: utcDateTime;
  height: float32;
  width: float32;
  color: "orange" | "purple";
}

@error
model Error {
  code: int32;
  message: string;
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
