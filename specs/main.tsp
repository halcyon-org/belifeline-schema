import "@typespec/versioning";

import "./algorithm.tsp";
import "./admin.tsp";

@service({
  title: "BeLifeline Server API",
})
@Versioning.versioned(BeLifelineServer.Versions)
namespace BeLifelineServer;

enum Versions {
  v0: "v0.1.0",
}
