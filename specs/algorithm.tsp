import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/protobuf";

import "./extinfo.tsp";
import "./main.tsp";
import "./types.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.Protobuf;

using BeLifeline.ExtInfo;
using BeLifeline.Types;

@package
@versioned(Versions)
namespace BeLifeline.Algorithm;
enum Versions {
  latest: "lastest",
}

scalar algorithmId extends string;
scalar algorithmDataId extends string;
scalar algorithmScale extends float32;

@knownValues(DataTypeName)
scalar DataType extends string;
enum DataTypeName {
  image,
  csv,
  json,
}

model AlgorithmInfomation {
  @field(1)
  @visibility("read", "query", "update", "delete")
  @doc("From Admin API")
  algorithm_id: algorithmId;

  @field(2)
  algorithm_name: string;

  @field(3)
  algorithm_description: string;

  @field(4)
  need_external: ExtInfoId[];

  @field(5)
  @doc("param name: param default")
  algorithm_params: Record<string>;

  @field(6)
  algorithm_scales: algorithmScale[];

  @field(7)
  algorithm_data_ids: algorithmDataId[];

  @field(8)
  version: Common.version;

  @field(9)
  @visibility("read", "query")
  first_entry_at: UtcDateTime;

  @field(10)
  @visibility("read", "query")
  last_entry_at: UtcDateTime;

  @field(11)
  @visibility("read", "query")
  last_updated_at: UtcDateTime;

  @field(12)
  @visibility
  secret_api_key: Auth.apiKey;
}

model AlgorithmData {
  @field(1)
  @visibility("read", "query", "update", "delete")
  algorithm_id: algorithmId;

  @field(2)
  version: Common.version;

  @field(3)
  @visibility("read", "query")
  algorithm_data_id: algorithmDataId;

  @field(4)
  algorithm_scale: algorithmScale;

  @field(5)
  content_type: DataType;

  @field(6)
  content: bytes;

  @field(7)
  @visibility("read", "query")
  entry_at: UtcDateTime;

  @field(8)
  @visibility("read", "query")
  target_at: UtcDateTime;
}

@route("/algorithm")
@tag("Algorithm")
@doc("Algorithm API")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "api_key">)
namespace BeLifeline.Algorithm {
  @Protobuf.service
  interface Algorithm {
    @get list(
      @field(1)
      @query
      limit?: int32,
    ): {
      @field(1)
      algorithms: AlgorithmInfomation[];
    };
  }

  @Protobuf.service
  @route("/{algorithm_id}")
  interface EachAlgorithm {
    @put
    update(
      @field(1)
      @path
      algorithm_id: algorithmId,

      @field(2)
      @body
      update_algorithm: AlgorithmInfomation,
    ): AlgorithmInfomation;
    @get get(
      @field(1)
      @path
      algorithm_id: algorithmId,
    ): AlgorithmInfomation;
  }

  @Protobuf.service
  @route("/{algorithm_id}/data")
  interface EachAlgorithmData {
    @get
    get(
      @field(1)
      @path
      algorithm_id: algorithmId,

      @field(2)
      @query
      scale: algorithmScale,
    ): AlgorithmData;
    @put
    update(
      @field(1)
      @path
      algorithm_id: algorithmId,

      @field(2)
      @query
      scale: algorithmScale,

      @field(3)
      @body
      update_data: AlgorithmData,
    ): AlgorithmData;
  }
}
