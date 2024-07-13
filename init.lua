----------------------------------------------------------------------------------------------------

-- author: zuorn
-- mail: zuorn@qq.com
-- github: https://github.com/zuorn/hammerspoon_config

----------------------------------------------------------------------------------------------------

--          ╭─────────────────────────────────────────────────────────╮
--          │                      提示信息配置                       │
--          ╰─────────────────────────────────────────────────────────╯

-- hs.hotkey.alertDuration = 0
-- hs.hints.showTitleThresh = 0
-- hs.window.animationDuration = 0

hs.alert.defaultStyle = {
	strokeWidth = 0,
	strokeColor = { white = 0, alpha = 1 },
	fillColor = { white = 0, alpha = 0.5 },
	textColor = { white = 1, alpha = 1 },
	textFont = ".AppleSystemUIFont",
	textSize = 18,
	radius = 18,
	atScreenEdge = 0,
	fadeInDuration = 0.15,
	fadeOutDuration = 0.15,
	padding = 16,
}

--          ╭─────────────────────────────────────────────────────────╮
--          │                        调节音量                         │
--          ╰─────────────────────────────────────────────────────────╯

local hyperKey = { "cmd", "alt", "ctrl", "shift" }
local mediaKey = { "cmd", "alt" }

local function changeVolume(diff)
	return function()
		local current = hs.audiodevice.defaultOutputDevice():volume()
		local new = math.min(100, math.max(0, math.floor(current + diff)))
		if new > 0 then
			hs.audiodevice.defaultOutputDevice():setMuted(false)
		end
		hs.alert.closeAll(0.0)
		hs.alert.show("音量：" .. new .. "%", {}, 0.5)
		hs.audiodevice.defaultOutputDevice():setVolume(new)
	end
end

hs.hotkey.bind(mediaKey, "J", changeVolume(-2))
hs.hotkey.bind(mediaKey, "K", changeVolume(2))

--          ╭─────────────────────────────────────────────────────────╮
--          │                      重新加载配置                       │
--          ╰─────────────────────────────────────────────────────────╯

local function reloadConfig()
	hs.reload()
end
hs.hotkey.bind(hyperKey, "R", "reload config", reloadConfig)
hs.alert.show("配置已重载！")

--          ╭─────────────────────────────────────────────────────────╮
--          │                        窗口管理                         │
--          ╰─────────────────────────────────────────────────────────╯

hs.loadSpoon("ModalMgr")
hs.loadSpoon("WinWin")

if spoon.WinWin then
	spoon.ModalMgr:new("resizeM")
	local cmodal = spoon.ModalMgr.modal_list["resizeM"]
	cmodal:bind("", "escape", "退出", function()
		spoon.ModalMgr:deactivate({ "resizeM" })
	end)
	cmodal:bind("", "Q", "退出", function()
		spoon.ModalMgr:deactivate({ "resizeM" })
	end)
	cmodal:bind("", "tab", "键位提示", function()
		spoon.ModalMgr:toggleCheatsheet()
	end)

	cmodal:bind(
		"",
		"A",
		"向左移动",
		function()
			spoon.WinWin:stepMove("left")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("left")
		end
	)
	cmodal:bind(
		"",
		"D",
		"向右移动",
		function()
			spoon.WinWin:stepMove("right")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("right")
		end
	)
	cmodal:bind(
		"",
		"W",
		"向上移动",
		function()
			spoon.WinWin:stepMove("up")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("up")
		end
	)
	cmodal:bind(
		"",
		"S",
		"向下移动",
		function()
			spoon.WinWin:stepMove("down")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("down")
		end
	)

	cmodal:bind("", "H", "左半屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfleft")
	end)
	cmodal:bind("", "L", "右半屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfright")
	end)
	cmodal:bind("", "K", "上半屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfup")
	end)
	cmodal:bind("", "J", "下半屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfdown")
	end)

	cmodal:bind("", "Y", "屏幕左上角", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerNW")
	end)
	cmodal:bind("", "O", "屏幕右上角", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerNE")
	end)
	cmodal:bind("", "U", "屏幕左下角", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerSW")
	end)
	cmodal:bind("", "I", "屏幕右下角", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerSE")
	end)

	cmodal:bind("", "F", "全屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("fullscreen")
	end)
	cmodal:bind("", "C", "居中", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("center")
	end)
	cmodal:bind("", "G", "左三分之二屏居中分屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("centermost")
	end)
	cmodal:bind("", "Z", "展示显示", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("show")
	end)
	cmodal:bind("", "V", "编辑显示", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("shows")
	end)

	cmodal:bind("", "X", "二分之一居中分屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("center-2")
	end)

	cmodal:bind(
		"",
		"=",
		"窗口放大",
		function()
			spoon.WinWin:moveAndResize("expand")
		end,
		nil,
		function()
			spoon.WinWin:moveAndResize("expand")
		end
	)
	cmodal:bind(
		"",
		"-",
		"窗口缩小",
		function()
			spoon.WinWin:moveAndResize("shrink")
		end,
		nil,
		function()
			spoon.WinWin:moveAndResize("shrink")
		end
	)

	cmodal:bind(
		"ctrl",
		"H",
		"向左收缩窗口",
		function()
			spoon.WinWin:stepResize("left")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("left")
		end
	)
	cmodal:bind(
		"ctrl",
		"L",
		"向右扩展窗口",
		function()
			spoon.WinWin:stepResize("right")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("right")
		end
	)
	cmodal:bind(
		"ctrl",
		"K",
		"向上收缩窗口",
		function()
			spoon.WinWin:stepResize("up")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("up")
		end
	)
	cmodal:bind(
		"ctrl",
		"J",
		"向下扩镇窗口",
		function()
			spoon.WinWin:stepResize("down")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("down")
		end
	)

	cmodal:bind("", "left", "窗口移至左边屏幕", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("left")
	end)
	cmodal:bind("", "right", "窗口移至右边屏幕", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("right")
	end)
	cmodal:bind("", "up", "窗口移至上边屏幕", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("up")
	end)
	cmodal:bind("", "down", "窗口移至下边屏幕", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("down")
	end)
	cmodal:bind("", "space", "窗口移至下一个屏幕", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("next")
	end)
	cmodal:bind("", "B", "撤销最后一个窗口操作", function()
		spoon.WinWin:undo()
	end)
	cmodal:bind("", "R", "重做最后一个窗口操作", function()
		spoon.WinWin:redo()
	end)

	cmodal:bind("", "[", "左三分之二屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("mostleft")
	end)
	cmodal:bind("", "]", "右三分之二屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("mostright")
	end)
	cmodal:bind("", ",", "左三分之一屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("lesshalfleft")
	end)
	cmodal:bind("", ".", "中分之一屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("onethird")
	end)
	cmodal:bind("", "/", "右三分之一屏", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("lesshalfright")
	end)

	cmodal:bind("", "t", "将光标移至所在窗口中心位置", function()
		spoon.WinWin:centerCursor()
	end)
