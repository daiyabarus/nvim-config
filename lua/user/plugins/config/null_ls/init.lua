local null_present, null_ls = pcall(require, "null-ls")
if not null_present then
    require("packer").compile()
    return
end

local utils = require("user.plugins.config.lspconfig.utils")
local null_ls_sources = require("user.plugins.config.null_ls.sources")

local sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.stylua.with({
        extra_args = {
            "--config-path",
            vim.fn.expand("~/.stylua.toml"),
        },
    }),
    -- null_ls.builtins.formatting.isort,
    -- null_ls_sources.black,
    null_ls_sources.latexindent,
    -- Diagnostics
    null_ls.builtins.diagnostics.flake8.with({
        extra_args = {
            "--config",
            vim.fn.expand("~/.flake8"),
        },
    }),
    null_ls_sources.chktex,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.isort.with {
        extra_args = {
            "--fast",
            "--profile",
            "black"
        },
    },
    null_ls.builtins.formatting.black.with {
        extra_args = {
            "--fast",
            "--line-length",
            "80",
            "--experimental-string-processing"
        },
    },
    null_ls_sources.latexindent,
    null_ls_sources.chktex,
}

null_ls.setup({
    debounce = 500,
    default_timeout = 10000,
    diagnostics_format = "#{m} (#{s})",
    sources = sources,
    on_attach = utils.on_attach,
})
