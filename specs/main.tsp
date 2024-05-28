import "@typespec/versioning";

import "./algorithm.tsp";
import "./extinfo.tsp";
import "./admin.tsp";

@service({
  title: "BeLifeline Server API",
})
@Versioning.versioned(BeLifeline.Versions)
namespace BeLifeline;

enum Versions {
  v0: "v0.2.0",
}
