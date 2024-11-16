-- lua/plugins/venv-selector.lua
return {
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp',  -- Use the new branch with support for user-defined searches
    config = function()
        require('venv-selector').setup({
            search = true,  -- Automatically search for venvs in the current project
            search_workspace = true,  -- Search for venvs in the workspace (parent directories)
            search_paths = {  -- Additional paths to search for virtual environments
                vim.fn.expand("/home/mohmak07/.pyenv/versions"),
            },
            fd_binary_name = 'fdfind',  -- For Ubuntu/Debian if fd-find is installed as fdfind
        })
    end,
    requires = {
        'nvim-lua/plenary.nvim',
    },
}
