import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

import "./extinfo.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace BeLifeline;

scalar algorithm_id extends string;

model AlgorithmInfomation {
  @visibility("read", "query", "update", "delete")
  @doc("From Admin API")
  algorithm_id: algorithm_id;

  algorithm_name: string;
  algorithm_description: string;
  need_external: ExtInfoId[];

  @visibility("read", "query")
  first_entry_at: utcDateTime;

  @visibility("read", "query")
  last_entry_at: utcDateTime;

  @visibility("read", "query")
  last_updated_at: utcDateTime;
}

@route("/algorithm")
@tag("Algorithm")
@doc("Algorithm API")
@useAuth(BearerAuth)
namespace Algorithm {
  interface Algorithm {
    @get list(@query limit?: numeric): AlgorithmInfomation[];
  }

  @route("/{algorithm_id}")
  interface EachAlgorithm {
    @put
    update(
      @path algorithm_id: algorithm_id,
      update_algorithm: AlgorithmInfomation,
    ): AlgorithmInfomation;
    @get get(@path algorithm_id: algorithm_id): AlgorithmInfomation;
  }
}
