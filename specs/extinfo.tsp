import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace BeLifeline;

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
namespace ExtInfo {
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
    get(): {
      @header contentType: "image/jpeg";
      @body image: bytes;
    };
  }
}
