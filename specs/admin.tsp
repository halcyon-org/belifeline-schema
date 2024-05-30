import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

import "./algorithm.tsp";
import "./extinfo.tsp";
import "./provider.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

using BeLifeline.Algorithm;
using BeLifeline.ExtInfo;
using BeLifeline.Provider;

@route("/admin")
@tag("Admin")
@doc("Admin API")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "api_key">)
namespace BeLifeline.Admin {
  @route("/algorithm")
  interface Algorithm {
    @post create(algorithm: AlgorithmInfomation): AlgorithmInfomation & {
      bearer_token: string;
    };
    @route("/{algorithm_id}")
    @delete
    delete(@path algorithm_id: algorithmId): {
      delete_algorithm_id: algorithmId;
    };
  }

  @route("/extinfo")
  interface ExtInfo {
    @post create(extinfo: ExternalInfomation): ExternalInfomation & {
      bearer_token: string;
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
    @route("/{client_id}")
    @post
    delete(@path client_id: clientId): {
      delete_client_id: clientId;
    };
  }
}
