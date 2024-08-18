-- Dap dotnet helper function
-- local spinner = require 'util.spinner'
local M = {}

-- local notifyRunTitle = 'Running dotnet build...'

-- @field title function callback function to call after build
function M.buildSolution(callback)
  local files = vim.fn.glob(vim.fn.getcwd() .. '/**/*sln', '\n', true, true)
  if next(files) ~= nil then

    local Terminal  = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
      display_name = "dotnet build",
      cmd = 'dotnet build ' .. files[1],
      direction = 'float',
      float_opts = {
        border = 'double',
      },
      on_close = vim.schedule_wrap(callback)
    })
    term:toggle()

  end
end

-- Find all csproj and prompt the user to select one
function M.selectProject()
  local csproj = vim.fn.glob(vim.fn.getcwd() .. '/**/*csproj', '\n', true, true)
  local selectedOption = require('dap.ui').pick_one(csproj, 'Select project:', function(name)
    return vim.fs.basename(name)
  end)
  return selectedOption
end
function M.selectProjectFolder()
  local csproj = vim.fn.glob(vim.fn.getcwd() .. '/**/*csproj', '\n', true, true)
  local selectedOption = require('dap.ui').pick_one(csproj, 'Select project:', function(name)
    return name
  end)
  return selectedOption
end

-- Find the dll file referent to the selected csproj
local getTargetFramework = function(fileName)
  local fileReader = io.open(fileName, 'r')

  if fileReader ~= nil then
    local csprojfileContent = fileReader:read '*all'
    fileReader:close()

    -- grap TargetFramework from csproj file
    local targetFrameworkPattern = '<TargetFramework>(.-)</TargetFramework>'
    return csprojfileContent:match(targetFrameworkPattern)
  end

  return nil
end

function M.getDebugdll()
  local selectedFilePath = M.selectProject()
  local targetFramework = getTargetFramework(selectedFilePath)

  if targetFramework == nil then
    print("targetFramework not found")
    return nil
  end

  -- build dll path based on csproj path
  local selectedfileName = vim.fs.basename(selectedFilePath)
  local csprojCWD = vim.fs.dirname(selectedFilePath)
  local dllRoot = csprojCWD .. '/bin/Debug/'
  local dllPath = dllRoot .. targetFramework .. '/' .. string.gsub(selectedfileName, '.csproj', '.dll')

  return dllPath
end

return M
