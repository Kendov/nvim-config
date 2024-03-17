-- Dap dotnet helper function
local spinner = require("util.spinner")
local M = {}


local notifyRunTitle = "Running dotnet build..."

-- @field title function callback function to call after build
function M.buildSolution (callback)

    local files = vim.fn.glob(vim.fn.getcwd() .. '/**/*sln', '\n', true, true)
    if next(files) ~= nil then
        spinner.Create(notifyRunTitle, "Building Solution", nil)

        require('plenary.job'):new({
            command = 'dotnet',
            args = { 'build', files[1] },
            on_stdout = function (_, data)
                spinner.Update(notifyRunTitle, data, nil)
            end,
            on_exit = function(_, _)
                spinner.Finish(notifyRunTitle, "Success!")
                vim.schedule(function ()
                    callback()
                end)
            end,
        }):start()
    end
end

-- Find all csproj and prompt the user to select one
function M.selectProject()
    local csproj = vim.fn.glob(vim.fn.getcwd() .. '/**/*csproj', '\n', true, true)
    local selectedOption = require("dap.ui").pick_one(csproj, "Select project:", function(name)
        return name:match("[^/]*.csproj$")
    end)
    return selectedOption
end

-- Find the dll file referent to the selected csproj
local getTargetFramework = function(fileName)
    local fileReader = io.open(fileName, "r")

    if fileReader ~= nil then
        local csprojfileContent = fileReader:read("*all")
        fileReader:close()

        -- grap TargetFramework from csproj file
        local targetFrameworkPattern = "<TargetFramework>(.-)</TargetFramework>"
        return csprojfileContent:match(targetFrameworkPattern)
    end

    return nil
end

function M.getDebugdll()
    local selectedFilePath = M.selectProject()
    local targetFramework = getTargetFramework(selectedFilePath)

    if targetFramework == nil then
        return nil
    end

    -- build dll path based on csproj path
    local selectedfileName = selectedFilePath:match("[^/]*.csproj$")
    local dllRoot = string.gsub(selectedFilePath, selectedfileName, "") .. "bin/debug/"
    local dllPath = dllRoot .. targetFramework .. "/" .. string.gsub(selectedfileName, ".csproj", ".dll")

    return dllPath

end


return M
