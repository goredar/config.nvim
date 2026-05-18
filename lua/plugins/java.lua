local jdk21 = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
local jdk17 = "/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"

return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      table.insert(opts.cmd, "--java-executable=" .. jdk21 .. "/bin/java")

      opts.settings.java = vim.tbl_deep_extend("force", opts.settings.java or {}, {
        import = {
          gradle = {
            java = { home = jdk17 },
          },
        },
        configuration = {
          runtimes = {
            {
              name = "JavaSE-17",
              path = jdk17,
              default = true,
            },
          },
        },
      })
    end,
  },
}
