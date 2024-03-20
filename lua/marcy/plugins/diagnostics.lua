return {
    { 'dmmulroy/ts-error-translator.nvim' },
    { "artemave/workspace-diagnostics.nvim" },
    config = function()
        require("ts-error-translator").setup()
    end
}
