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

/**
 * The admin api is the endpoint that the belifeline administrator (=developer) accesses to configure the server.
 * Therefore, it is not open to the public.
 */
@route("/admin")
@tag("Admin")
@summary("Admin API")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "api_key">)
namespace BeLifeline.Admin {
  @route("/koyo")
  interface Koyo {
    /**
     * Set up koyo's basic information and register it in the database.
     * You can get koyo_id by hitting this endpoint.
     * For updating basic information, please use /koyo api instead of admin api
     */
    @summary("Create new koyo information")
    @post
    create(koyo: KoyoInfomation): KoyoInfomation & {
      @secret
      api_key: Auth.apiKey;
    };

    @route("/{koyo_id}/revoke")
    @post
    @summary("Revoke koyo api key")
    revoke(@path koyo_id: koyoId): {
      koyo_id: koyoId;

      @secret
      api_key: Auth.apiKey;
    };

    @route("/{koyo_id}")
    @delete
    @summary("Delete koyo information")
    delete(@path koyo_id: koyoId): {
      @summary("Deleted koyo id")
      delete_koyo_id: koyoId;
    };
  }

  @route("/extinfo")
  interface ExtInfo {
    @post create(extinfo: ExternalInfomation): ExternalInfomation & {
      @secret
      api_key: Auth.apiKey;
    };

    @route("/{extinfo_id}/revoke")
    @post
    revoke(@path extinfo_id: ExtInfoId): {
      extinfo_id: ExtInfoId;

      @secret
      api_key: Auth.apiKey;
    };

    @route("/{extinfo_id}")
    @delete
    delete(@path extinfo_id: ExtInfoId): {
      delete_extinfo_id: ExtInfoId;
    };
  }

  @route("/client")
  interface Client {
    @post create(client: ClientData): ClientData;
    @get list(@query limit?: int32): ClientData[];
    @route("/{client_id}")
    @post
    delete(@path client_id: clientId): {
      delete_client_id: clientId;
    };
    @route("/{client_id}/revoke")
    @post
    revoke(@path client_id: clientId): {
      client_id: clientId;

      @secret
      api_key: Auth.apiKey;
    };
  }
}
