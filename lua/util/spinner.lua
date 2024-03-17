
local M = {}
local tasks = {}
local notify = require("notify")
vim.notify = notify


local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
local spinner_index = 0

-- @field title string Notification title used as id
function UpdateSpinner(title)
    if tasks[title].notification ~= nil then
        M.Update(title, nil, {icon = spinner_frames[spinner_index] })
        spinner_index = ( spinner_index + 1 ) % #spinner_frames

        vim.defer_fn(function ()
            UpdateSpinner(title)
        end, 100)
    end
end

-- @field title string Notification title used as id
-- @field message string Message to show inside the notification
-- @field opts notify.opts Notification options
M.Create = function (title, message, level, opts)
    opts = opts or {}
    tasks[title] = { notification = vim.notify(message, level, {
        title = title,
        icon = opts.icon,
        hide_from_history = false
    }) }

    UpdateSpinner(title)
end

-- @field title string Notification title used as id
-- @field message string Message to show inside the notification
-- @field opts notify.opts Notification options
M.Update = function (title, message, opts)
    vim.schedule(function ()
        if tasks[title].notification == nil then
            print("task not found inside Update")
            return
        end

        opts = opts or {}

        tasks[title].notification = vim.notify(message, nil, {
            replace = tasks[title].notification,
            icon = opts.icon,
            hide_from_history = true
        })
    end)
end

-- @field title string Notification title used as id
-- @field message string Message to show inside the notification
M.Finish = function (title, message)
    if tasks[title].notification == nil then
        print("task not found inside Finish")
        return
    end

    tasks[title].notification = vim.notify(message, nil, {
        replace = tasks[title].notification,
        icon = "",
        hide_from_history = true
    })
    tasks[title].notification = nil
end


return M
