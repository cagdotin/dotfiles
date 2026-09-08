import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import type { AutocompleteItem } from "@earendil-works/pi-tui";

const EXTENSIONS_ARGUMENT = "extensions";

export default function (pi: ExtensionAPI) {
  pi.registerCommand("update", {
    description: "Update Pi, or update extensions only, then reload",
    getArgumentCompletions: (prefix: string): AutocompleteItem[] | null => {
      if (!EXTENSIONS_ARGUMENT.startsWith(prefix.trim())) return null;
      return [{ value: EXTENSIONS_ARGUMENT, label: EXTENSIONS_ARGUMENT, description: "Update extensions only" }];
    },
    handler: async (args, ctx) => {
      const target = args.trim().toLowerCase();
      if (target !== "" && target !== EXTENSIONS_ARGUMENT) {
        ctx.ui.notify("Usage: /update [extensions]", "error");
        return;
      }

      const updateArgs = target === EXTENSIONS_ARGUMENT
        ? ["update", "--extensions"]
        : ["update", "--self"];
      const label = target === EXTENSIONS_ARGUMENT ? "extensions" : "Pi";

      ctx.ui.setStatus("update", `Updating ${label}...`);

      let result;
      try {
        result = await pi.exec("pi", updateArgs);
      } catch (error) {
        ctx.ui.setStatus("update", undefined);
        const message = error instanceof Error ? error.message : String(error);
        ctx.ui.notify(`Failed to update ${label}: ${message}`, "error");
        return;
      }

      ctx.ui.setStatus("update", undefined);
      if (result.code !== 0) {
        const detail = result.stderr.trim() || result.stdout.trim() || `exit code ${result.code}`;
        ctx.ui.notify(`Failed to update ${label}: ${detail}`, "error");
        return;
      }

      const detail = result.stdout.trim();
      ctx.ui.notify(detail || `${label} updated. Reloading...`, "info");
      await ctx.reload();
      return;
    },
  });
}
