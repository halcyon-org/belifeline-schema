import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

import "./koyo.tsp";
import "./types.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using BeLifeline.Koyo;
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

@summary("Client data")
@doc("Data for the client to use the provider api.")
model ClientData {
  @visibility("read", "query", "update", "delete")
  client_id: clientId;

  username: string;

  @visibility("read", "query")
  @secret
  api_key: Auth.apiKey;

  @visibility("read", "query")
  created_at: utcDateTime;

  @doc("The last time the client used the api.")
  @visibility("read", "query")
  last_used_at: utcDateTime;

  @doc("The last time the client updated the data.")
  @visibility("read", "query")
  last_updated_at: utcDateTime;
}

@route("/provider")
@tag("Provider")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "api_key">)
namespace BeLifeline.Provider {
  @route("/data")
  interface Data {
    @summary("List of koyo's basic information")
    @get
    list(@query limit?: int32): KoyoInfomation[];
  }

  @route("/data/{altorithm_id}")
  interface EachData {
    @summary("Get data from the koyo")
    @get
    get(
      @path altorithm_id: koyoId,
      @query type: RequestType,
      @query koyo_data_id?: koyoDataId,
      @query area?: GeoJSON.MultiPolygon,
      @query until?: Date.DateUntil,
      @query until_entry?: Date.DateUntil,
      @query param?: Record<string>,
      @query scale?: koyoScale,
    ): KoyoData;
  }
}
