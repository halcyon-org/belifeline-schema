import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

import "./algorithm.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace AlgorithmServer;

@route("/admin")
@tag("Admin")
@doc("Admin API")
@useAuth(BearerAuth)
namespace Admin {
  @route("/algorithm")
  interface Algorithm {
    @post create(algorithm: AlgorithmInfomation): AlgorithmInfomation & {
      bearer_token: string;
    };
    @route("/{algorithm_id}")
    @delete
    delete(@path algorithm_id: algorithm_id): {
      delete_algorithm_id: algorithm_id;
    };
  }
}
