return {
    "smoka7/hop.nvim",
    event = "InsertEnter",
    opts = {
        hint_position = 3
    },
    keys = {
        { "ff", "<Cmd>HopWord<CR>",silent = true}
    }

}
