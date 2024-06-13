import "@typespec/versioning";

import "./server.tsp";
import "./algorithm.tsp";
import "./extinfo.tsp";
import "./admin.tsp";
import "./provider.tsp";

using TypeSpec.Versioning;

using BeLifeline.Server;
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
  @useDependency(BeLifeline.Server.Versions.latest)
  @useDependency(BeLifeline.Algorithm.Versions.latest)
  @useDependency(BeLifeline.ExtInfo.Versions.latest)
  @useDependency(BeLifeline.Provider.Versions.latest)
  @useDependency(BeLifeline.Types.Versions.latest)
  v0: "v0.5.3",
}
