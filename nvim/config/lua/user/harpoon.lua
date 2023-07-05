local harpoon = require("harpoon.ui")
local mark = require("harpoon.mark")

local function nav(i)
  return function()
    harpoon.nav_file(i)
  end
end

local function k(key, fn, desc)
  vim.keymap.set("n", key, fn, {
    noremap = true,
    silent = true,
    desc = desc,
  })
end

k("<leader>m,", harpoon.nav_prev, "Harpoon previous")
k("<leader>m.", harpoon.nav_next, "Harpoon next")
k("<leader>mm", mark.add_file, "Harpoon mark current file")
k("<leader>me", harpoon.toggle_quick_menu, "Harpoon toggle quick menu")
k("<A-a>", nav(1), "Harpoon go to file 1")
k("<A-r>", nav(2), "Harpoon go to file 2")
k("<A-s>", nav(3), "Harpoon go to file 3")
k("<A-t>", nav(4), "Harpoon go to file 4")
