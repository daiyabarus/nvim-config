local helper = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING
local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING
local DIAGNOSTICS = methods.internal.DIAGNOSTICS

local M = {}

M.latexindent = helper.make_builtin({
    name = "latexindent",
    method = FORMATTING,
    filetypes = { "tex" },
    generator_opts = {
        command = "latexindent.exe",
        to_stdin = true,
        args = { "-r" },
    },
    factory = helper.formatter_factory,
})

M.black = helper.make_builtin({
    name = "black",
    method = FORMATTING,
    filetypes = { "python" },
    generator_opts = {
        command = "black",
        args = {
            "--quiet",
            "-",
        },
        to_stdin = true,
    },
    factory = helper.formatter_factory,
})

M.chktex = helper.make_builtin({
    name = "chktex",
    method = DIAGNOSTICS,
    filetypes = { "tex" },
    generator_opts = {
        command = "chktex",
        to_stdin = true,
        from_stderr = true,
        args = {
            -- Only current file
            "-I",
            -- Disable printing version information to stderr
            "-q",
            -- Format output
            "-f%l:%c:%d:%k:%n:%m\n",
        },
        format = "line",
        check_exit_code = function(code)
            return code <= 1
        end,
        on_output = helper.diagnostics.from_pattern(
            [[(%d+):(%d+):(%d+):(%w+):(%d+):(.+)]],
            { "row", "col", "_length", "severity", "code", "message" },
            {
                adapters = {
                    helper.diagnostics.adapters.end_col.from_length,
                },
                severities = {
                    Error = helper.diagnostics.severities["error"],
                    Warning = helper.diagnostics.severities["warning"],
                },
            }
        ),
    },
    factory = helper.generator_factory,
})

return M
