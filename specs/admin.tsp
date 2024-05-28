import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

import "./algorithm.tsp";
import "./extinfo.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace BeLifeline;

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

  @route("/extinfo")
  interface ExtInfo {
    @post create(extinfo: ExternalInfomation): ExternalInfomation & {
      bearer_token: string;
    };
    @route("/{extinfo_id}")
    @delete
    delete(@path extinfo_id: ExtInfoId): {
      delete_extinfo_id: ExtInfoId;
    };
  }
}
