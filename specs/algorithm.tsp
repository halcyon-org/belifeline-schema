import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

import "./extinfo.tsp";
import "./main.tsp";
import "./types.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using BeLifeline.ExtInfo;
using BeLifeline.Types;

@versioned(Versions)
namespace BeLifeline.Algorithm;
enum Versions {
  latest: "lastest",
}

scalar algorithmId extends string;
scalar algorithmDataId extends string;
scalar algorithmScale extends float32;
enum DataType {
  image,
  csv,
  json,
}

model AlgorithmInfomation {
  @visibility("read", "query", "update", "delete")
  @doc("From Admin API")
  algorithm_id: algorithmId;

  algorithm_name: string;
  algorithm_description: string;
  need_external: ExtInfoId[];

  @doc("param name: param default")
  algorithm_params: Record<string>;

  algorithm_scales: algorithmScale[];
  algorithm_data_ids: algorithmDataId[];
  version: Common.version;

  @visibility("read", "query")
  first_entry_at: utcDateTime;

  @visibility("read", "query")
  last_entry_at: utcDateTime;

  @visibility("read", "query")
  last_updated_at: utcDateTime;

  @visibility
  secret_api_key: Auth.apiKey;
}

model AlgorithmData {
  @visibility("read", "query", "update", "delete")
  algorithm_id: algorithmId;

  version: Common.version;

  @visibility("read", "query")
  algorithm_data_id: algorithmDataId;

  algorithm_scale: algorithmScale;
  content_type: DataType;
  content: bytes;

  @visibility("read", "query")
  entry_at: utcDateTime;

  @visibility("read", "query")
  target_at: utcDateTime;
}

@route("/algorithm")
@tag("Algorithm")
@doc("Algorithm API")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "api_key">)
namespace BeLifeline.Algorithm {
  interface Algorithm {
    @get list(@query limit?: int32): AlgorithmInfomation[];
  }

  @route("/{algorithm_id}")
  interface EachAlgorithm {
    @put
    update(
      @path algorithm_id: algorithmId,
      update_algorithm: AlgorithmInfomation,
    ): AlgorithmInfomation;
    @get get(@path algorithm_id: algorithmId): AlgorithmInfomation;
  }

  @route("/{algorithm_id}/data")
  interface EachAlgorithmData {
    @get
    get(
      @path algorithm_id: algorithmId,
      @query scale: algorithmScale,
    ): AlgorithmData;
    @put
    update(
      @path algorithm_id: algorithmId,
      @query scale: algorithmScale,
      update_data: AlgorithmData,
    ): AlgorithmData;
  }
}
