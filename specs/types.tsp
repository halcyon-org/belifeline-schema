import "@typespec/versioning";

import "@typespec/json-schema";

using TypeSpec.Versioning;

@versioned(Versions)
namespace BeLifeline.Types;
enum Versions {
  latest: "latest",
}

namespace Common {
  @doc("Semantic versioning")
  @pattern("^\\d+\\.\\d+\\.\\d+$")
  scalar version extends string;

  @format("uuid")
  scalar uuid extends string;
}

@doc("https://ja.wikipedia.org/wiki/GeoJSON")
namespace GeoJSON {
  model Point {
    type: "Point";
    coordinates: [numeric, numeric];
  }
  model MultiPoint {
    type: "MultiPoint";
    coordinates: Point.coordinates[];
  }
  model Polygon {
    type: "Polygon";
    coordinates: MultiPoint.coordinates;
  }
  model MultiPolygon {
    type: "MultiPolygon";
    coordinates: Polygon.coordinates[];
  }
}

namespace Date {
  model DateUntil {
    before?: utcDateTime;
    after?: utcDateTime;
  }
}

namespace Auth {
  scalar apiKey extends string;
}
