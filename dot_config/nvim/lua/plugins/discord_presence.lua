return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  -- opts = {}
  config = function()
   -- require('cord').setup {
    --  timestamp = {
    --     enabled = false,
    --     reset_on_idle = false,
    --     reset_on_change = false,
    --     shared = false,
    --   },
    -- }
  end
}
