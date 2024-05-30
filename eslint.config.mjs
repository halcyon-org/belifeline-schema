import antfu from "@antfu/eslint-config";

export default antfu({
  stylistic: {
    semi: true,
    quotes: "double",
  },
  ignores: ["bundled", "schema"],
});
