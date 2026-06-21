local handle_csharp = function(e)
    vim.notify("Inserting template for C# file: " .. e.file, vim.log.levels.INFO)
    local filename = vim.fn.fnamemodify(e.file, ":t:r")

    local template = "class"
    if filename:match("^I%u") then
        template = "interface"
    elseif filename:match("Controller$") then
        template = "controller"
    end

    local ok, err = pcall(vim.cmd, "Template " .. template)
    if not ok then vim.notify("Template failed to load: " .. err, vim.log.levels.ERROR) end
end

local type_to_handler = {
    ["cs"] = handle_csharp,
}

local is_buffer_empty = function(buf)
    if vim.bo[buf].buftype ~= "" then return false end
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    return #lines == 0 or (#lines == 1 and lines[1] == "")
end

local insertTemplate = function(e)
    if not is_buffer_empty(e.buf) then return end

    vim.notify("Executing insertion callback for new file: " .. e.file, vim.log.levels.INFO)

    local handler = type_to_handler[vim.bo[e.buf].filetype]
    if handler then handler(e) end
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
    desc = "Insert data from template into empty file upon creation",
    group = vim.api.nvim_create_augroup("TemplateAutoInsert", { clear = true }),
    callback = insertTemplate,
})
