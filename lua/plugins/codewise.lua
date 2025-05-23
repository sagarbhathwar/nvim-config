return {
  "https://github.qualcomm.com/rkolacha/codewise.nvim",
  event = "VeryLazy",
  config = function()
    -- Set environment variables
    vim.env.CODEWISE_URL = "https://qpilot-api.qualcomm.com/inference"
    vim.env.CHATWISE_URL = "https://chatwise.qualcomm.com/chatwise_api"
    vim.env.CWISE_API_KEY = "2eab737f-5155-40af-a612-fd268c9d2950"

    require("codewise").setup()
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>cc", "<cmd>Codewise<CR>", { noremap = true, silent = true, desc = "Codewise" })
    keymap.set(
      { "n", "v" },
      "<leader>ce",
      "<cmd>CodewiseEditWithInstruction<CR>",
      { noremap = true, silent = true, desc = "Edit with instruction" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cp",
      "<cmd>CodewiseCompleteCode<CR>",
      { noremap = true, silent = true, desc = "Complete Code" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cg",
      "<cmd>CodewiseRun grammar_correction<CR>",
      { noremap = true, silent = true, desc = "Grammar Correction" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>ct",
      "<cmd>CodewiseRun translate<CR>",
      { noremap = true, silent = true, desc = "Translate" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>ck",
      "<cmd>CodewiseRun keywords<CR>",
      { noremap = true, silent = true, desc = "Keywords" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cd",
      "<cmd>CodewiseRun docstring<CR>",
      { noremap = true, silent = true, desc = "Docstring" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>ca",
      "<cmd>CodewiseRun add_tests<CR>",
      { noremap = true, silent = true, desc = "Add Tests" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>co",
      "<cmd>CodewiseRun optimize_code<CR>",
      { noremap = true, silent = true, desc = "Optimize Code" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cs",
      "<cmd>CodewiseRun summarize<CR>",
      { noremap = true, silent = true, desc = "Summarize" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cf",
      "<cmd>CodewiseRun fix_bugs<CR>",
      { noremap = true, silent = true, desc = "Fix Bugs" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cF",
      "<cmd>CodewiseRun fix_bugs_with_shorter_details<CR>",
      { noremap = true, silent = true, desc = "Fix Bugs" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cx",
      "<cmd>CodewiseRun explain_code<CR>",
      { noremap = true, silent = true, desc = "Explain Code" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cX",
      "<cmd>CodewiseRun explain_code_with_details<CR>",
      { noremap = true, silent = true, desc = "Explain Code" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cr",
      "<cmd>CodewiseRun roxygen_edit<CR>",
      { noremap = true, silent = true, desc = "Roxygen Edit" }
    )
    keymap.set(
      { "n", "v" },
      "<leader>cl",
      "<cmd>CodewiseRun code_readability_analysis<CR>",
      { noremap = true, silent = true, desc = "Code Readability Analysis" }
    )
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    -- "folke/trouble.nvim",
    -- "nvim-telescope/telescope.nvim",
    -- {
    --   "nvim-treesitter/nvim-treesitter",
    --   build = ":TSUpdate",
    --   config = function()
    --     require("nvim-treesitter.configs").setup({
    --       ensure_installed = { "cpp", "lua", "python" }, -- Add languages you need
    --       highlight = {
    --         enable = true,
    --       },
    --     })
    --   end,
    -- },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons", -- optional, for file icons
      },
      config = function()
        require("render-markdown").setup({
          auto_render = true, -- Enable automatic rendering
        })
      end,
    },
  },
}
