import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

import "./types.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using BeLifeline.Types;

@versioned(Versions)
namespace BeLifeline.ExtInfo;
enum Versions {
  latest: "lastest",
}

@knownValues(ExtInfoIdName)
scalar ExtInfoId extends string;
enum ExtInfoIdName {
  hoge: "HOGE_ID",
}

model ExternalInfomation {
  @visibility("read", "query", "update", "delete")
  external_id: ExtInfoId;

  external_name: string;
  external_description: string;
  first_entry_at: UtcDateTime;
  last_updated_at: UtcDateTime;
  updated_history: UtcDateTime[];
}

@route("/extinfo")
@tag("External Information")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "api_key">)
namespace BeLifeline.ExtInfo {
  interface ExtInfo {
    @get list(@query limit?: int32): ExternalInfomation[];
  }

  @route("/{extinfo_id}")
  interface EachExtInfo {
    @get get(@path extinfo_id: ExtInfoId): ExternalInfomation;
  }

  @route("/HOGE_ID/data")
  interface Hoge {
    @get
    get(@query area?: GeoJSON.MultiPolygon): {
      @header contentType: "image/jpeg";
      @body image: bytes;
    }[];
  }
}
