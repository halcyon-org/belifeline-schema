import "@typespec/versioning";

import "./algorithm.tsp";
import "./extinfo.tsp";
import "./admin.tsp";
import "./provider.tsp";

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
  v0: "v0.3.0",
}
