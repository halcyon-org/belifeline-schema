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

scalar clientId extends string;
scalar apiKey extends string;

model ClientData {
  @visibility("read", "query", "update", "delete")
  client_id: clientId;

  name: string;

  @visibility("read", "query")
  apiKey: apiKey;
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
      algorithm_data_id?: algorithmDataId,
      area?: GeoJSON.MultiPolygon,
      until?: Date.DateUntil,
      until_entry?: Date.DateUntil,
      scale?: algorithmScale,
    ): AlgorithmData;
  }
}
