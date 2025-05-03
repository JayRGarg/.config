local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

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
			require("lspconfig").lua_ls.setup{
				capabilities = lsp_capabilities,
			}
			require("lspconfig").clangd.setup{
				capabilities = lsp_capabilities,
			}
			require("lspconfig").gopls.setup{
				capabilities = lsp_capabilities,
			}
			require("lspconfig").basedpyright.setup{
				basedpyright = {
					analysis = {
						typeCheckingMode = "standard",
					}
				},
				capabilities = lsp_capabilities,
			}
			-- vim.keymap.set("n", "<leader>]", "<C-]>")
			-- vim.keymap.set("n", "<leader>[", "<C-t>")
			vim.keymap.set("n", "]", "<C-]>")
			vim.keymap.set("n", "[", "<C-t>")
			-- Remember you have omnicompletion with C-x C-o, figure out a remap?

		end
	}
}
