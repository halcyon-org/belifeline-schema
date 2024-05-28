import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace BeLifelineServer;

alias algorithm_id = string;

model AlgorithmInfomation {
  @visibility("read", "query", "update", "delete")
  @doc("From Admin API")
  algorithm_id: algorithm_id;

  algorithm_name: string;
  algorithm_description: string;
  need_external: external_id[];

  @visibility("read", "query")
  first_entry_at: utcDateTime;

  @visibility("read", "query")
  last_entry_at: utcDateTime;

  @visibility("read", "query")
  last_updated_at: utcDateTime;
}

alias external_id = string;

model ExternalInfomation {
  external_id: external_id;
  external_name: string;
  external_description: string;
  first_entry_at: utcDateTime;
  last_updated_at: utcDateTime;
  updated_history: utcDateTime[];
}

@route("/algorithm")
@tag("Algorithm")
@doc("Algorithm API")
@useAuth(BearerAuth)
namespace Algorithm {
  interface Algorithm {
    @get list(@query limit?: int32): AlgorithmInfomation[];
    @post create(algorithm: AlgorithmInfomation): AlgorithmInfomation;
  }

  @route("/{algorithm_id}")
  interface EachAlgorithm {
    @put
    update(
      @path algorithm_id: algorithm_id,
      update_algorithm: AlgorithmInfomation,
    ): AlgorithmInfomation;
    @get get(@path algorithm_id: algorithm_id): AlgorithmInfomation;
    @delete delete(@path algorithm_id: algorithm_id): {
      delete_algorithm_id: algorithm_id;
    };
  }
}
