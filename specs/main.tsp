import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

import "./algorithm.tsp";
import "./extinfo.tsp";
import "./admin.tsp";
import "./provider.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using BeLifeline.Algorithm;
using BeLifeline.ExtInfo;
using BeLifeline.Provider;
using BeLifeline.Admin;

@service({
  title: "BeLifeline Server API",
})
@versioned(BeLifeline.Versions)
namespace BeLifeline;

enum Versions {
  @useDependency(BeLifeline.Algorithm.Versions.latest)
  @useDependency(BeLifeline.ExtInfo.Versions.latest)
  @useDependency(BeLifeline.Provider.Versions.latest)
  v0: "v0.4.0",
}

enum StatusCode {
  OK: 200,
  INTERNAL_SERVER_ERROR: 500,
}

model StatusData {
  status: string;
  statusCode: StatusCode;
}

@route("/")
@tag("Main")
namespace BeLifeline {
  @route("/status")
  interface Status {
    @get get(): StatusData;
  }
}
