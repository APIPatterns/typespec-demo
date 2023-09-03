import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using OpenAPI;

@doc("The Contoso Widget Service API")
@service({
  title: "Widget Service",
  version: "1.0.0",
})
@info({
  contact: {
    name: "API Support",
    email: "contact@contoso.com"
  },
  license: {
    name: "Apache 2.0",
    url: "https://www.apache.org/licenses/LICENSE-2.0.html"
  }
})
@server("http://widgets.contoso.com", "The production server")
namespace DemoService;

model Widget {
  @visibility("read", "update")
  @path
  id: string;

  weight: int32;
  color: "red" | "blue";

  @doc("Date and time that the resource was created")
  @visibility("read")
  createdDateTime: utcDateTime;
  @doc("Date and time that the resource was last updated")
  @visibility("read")
  updatedDateTime: utcDateTime;
}

model Gadget {
  @visibility("read", "update")
  @path
  id: string;

  maxRPM: int32;
  color?: "Blue" | "Yellow";

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

// Operations

// Refactor Widgets and Gadgets to use new ResourceInterface
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
}
