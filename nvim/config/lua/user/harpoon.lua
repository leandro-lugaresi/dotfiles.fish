local harpoon = require("harpoon")

harpoon:setup()

local function nav(i)
  return function()
    harpoon:list():select(i)
  end
end

local function k(key, fn, desc)
  vim.keymap.set("n", key, fn, {
    noremap = true,
    silent = true,
    desc = desc,
  })
end

k("<leader>mp", function()
  harpoon:list():prev()
end, "Harpoon previous")

k("<leader>mn", function()
  harpoon:list():next()
end, "Harpoon next")

k("<leader>mm", function()
  harpoon:list():add()
end, "Harpoon mark current file")

k("<leader>me", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, "Harpoon toggle quick menu")

k("<A-a>", nav(1), "Harpoon go to file 1")
k("<A-r>", nav(2), "Harpoon go to file 2")
k("<A-s>", nav(3), "Harpoon go to file 3")
k("<A-t>", nav(4), "Harpoon go to file 4")
