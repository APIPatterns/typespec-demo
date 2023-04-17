import "@typespec/http";
import "@typespec/rest";
import "./linter.js";

using TypeSpec.Http;

@service({
  title: "Widget Service",
  version: "1.0.0"
})
namespace DemoService;


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

model List<T> {
    @doc("List of elements")
    value: T[];
    @doc("A link to the next page of results if present.")
    nextLink?: url;
}

model Patch<T> {
    @header contentType: "application/merge-patch+json";
    ...T;
}

model ApiVersion {
    @doc("The version of the API in the form YYYY-MM-DD")
    @query("api-version") apiVersion: string;
}

interface ResourceInterface<T> {
    @get list(...ApiVersion): List<T> | Error;
    @get read(@path id: string, ...ApiVersion): T | Error;
    @put create(@body body: T, ...ApiVersion): T | Error;
    @patch update(@body body: Patch<T>, ...ApiVersion): T | Error;
    @delete delete(@path id: string, ...ApiVersion): void | Error;
  }



model Widget {
  @path id: string;
  weight: int32;
  color: "red" | "blue";
}

model Gadget {
  @path id: string;
  height: float32;
  width: float32;
  color: "green" | "yellow";
}

@route("/widgets")
@tag("Widgets")
interface Widgets extends ResourceInterface<Widget> {
  @route("analyze") @post analyze(...ApiVersion): string | Error;
}

@route("/gadgets")
@tag("Gadgets")
interface Gadgets extends ResourceInterface<Gadget> {
}
