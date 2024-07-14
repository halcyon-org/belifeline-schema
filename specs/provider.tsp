import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

import "./algorithm.tsp";
import "./types.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using BeLifeline.Algorithm;
using BeLifeline.Types;

@versioned(Versions)
namespace BeLifeline.Provider;
enum Versions {
  latest: "latest",
}

scalar clientId extends Common.uuid;

enum RequestType {
  TileMapService,
  GeoJSON,
}

model ClientData {
  @visibility("read", "query", "update", "delete")
  client_id: clientId;

  name: string;

  @visibility("read", "query")
  @secret
  api_key: Auth.apiKey;
}

@route("/provider")
@tag("Provider")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "api_key">)
namespace BeLifeline.Provider {
  @route("/clients")
  interface Clients {
    @doc("Get client of api key")
    @get
    getClient(): ClientData;
  }

  @route("/data")
  interface Data {
    @get list(@query limit?: int32): AlgorithmInfomation[];
  }

  @route("/data/{altorithm_id}")
  interface EachData {
    @get get(
      @path altorithm_id: algorithmId,
      @query type: RequestType,
      @query algorithm_data_id?: algorithmDataId,
      @query area?: GeoJSON.MultiPolygon,
      @query until?: Date.DateUntil,
      @query until_entry?: Date.DateUntil,
      @query param?: Record<string>,
      @query scale?: algorithmScale,
    ): AlgorithmData;
  }
}
