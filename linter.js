import { createCadlLibrary } from "@cadl-lang/compiler";
import { createRule, getLinter } from "@cadl-lang/lint";
import { isQueryParam } from "@cadl-lang/rest/http";

export const myLibrary = createCadlLibrary({
  name: "myLibrary",
  diagnostics: {
    "version-policy": {
      severity: "error",
      messages: {
        default:
          "Every operation must have a required 'api-version' query parameter",
      },
    },
  },
});

const isApiVersion = (p) => {
  return p.name === "apiVersion" && !p.optional && p.type.name === 'string';
}

const versionPolicyRule = createRule({
  name: "version-policy",
  create({ program }) {
    return {
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

export function $onValidate(program) {
  linter.registerRule(versionPolicyRule, { enable: true });
  linter.enableRule("myLibrary/version-policy");
  linter.lintOnValidate(program);
}
