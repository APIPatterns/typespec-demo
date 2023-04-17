import { createTypeSpecLibrary } from "@typespec/compiler";
import { createRule, getLinter } from "@typespec/lint";
import { isQueryParam } from "@typespec/http";

export const myLibrary = createTypeSpecLibrary({
  name: "myLibrary",
  diagnostics: {
    // This diagnostic will be issued for any operation without an `api-version` query parameter.
    "version-policy": {
      severity: "error",
      messages: {
        default:
          "Every operation must have a required 'api-version' query parameter",
      },
    },
  },
});

// Return true if the parameter is an `api-version` query parameter.
const isApiVersion = (p) => {
  return p.name === "apiVersion" && !p.optional && p.type.name === 'string';
}

const versionPolicyRule = createRule({
  name: "version-policy",
  create({ program }) {
    return {
      // check each operation for an apiVersion query parameter. Issue version-policy diagnostic if not found.
      operation: (op) => {
        const params = op.parameters?.properties;
        if (![...params.values()].some(p => isApiVersion(p) && isQueryParam(program, p))) {
          myLibrary.reportDiagnostic(program, {
            code: "version-policy",
            target: op,
          });
        }
      } 
    };
  },
});

const linter = getLinter(myLibrary);

// Register and enable the version-policy linter rule.
linter.registerRule(versionPolicyRule, { enable: true });
linter.enableRule("myLibrary/version-policy");

export function $onValidate(program) {
  linter.lintOnValidate(program);
}
