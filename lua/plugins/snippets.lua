---@diagnostic disable: unused-local
-- snippets configurations and addition of custom ones
local function getNamespace()
  return vim.fn.expand('%:p:h'):gsub('/', '.'):gsub('\\', '.')
end
local function getClassName()
  return vim.fn.expand('%:p:t'):gsub('.' .. vim.fn.expand '%:e', '')
end
local function loadSnippets()
  local ls = require 'luasnip'
  local s = ls.snippet
  local sn = ls.snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  local f = ls.function_node
  local c = ls.choice_node
  local d = ls.dynamic_node
  local r = ls.restore_node
  local l = require('luasnip.extras').lambda
  local rep = require('luasnip.extras').rep
  local p = require('luasnip.extras').partial
  local m = require('luasnip.extras').match
  local n = require('luasnip.extras').nonempty
  local dl = require('luasnip.extras').dynamic_lambda
  local fmt = require('luasnip.extras.fmt').fmt
  local fmta = require('luasnip.extras.fmt').fmta
  local types = require 'luasnip.util.types'
  local conds = require 'luasnip.extras.conditions'
  local conds_expand = require 'luasnip.extras.conditions.expand'

  -- init csharp file boilerplate
  ls.add_snippets('cs', {
    s(
      'init',
      fmt(
        [[
        using System;

        namespace <namespace>
        {
            public class <class>
            {
            }
        }
        ]],
        {
          namespace = f(getNamespace),
          class = f(getClassName),
        },
        { delimiters = '<>' }
      )
    ),
    -- Debugger launch settings
  })
  ls.add_snippets('json', {
    s(
      'launch',
        fmt([[
        {
          "name": "<name>",
          "type": "coreclr",
          "request": "launch",
          // Path to csproj folder to run
          "cwd": "${workspaceFolder}/<myapi>",
          "args": [
            "--urls",
            "https://localhost:6001;http://localhost:6000"
          ],
          "env": {
            "ASPNETCORE_ENVIRONMENT": "Development",
            "environment": "Development"
          },
          "program": "${workspaceFolder}/<myapi>/bin/Debug/net8.0/<myapi>.dll"
        }
        ]],
        {
          name = i(1, "Launch debug"),
          myapi = i(2, "myapi")
        },
        {
          delimiters = "<>",
          repeat_duplicates = true
        })
    ),
  })
end

return {
  'L3MON4D3/LuaSnip',
  dependencies = { 'rafamadriz/friendly-snippets' },
  build = (function()
    -- Build Step is needed for regex support in snippets
    -- This step is not supported in many windows environments
    -- Remove the below condition to re-enable on windows
    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      return
    end
    return 'make install_jsregexp'
  end)(),
  config = function()
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.filetype_extend('cs', { 'csharp' })

    vim.keymap.set({ 'i' }, '<C-K>', function()
      luasnip.expand()
    end, { silent = true })
    vim.keymap.set({ 'i', 's' }, '<C-L>', function()
      luasnip.jump(1)
    end, { silent = true })
    vim.keymap.set({ 'i', 's' }, '<C-J>', function()
      luasnip.jump(-1)
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-E>', function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true })

    loadSnippets()
  end,
}
