import "@typespec/http";
import "@typespec/openapi";
import "./api-lib.tsp";

using TypeSpec.Http;
using OpenAPI;
using APILibrary;

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
  color: Colors.Red | Colors.Blue;

  ...ResourceMetadata;
}

model Gadget {
  @visibility("read", "update")
  @path
  id: string;

  maxRPM: int32;
  color?: Colors.Blue | Colors.Yellow;

  ...ResourceMetadata;
}

// Operations

// Refactor Widgets and Gadgets to use new ResourceInterface
@route("/widgets")
@tag("Widgets")
interface Widgets {
  op list is list<Widget>;
  op read is read<Widget>;
  op create is create<Widget>;
  op update is update<Widget>;
  op delete is delete;
  @route("{id}/analyze") @post analyze(@path id: string): string | Error;
}

@route("/gadgets")
@tag("Gadgets")
interface Gadgets {
  op list is list<Gadget>;
  op read is read<Gadget>;
  op create is create<Gadget>;
  op update is update<Gadget>;
  op delete is delete;
}
