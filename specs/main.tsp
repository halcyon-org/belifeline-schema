import "@typespec/versioning";

import "./algorithm.tsp";
import "./extinfo.tsp";
import "./admin.tsp";

using TypeSpec.Versioning;

using BeLifeline.Algorithm;
using BeLifeline.ExtInfo;
using BeLifeline.Admin;

@service({
  title: "BeLifeline Server API",
})
@versioned(BeLifeline.Versions)
namespace BeLifeline;

enum Versions {
  @useDependency(BeLifeline.Algorithm.Versions.latest)
  @useDependency(BeLifeline.ExtInfo.Versions.latest)
  v0: "v0.2.0",
}
