local M = {}

M.load = function(mod)
    if require("lazy.core.cache").find(mod)[1] then
        require(mod)
    end
end

M.setup = function()
    M.load("config.autocmds")
    M.load("config.keymaps")
    M.load("config.options")
end

return M
