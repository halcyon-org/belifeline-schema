import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

import "./koyo.tsp";
import "./extinfo.tsp";
import "./provider.tsp";
import "./types.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

using BeLifeline.Koyo;
using BeLifeline.ExtInfo;
using BeLifeline.Provider;
using BeLifeline.Types;

@route("/admin")
@tag("Admin")
@doc("Admin API")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "api_key">)
namespace BeLifeline.Admin {
  @route("/koyo")
  interface Koyo {
    @post create(koyo: KoyoInfomation): KoyoInfomation & {
      @secret
      api_key: Auth.apiKey;
    };
    @route("/{koyo_id}")
    @delete
    delete(@path koyo_id: koyoId): {
      delete_koyo_id: koyoId;
    };
  }

  @route("/extinfo")
  interface ExtInfo {
    @post create(extinfo: ExternalInfomation): ExternalInfomation;

    @route("/{extinfo_id}")
    @delete
    delete(@path extinfo_id: ExtInfoId): {
      delete_extinfo_id: ExtInfoId;
    };
  }

  @route("/client")
  interface Client {
    @post create(client: ClientData): ClientData;
    @route("/{client_id}")
    @post
    delete(@path client_id: clientId): {
      delete_client_id: clientId;
    };
  }
}
