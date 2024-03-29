local deps_ok, lspconfig, util, cmp_lsp, mason_lspconfig, mason = pcall(function()
  return require("lspconfig"),
    require("lspconfig.util"),
    require("cmp_nvim_lsp"),
    require("mason-lspconfig"),
    require("mason")
end)
if not deps_ok then
  return
end

local signs = {
  { name = "DiagnosticSignError", text = "●" },
  { name = "DiagnosticSignWarn", text = "●" },
  { name = "DiagnosticSignHint", text = "●" },
  { name = "DiagnosticSignInfo", text = "●" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = false,
  signs = { active = signs },
  update_in_insert = true,
  underline = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

local capabilities
do
  local default_capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
      codeAction = {
        resolveSupport = {
          properties = vim.list_extend(default_capabilities.textDocument.codeAction.resolveSupport.properties, {
            "documentation",
            "detail",
            "additionalTextEdits",
          }),
        },
      },
    },
  }
end

util.default_config = vim.tbl_deep_extend("force", util.default_config, {
  capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities(capabilities)
  ),
})

mason.setup({
  max_concurrent_installers = 10,
  log_level = vim.log.levels.DEBUG,
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  },
})

mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({})
  end,
  ["tsserver"] = function()
    require("typescript").setup({
      server = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
    })
  end,
  ["jdtls"] = function()
    local function progress_handler()
      ---@type table<string, boolean>
      local tokens = {}
      ---@type table<string, boolean>
      local ready_projects = {}
      ---@param result {type:"Starting"|"Started"|"ServiceReady", message:string}
      return function(_, result, ctx)
        local cwd = vim.loop.cwd()
        if ready_projects[cwd] then
          return
        end
        local token = tokens[cwd] or vim.tbl_count(tokens)
        if result.type == "Starting" and not tokens[cwd] then
          tokens[cwd] = token
          vim.lsp.handlers["$/progress"](nil, {
            token = token,
            value = {
              kind = "begin",
              title = "jdtls",
              message = result.message,
              percentage = 0,
            },
          }, ctx)
        elseif result.type == "Starting" then
          local _, percentage_index = string.find(result.message, "^%d%d?%d?")
          local percentage = 0
          local message = result.message
          if percentage_index then
            percentage = tonumber(string.sub(result.message, 1, percentage_index))
            message = string.sub(result.message, percentage_index + 3)
          end

          vim.lsp.handlers["$/progress"](nil, {
            token = token,
            value = {
              kind = "report",
              message = message,
              percentage = percentage,
            },
          }, ctx)
        elseif result.type == "Started" then
          vim.lsp.handlers["$/progress"](nil, {
            token = token,
            value = {
              kind = "report",
              message = result.message,
              percentage = 100,
            },
          }, ctx)
        elseif result.type == "ServiceReady" then
          ready_projects[cwd] = true
          vim.lsp.handlers["$/progress"](nil, {
            token = token,
            value = {
              kind = "end",
              message = result.message,
            },
          }, ctx)
        end
      end
    end

    lspconfig.jdtls.setup({
      cmd = {
        "jdtls",
        "--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand("$MASON/share/jdtls/lombok.jar")),
      },
      handlers = {
        ["language/status"] = progress_handler,
      },
    })
  end,
  ["jsonls"] = function()
    lspconfig.jsonls.setup({
      filetypes = { "json", "jsonc", "json5" },
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
        },
      },
    })
  end,
  ["rust_analyzer"] = function()
    require("rust-tools").setup({
      tools = {
        inlay_hints = { auto = false },
        executor = require("rust-tools/executors").toggleterm,
        hover_actions = { border = "solid" },
      },
      dap = {
        adapter = {
          type = "server",
          port = "${port}",
          host = "127.0.0.1",
          executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
          },
        },
      },
    })
  end,
  ["lua_ls"] = function()
    require("neodev").setup({})
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          format = {
            enable = false,
          },
          hint = {
            enable = true,
            arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
            await = true,
            paramName = "Disable", -- "All", "Literal", "Disable"
            paramType = false,
            semicolon = "Disable", -- "All", "SameLine", "Disable"
            setType = true,
          },
          diagnostics = {
            globals = { "P" },
          },
          workspace = {
            checkThirdParty = false,
          },
        },
      },
    })
  end,
  ["yamlls"] = function()
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          hover = true,
          completion = true,
          validate = true,
          schemas = require("schemastore").json.schemas(),
        },
      },
    })
  end,
})
