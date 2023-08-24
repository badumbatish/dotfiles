return {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",

    config = function()
        require("mason").setup()
        require("mason-nvim-dap").setup({
            ensure_installed = {
                "bash",
                "python",
                "codelldb",
                "javadbg",
                "javatest",
            }
        }








        )
    end
}
