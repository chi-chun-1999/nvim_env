return{
  "BlinkResearchLabs/blink-edit.nvim",
  config = function()
    require("blink-edit").setup({
      llm = {
        provider = "sweep",
        backend = "ollama",
        url = "http://localhost:11434",
        -- model = "maternion/sweep-next-edit-1.5B",
        model = "hf.co/sweepai/sweep-next-edit-0.5B:Q8_0",
        
      },

     context = {
    enabled = true,               -- Master switch for context collection
    lines_before = nil,           -- Lines before cursor (nil = provider default)
    lines_after = nil,            -- Lines after cursor (nil = provider default)
    max_tokens = 512,             -- Token budget for context

    selection = {
      enabled = true,             -- Include visual selection in context
      max_lines = 10,             -- Max lines from selection
    },

    lsp = {
      enabled = true,             -- Fetch LSP references for cursor symbol
      max_definitions = 2,        -- Max definition locations
      max_references = 2,         -- Max reference locations
      timeout_ms = 100,           -- LSP request timeout
    },

    same_file = {
      enabled = true,             -- Include surrounding lines from same file
      max_lines_before = 20,      -- Lines above the window
      max_lines_after = 20,       -- Lines below the window
    },

    history = {
      enabled = false,            -- Include recent edit history
      max_items = 5,              -- Number of history entries
      max_tokens = 512,           -- Token budget for history
      max_files = 2,              -- Max files in history
      global = true,              -- Share history across buffers
    },
  },

  ui = {
    progress = true,              -- Show "thinking..." indicator
    suppress_lsp_floats = true,   -- Hide LSP floats while prediction visible
  },

  prefetch = {
    enabled = false,              -- Speculative prefetch (uses extra tokens)
    strategy = "n-1",             -- Prefetch when one hunk remains
  },

  normal_mode = {
    enabled = false,              -- Trigger predictions on idle in normal mode
    debounce_ms = 200,            -- Normal-mode debounce (ms)
  },

  debounce_ms = 100,              -- Delay (ms) before sending prediction request


  keymaps = {
    insert = {
      accept = "<C-l>",           -- Accept next hunk
      accept_line = "<C-j>",      -- Accept next visible line (line-by-line)
      clear = "<C-]>",            -- Dismiss ghost text (stay in insert mode)
      reject = "<Esc>",           -- Reject and exit insert mode
    },
    normal = {
      accept = "<Tab>",           -- Accept next hunk (when normal_mode.enabled)
      accept_line = "<C-j>",      -- Accept next visible line (when normal_mode.enabled)
    },
  },
  })
  end,
}
