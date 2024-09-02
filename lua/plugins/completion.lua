return {
    "deathbeam/autocomplete.nvim",
    config = function()
        require("autocomplete.signature").setup {
            border = "rounded",
            width = 80,
            height = 25,
            debounce_delay = 100
        }
        require("autocomplete.buffer").setup {
            entry_mapper = nil,
            debounce_delay = 100
        }
        require("autocomplete.cmd").setup {
            mappings = {
                accept = '<C-y>',
                reject = '<C-e>',
                complete = '<C-space>',
                next = '<C-n>',
                previous = '<C-p>',
            },
            border = "rounded",
            columns = 3,
            rows = 0.1,
            close_on_done = true,
            debounce_delay = 100,
        }
    end
}
