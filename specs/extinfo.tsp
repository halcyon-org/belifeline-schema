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

enum ExtInfoId {
  hoge: "HOGE_ID",
}

model ExternalInfomation {
  external_id: ExtInfoId;
  external_name: string;
  external_description: string;
  first_entry_at: utcDateTime;
  last_updated_at: utcDateTime;
  updated_history: utcDateTime[];
}

@route("/extinfo")
@tag("External Information")
@useAuth(BearerAuth)
namespace BeLifeline.ExtInfo {
  interface ExtInfo {
    @get list(@query limit?: numeric): ExternalInfomation[];
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
