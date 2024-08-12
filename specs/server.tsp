import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@route("/")
@tag("Server")
@versioned(Versions)
namespace BeLifeline.Server;
enum Versions {
  latest: "lastest",
}

@summary("Server status")
@route("/status")
interface Status {
  @get get(): {
    @statusCode code: 200 | 500;
    @body status: string;
  };
}
