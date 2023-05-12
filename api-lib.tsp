import "@typespec/compiler";
import "@typespec/http";
import "@typespec/openapi3";

using TypeSpec.Http;

namespace APILibrary;

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

// Added an enumeration for color.
enum Color {
    Red,
    Yellow,
    Purple,
    Green,
    Orange,
    Blue,
  }


//Standard Operations and associated models supporting the operations.

// We want to provide a model to the list operation, so we keep its defintion
// close to where it is used. This "List" model should not be used outside of this context. 
model ApiVersion {
    @doc("The version of the API in the form YYYY-MM-DD")
    @query("api-version") apiVersion: string;
  }
  
  model List<T> {
    @doc("List of elements")
    value: T[];
    @doc("A link to the next page of results if present.")
    nextLink?: url;
  }
  @get op list<T, P = {}>(...P): List<T> | Error;
  
  @get op read<T, P = {}>(...P, @path id: string): T | Error;
  
  @put op create<T, P = {}>(...P, @path id: string, @body body: T): T | Error;
  
  
  model MergePatch<T> {
    @header contentType: "application/merge-patch+json";
    ...T;
  }
  @patch op update<T, P = {}>(...P, @path id: string, @body body: MergePatch<T>): T | Error;
  
  @delete op delete<P = {}>(...P, @path id: string): void | Error;
  
  @post op postAction<T, P = {}>(...P): T | Error;
  
  
  //Common Interface using the operations defined above.
  interface ResourceInterface<T> {
      list is list<T>;
      read is read<T>;
      create is create<T>;
      update is update<T>;
      delete is delete;
    }
  
  



