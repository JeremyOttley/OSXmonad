-- Reload on config change
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded 👍", 3)

modkey = {"cmd","alt"}

-- {'⌘', '⌥', 'ctrl'}
--hyper = {'ctrl', 'alt', 'cmd'}
hyper = {'cmd', 'ctrl', 'alt', 'shift'}

--{'⌘', '⌥', '⇧', 'ctrl'}
--hyperShift = {'ctrl', 'shift'}
hyperW = {hyper, 'W'}

--
-- [[ Functions ]] --
--

-- open key folders with ctrl + key
function directoryLaunchKeyRemap(mods, key, dir)
    local mods = mods or {}
    hs.hotkey.bind(mods, key, function()
        local shell_command = "open " .. dir
        hs.execute(shell_command)
    end)
end

hs.hotkey.bind({"ctrl"}, 'F', function()
      finder = hs.appfinder.appFromName("Finder")
      finder:selectMenuItem({"File","New Finder Window"})
      finder:activate()
      end)


hs.hotkey.bind({"alt"}, 'p', function()
    hs.itunes.pause()
      end)

hs.hotkey.bind({"alt", "shift"}, 'P', function()
    hs.itunes.play()
      end)
      
      --- quick open folders
directoryLaunchKeyRemap({"ctrl"}, "D", "~/Documents") 

hs.hotkey.bind({"ctrl"}, "R", function()
  subl = hs.appfinder.appFromName("Sublime Text")
  subl:selectMenuItem({"File", "New Window"})
  subl:activate()
  end)

-- raise console
hs.hotkey.bind({"cmd", "alt"}, "Y", hs.toggleConsole)

--- key macros
   function keyStrokes(str)
     return function()
         hs.eventtap.keyStrokes(str)
     end
   end

  hs.hotkey.bind({"alt", "cmd"}, "L", keyStrokes("http://pilot.muse.jhu.edu/collection/collection.cgi"))
  
  hs.hotkey.bind({"cmd", "alt"},"0",function()
  local proofingLayout = {
    {"Acrobat", nil, nil, hs.layout.right50, nil, nil},
   }
    hs.layout.apply(proofingLayout)

  aacrobat = hs.appfinder.appFromName("Acrobat")
  aacrobat:selectMenuItem({"View","Zoom", "Zoom to Page Level"})
  aacrobat:activate()
end)

-- TILING --
local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"

-- find a way to replace cycleLayout with "space" instead of "c"
hotkey.bind(hyper, "c", function() tiling.cycleLayout() end)
hotkey.bind(hyper, "j", function() tiling.cycle(1) end)
hotkey.bind(hyper, "k", function() tiling.cycle(-1) end)
hotkey.bind(hyper, "space", function() tiling.promote() end)
hotkey.bind(modkey, "f", function() tiling.goToLayout("fullscreen") end)

-- Push the window into the exact center of the screen
local function center(window)
  frame = window:screen():frame()
  frame.x = (frame.w / 2) - (frame.w / 4)
  frame.y = (frame.h / 2) - (frame.h / 4)
  frame.w = frame.w / 2
  frame.h = frame.h / 2
  window:setFrame(frame)
end

hotkey.bind(hyper, "t", function() tiling.toggleFloat(center) end)
-- If you want to set the layouts that are enabled
tiling.set('layouts', {
  'main-vertical', 'fullscreen'
})
--
-- [[ Windows ]] --
--

-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0

-- Remove window shadows
hs.window.setShadows(false)

hs.loadSpoon("Lunette")
spoon.Lunette:bindHotkeys()

--[[GRID]]--

local grid = hs.grid

grid.GRIDWIDTH  = 12
grid.GRIDHEIGHT = 12
grid.MARGINX    = 0
grid.MARGINY    = 0

--
-- [[ Commands ]] --
--

--hs.hotkey.bind(hyper, 'F', grid.maximizeWindow)

hs.hotkey.bind(hyper, 'N', grid.pushWindowNextScreen)
hs.hotkey.bind(hyper, 'P', grid.pushWindowPrevScreen)

--hs.hotkey.bind(hyper, 'J', grid.pushWindowDown)
--hs.hotkey.bind(hyper, 'K', grid.pushWindowUp)
hs.hotkey.bind(hyper, 'H', grid.pushWindowLeft)
hs.hotkey.bind(hyper, 'L', grid.pushWindowRight)

hs.hotkey.bind(hyper, 'U', grid.resizeWindowTaller)
hs.hotkey.bind(hyper, 'O', grid.resizeWindowWider)
hs.hotkey.bind(hyper, 'I', grid.resizeWindowThinner)
hs.hotkey.bind(hyper, 'Y', grid.resizeWindowShorter)
