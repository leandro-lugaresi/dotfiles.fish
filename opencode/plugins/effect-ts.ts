import type { Plugin } from "@opencode-ai/plugin"
import { tool } from "@opencode-ai/plugin"
import * as fs from "node:fs"
import * as path from "node:path"

const PATTERNS: Record<string, { match: RegExp[]; label: string }> = {
  services: {
    match: [/ServiceMap\.Service/, /Layer\.effect/, /Layer\.sync/, /Layer\.scoped/],
    label: "Services & Layers",
  },
  schema: {
    match: [/Schema\.Class/, /Schema\.TaggedClass/, /Schema\.Struct/, /Schema\.brand/],
    label: "Data Modeling",
  },
  errors: {
    match: [/Schema\.TaggedErrorClass/, /Schema\.TaggedError/, /Effect\.catchTag/, /Schema\.Defect/],
    label: "Error Handling",
  },
  testing: {
    match: [/from ["']@effect\/vitest/, /it\.effect/, /it\.layer/, /it\.live/],
    label: "Testing",
  },
  http: {
    match: [/from ["']effect\/unstable\/http/, /HttpClient/, /HttpClientResponse/, /FetchHttpClient/],
    label: "HTTP Clients",
  },
  cli: {
    match: [/from ["']effect\/unstable\/cli/, /Command\.make/, /Argument\./, /Flag\./],
    label: "CLI",
  },
  config: {
    match: [/Config\.redacted/, /Config\.schema/, /ConfigProvider/, /Config\.int\(/, /Config\.string\(/],
    label: "Config",
  },
  processes: {
    match: [/Scope\.make/, /Scope\.extend/, /Effect\.forkDaemon/, /Effect\.forkScoped/, /Command\.start/],
    label: "Processes & Scopes",
  },
}

function detectEffectProject(cwd: string): boolean {
  try {
    const pkg = JSON.parse(fs.readFileSync(path.join(cwd, "package.json"), "utf-8"))
    const allDeps = { ...pkg.dependencies, ...pkg.devDependencies, ...pkg.peerDependencies }
    return "effect" in allDeps || "@effect/platform" in allDeps || "@effect/cli" in allDeps
  } catch {
    return false
  }
}

function detectPatterns(content: string): string[] {
  const detected = new Set<string>()
  for (const [, { match, label }] of Object.entries(PATTERNS)) {
    for (const re of match) {
      if (re.test(content)) {
        detected.add(label)
        break
      }
    }
  }
  return [...detected]
}

function generateServiceScaffold(name: string): string {
  return `import { Effect, Layer, Schema, ServiceMap } from "effect"

const ${name}Id = Schema.String.pipe(Schema.brand("${name}Id"))
type ${name}Id = typeof ${name}Id.Type

class ${name} extends ServiceMap.Service<
  ${name},
  {
    readonly findById: (id: ${name}Id) => Effect.Effect<unknown>
    readonly create: (data: unknown) => Effect.Effect<unknown>
  }
>("@app/${name}") {
  static readonly layer = Layer.effect(
    ${name},
    Effect.gen(function* () {
      const findById = Effect.fn("${name}.findById")(function* (id: ${name}Id) {
        return yield* Effect.succeed({ id })
      })

      const create = Effect.fn("${name}.create")(function* (data: unknown) {
        return yield* Effect.succeed(data)
      })

      return { findById, create }
    })
  )

  static readonly testLayer = Layer.sync(${name}, () => {
    const store = new Map<${name}Id, unknown>()

    const findById = (id: ${name}Id) => Effect.succeed(store.get(id))
    const create = (data: unknown) => Effect.sync(() => {
      return data
    })

    return { findById, create }
  })
}`
}

function generateSchemaScaffold(name: string): string {
  return `import { Schema } from "effect"

const ${name}Id = Schema.NonEmptyString.pipe(Schema.brand("${name}Id"))
type ${name}Id = typeof ${name}Id.Type

class ${name} extends Schema.Class("${name}")({
  id: ${name}Id,
  name: Schema.String,
  createdAt: Schema.Date,
}) {
  get displayName() {
    return this.name
  }
}

const ${name}FromJson = Schema.fromJsonString(${name})`
}

function generateErrorScaffold(name: string): string {
  return `import { Schema } from "effect"

class ${name}NotFoundError extends Schema.TaggedErrorClass("${name}NotFoundError")(
  "${name}NotFoundError",
  {
    id: Schema.String,
    message: Schema.String,
  }
) {}

class ${name}ValidationError extends Schema.TaggedErrorClass("${name}ValidationError")(
  "${name}ValidationError",
  {
    field: Schema.String,
    message: Schema.String,
  }
) {}

class ${name}Error extends Schema.TaggedErrorClass("${name}Error")(
  "${name}Error",
  {
    cause: Schema.Defect,
  }
) {}`
}

function generateTestScaffold(name: string): string {
  return `import { describe, expect, it } from "@effect/vitest"
import { Effect, Layer } from "effect"

describe("${name}", () => {
  it.effect("creates an instance", () =>
    Effect.gen(function* () {
      expect(true).toBe(true)
    })
  )

  it.effect("finds by id", () =>
    Effect.gen(function* () {
      expect(true).toBe(true)
    })
  )

  it.effect("handles errors", () =>
    Effect.gen(function* () {
      expect(true).toBe(true)
    })
  )
})`
}

export const EffectTsPlugin: Plugin = async ({ directory }) => {
  let isEffectProject = false
  const injectedHints = new Set<string>()

  try {
    isEffectProject = detectEffectProject(directory)
  } catch {
    isEffectProject = false
  }

  return {
    event: async ({ event }) => {
      if (event.type === "session.created") {
        try {
          isEffectProject = detectEffectProject(directory)
        } catch {
          isEffectProject = false
        }
      }
    },

    "experimental.chat.system.transform": async (_input, output) => {
      if (!isEffectProject) return

      output.system.push(
        "This project uses Effect v4. Load the effect-ts skill for best practices. " +
        "Key conventions: ServiceMap.Service (not Effect.Service), Schema.TaggedErrorClass for errors, " +
        "Effect.gen + Effect.fn for effectful code, Layer.effect/sync for implementations, " +
        "Schema.brand for entity IDs, Effect.catchTag for error recovery."
      )
    },

    "tool.execute.after": async (input, output) => {
      if (!isEffectProject || input.tool !== "read") return
      if (!output.output || typeof output.output !== "string") return

      const content = output.output
      if (content.length < 50) return

      const patterns = detectPatterns(content)
      const newPatterns = patterns.filter((p) => !injectedHints.has(p))

      if (newPatterns.length === 0) return

      const toInject = newPatterns.slice(0, 2)
      for (const pattern of toInject) {
        injectedHints.add(pattern)
      }

      output.output =
        content +
        "\n\n[Effect patterns detected: " +
        toInject.join(", ") +
        ". Load the effect-ts skill for reference.]"
    },

    tool: {
      effect_scaffold: tool({
        description:
          "Generate idiomatic Effect v4 boilerplate. Creates service, schema, error, or test scaffolds following effect-solutions best practices.",
        args: {
          type: tool.schema.enum(["service", "schema", "error", "test"]).describe("Type of scaffold to generate"),
          name: tool.schema.string().describe("Name for the generated type/service (PascalCase)"),
        },
        async execute(params) {
          let scaffold: string
          switch (params.type) {
            case "service":
              scaffold = generateServiceScaffold(params.name)
              break
            case "schema":
              scaffold = generateSchemaScaffold(params.name)
              break
            case "error":
              scaffold = generateErrorScaffold(params.name)
              break
            case "test":
              scaffold = generateTestScaffold(params.name)
              break
          }
          return {
            output: scaffold,
            metadata: { type: params.type, name: params.name },
          }
        },
      }),
    },
  }
}
