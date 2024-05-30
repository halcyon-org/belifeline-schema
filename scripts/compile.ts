import * as fs from "node:fs";
import * as path from "node:path";

const dirPath = path.resolve("schema/@typespec/openapi3");

const yamlFiles = fs
  .readdirSync(dirPath)
  .filter(file => file.endsWith(".yaml"));
const versionRegex = /(\d+\.\d+\.\d+)/;

yamlFiles.sort((a, b) => {
  const versionA = versionRegex.exec(a)?.[1] ?? "0.0.0";

  const versionB = versionRegex.exec(b)?.[1] ?? "0.0.0";

  return versionA.localeCompare(versionB, undefined, { numeric: true });
});

const latestFile = yamlFiles[yamlFiles.length - 1];
const latestFilePath = path.join(dirPath, latestFile);

const symlinkPath = path.join(dirPath, "openapi.yaml");
const relativeTarget = path.relative(path.dirname(symlinkPath), latestFilePath);

try {
  if (
    fs.existsSync(symlinkPath)
    || fs.lstatSync(symlinkPath).isSymbolicLink()
  ) {
    fs.unlinkSync(symlinkPath);
  }

  fs.symlinkSync(relativeTarget, symlinkPath);

  console.log(`Linked ${symlinkPath} -> ${relativeTarget}`);
}
catch (err) {
  console.error(`Error creating symlink: ${err}`);
}
