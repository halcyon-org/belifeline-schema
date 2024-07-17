import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@versioned(Versions)
namespace BeLifeline.Server;
enum Versions {
  latest: "lastest",
}

@route("/")
@tag("Server")
namespace BeLifeline.Server {
  @summary("Server status")
  @route("/status")
  interface Status {
    @get get(): {
      @statusCode code: 200 | 500;
      @body status: string;
    };
  }
}
