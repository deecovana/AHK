;; ver 26.03
;; for AHK 1.1.34.04
;; (CC3 2026) cheva 2012-2026

#SingleInstance Force

;-=-\ Set globals \-=-
global SMin = 200
global SMax = 600
global MMin = 2
global MMax = 6
global Zoom = false
MouseSpeed = % ran(MMin, MMax)
SetDefaultMouseSpeed, MouseSpeed

;-=-\ Functions \-=-
ran(min, max)
{
	random, ran, min, max
	return ran                                                                                                                                                      
}

;-=-\ Init \-=-
SoundPlay, %A_WinDir%\Media\Windows Message Nudge.wav

;reload
$^+R::Reload
;suspend/resume
$^+S::
;pause/resume
$^+P::
;use both to sleep/pause
  ;thanks to Rohwedder
  ;https://www.autohotkey.com/boards/viewtopic.php?t=50594
  Suspend ;Suspend Hotkeys
  Pause,,1 ;Pause Script
  If !(Reload := !Reload)
    Reload ;Reload Script
Return

;exit
$^+W::
  Send, {^+W}
  SoundPlay, %A_WinDir%\Media\Windows Logoff Sound.wav
  Sleep, 1000
  ExitApp
Return
  
; Emergency process kill
;$^F1::
;	SoundPlay, %A_WinDir%\Media\Windows Pop-up Blocked.wav
;	Process,Close,svchost.exe
;return
     
;-----Let's play!-----
;;=======================================================================

; Initialize a global variables to track the toggle state 
ExampleFlag := false

; Enable mouse clicker (as Shift-Click, random time 200-400 msec, return to current mouse position)
; Press Shift + Control + C over the position to click
; Than You have 1 second to move mouse to other position, as Tabs on Train wagons to switch it when not moving
$^+C::
	Send, {^+C}
	MouseGetPos, ClickX, ClickY
	SoundPlay, %A_WinDir%\Media\Windows Foreground.wav
	Sleep, 1000
	Loop
	{
		if (BreakLoop == 1)
		{
			BreakLoop = 0
			break
		}
		MouseGetPos, OrigX, OrigY
		Send, {LShift Down}
		MouseClick, left, %ClickX%, %ClickY%
		SoundPlay, %A_WinDir%\Media\Speech Off.wav
		Send, {LShift Up}
		MouseMove, %OrigX%, %OrigY%
		Sleep, % ran(SMin, SMax)
		MouseSpeed = % ran(MMin, MMax)
		SetDefaultMouseSpeed, MouseSpeed
	}
return

; Release all physical fixed keys and Reload script
; Use Alt/Shift + Backspace
$+BackSpace::
$!BackSpace::
	SoundPlay, %A_WinDir%\Media\Speech On.wav
	Send, {LShift Up}
	Send, {LAlt Up}
	Send, {LControl Up}
	Send, {LButton Up}
	Send, {RButton Up}
	Send, {MButton Up}
	Loop, 0xFF {
		IF GetKeyState(Key:=Format("VK{:X}",A_Index))
			SendInput, {%Key% up}
	}
	Reload
return

; Use Fixed Mouse Buttons to harvest, fixed camera etc.
; Hold Left Button to harvest or build
; Use Control + Shift + Left Click
$^+LButton::
	SoundPlay, %A_WinDir%\Media\Speech On.wav
	Send, {LButton Down}
return
; Middle Button
; Use Control + Shift + Middle Click
$^+MButton::
	SoundPlay, %A_WinDir%\Media\Speech On.wav
	Send, {MButton Down}
return
; And Right Button
; Use Control + Shift + Right Click
$^+RButton::
	SoundPlay, %A_WinDir%\Media\Speech On.wav
	Send, {RButton Down}
return

; Use fixed camera
; Need to set up keys in FoxHole: Alt to fixed camera
; Use Alt + Space for run forward to fixed camera
$!Space::
	SoundPlay, %A_WinDir%\Media\Speech On.wav
	Send, {LAlt Up}
	Sleep, 50
	Send, {LAlt Down}
	Sleep, 50
	Send, {W Down}
return

; Use Ctrl+Space for Sambra gunner fixed camera
; Need to set up keys in FoxHole: Alt to fixed camera
$^Space::
	SoundPlay, %A_WinDir%\Media\Speech On.wav
	Send, {RButton Down}
	Send, {LAlt Down}
return

; Use Up and Down keys to change Sambra or Flack Attitude to +- 1 meter
; Need to set up attitude keys to WheelUp/WheelDown
$~Up::
SoundPlay, %A_WinDir%\Media\Speech On.wav
  Loop, 5
  {
    Send, {WheelUp}
  }
return
; And down
$~Down:: 
SoundPlay, %A_WinDir%\Media\Speech On.wav
  Loop, 5
  {
    Send, {WheelDown}
  }
return

; Use Alt + W/S - Always move
; Forward
$!W::
  SoundPlay, %A_WinDir%\Media\Speech On.wav
  Send, {W Down}
return
; And backward
$!S::
  SoundPlay, %A_WinDir%\Media\Speech On.wav
  Send, {S Down}
return

; Use Control + CapsLock: Zoom In/Out 100%
; Need to set up keys in FoxHole: Zoom on Wheel Up/Down
$^CapsLock::
	SoundPlay, %A_WinDir%\Media\Speech On.wav
	Send, {LControl Down}
	global Zoom = not(Zoom)
	loop 50 {
		if Zoom {
			Send, {WheelUp}
		}
		else {
			Send, {WheelDown}
		}
		Sleep, 20
	}
	Send, {LControl Up}
return