end

-- 定义窗口管理模式快捷键
spoon.ModalMgr.supervisor:bind(hyperKey, "M", "进入窗口管理模式", function()
	spoon.ModalMgr:deactivateAll()
	-- 显示状态指示器，方便查看所处模式
	spoon.ModalMgr:activate({ "resizeM" }, "#0f0")
end)

--          ╭─────────────────────────────────────────────────────────╮
--          │                   将鼠标移到其他屏幕                    │
--          ╰─────────────────────────────────────────────────────────╯

local function focus_other_screen() -- focuses the other screen
	local screen = hs.mouse.getCurrentScreen()
	local nextScreen = screen:next()
	local rect = nextScreen:fullFrame()
	local center = hs.geometry.rectMidPoint(rect)
	hs.mouse.setAbsolutePosition(center)
end

function get_window_under_mouse() -- from https://gist.github.com/kizzx2/e542fa74b80b7563045a
	local my_pos = hs.geometry.new(hs.mouse.getAbsolutePosition())
	local my_screen = hs.mouse.getCurrentScreen()
	return hs.fnutils.find(hs.window.orderedWindows(), function(w)
		return my_screen == w:screen() and my_pos:inside(w:frame())
	end)
end

function activate_other_screen()
	focus_other_screen()
	local win = get_window_under_mouse()
	-- now activate that window
	win:focus()
end

-- 显示屏之间切换焦点
hs.hotkey.bind({ "cmd" }, "escape", function() -- does the keybinding
	activate_other_screen()
end)

--          ╭─────────────────────────────────────────────────────────╮
--          │                      番茄钟倒计时                       │
--          ╰─────────────────────────────────────────────────────────╯

hs.loadSpoon("CountDown")
if spoon.CountDown then
	spoon.ModalMgr:new("countdownM")
	local cmodal = spoon.ModalMgr.modal_list["countdownM"]
	cmodal:bind("", "escape", "退出面板", function()
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	cmodal:bind("", "Q", "退出面板", function()
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	--cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
	cmodal:bind("", "0", "1 分钟", function()
		spoon.CountDown:startFor(1)
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	for i = 1, 9 do
		cmodal:bind("", tostring(i), string.format("%s 分钟", 10 * i), function()
			spoon.CountDown:startFor(10 * i)
			spoon.ModalMgr:deactivate({ "countdownM" })
		end)
	end
	cmodal:bind("", "return", "25 分钟 ", function()
		spoon.CountDown:startFor(25)
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	cmodal:bind("", "space", "暂停和恢复倒计时", function()
		spoon.CountDown:pauseOrResume()
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)

	-- 定义打开倒计时面板快捷键
	spoon.ModalMgr.supervisor:bind(hyperKey, "i", "进入倒计时面板", function()
		spoon.ModalMgr:deactivateAll()
		-- 显示倒计时面板
		spoon.ModalMgr:activate({ "countdownM" }, "#FF6347", true)
	end)
end

--          ╭─────────────────────────────────────────────────────────╮
--          │                     初始化 modalMgr                     │
--          ╰─────────────────────────────────────────────────────────╯

spoon.ModalMgr.supervisor:enter()
