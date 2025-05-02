return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
				  library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				  },
				},
			  },
		},
		config = function()
			require("lspconfig").lua_ls.setup{}
			require("lspconfig").clangd.setup{}
			require("lspconfig").gopls.setup{}
			require("lspconfig").basedpyright.setup{
				basedpyright = {
					analysis = {
						typeCheckingMode = "standard",
					}
				}
			}
			vim.keymap.set("n", "<leader>]", "<C-]>")
			vim.keymap.set("n", "<leader>[", "<C-t>")
			-- Remember you have omnicompletion with C-x C-o, figure out a remap?

		end
	}
}
