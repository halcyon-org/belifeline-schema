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
