import "@typespec/json-schema";

namespace BeLifeline.Types;

@doc("https://ja.wikipedia.org/wiki/GeoJSON")
namespace GeoJSON {
  model Point {
    type: "Point";
    coordinates: [numeric, numeric];
  }
  model MultiPoint {
    type: "MultiPoint";
    coordinates: [numeric, numeric][];
  }
  model Polygon {
    type: "Polygon";
    coordinates: [[numeric, numeric]];
  }
  model MultiPolygon {
    type: "MultiPolygon";
    coordinates: [[numeric, numeric]][];
  }
}
