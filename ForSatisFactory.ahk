;; ver 26.04.02
;; for AHK 1.1.34.04
;; (CC4 2026) cheva 2012-2026

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
SoundPlay, %A_WinDir%\Media\Windows Foreground.wav

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
  SoundPlay, %A_WinDir%\Media\Windows Notify System Generic.wav
  Sleep, 1000
  ExitApp
Return

; Release all physical fixed keys and Reload script
; Use Alt/Shift + Backspace
$+BackSpace::
$!BackSpace::
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
  
; Emergency process kill
;$^F1::
;	SoundPlay, %A_WinDir%\Media\Windows Pop-up Blocked.wav
;	Process,Close,svchost.exe
;return
     
;-----Let's play!-----
;;=======================================================================

; Initialize a global variables to track the toggle state 
BreakLoop := 0

; Enable mouse clicker (as Shift-Click, random time 200-400 msec, return to current mouse position)
; Press Shift + Control + C over the position to click
; Than You have 1 second to move mouse to other position, as Tabs on Train wagons to switch it when not moving
$^+C::
	Send, {^+C}
	MouseGetPos, ClickX, ClickY
	SoundPlay, %A_WinDir%\Media\Windows Background.wav
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
		SoundPlay, %A_WinDir%\Media\Windows Default.wav
		Send, {LShift Up}
		MouseMove, %OrigX%, %OrigY%
		Sleep, % ran(SMin, SMax)
		MouseSpeed = % ran(MMin, MMax)
		SetDefaultMouseSpeed, MouseSpeed
	}
return

; Use Fixed Mouse Buttons to harvest, fixed camera etc.
; Hold Left Button to harvest or build
; Use Control + Shift + Left Click
$^+LButton::
	SoundPlay, %A_WinDir%\Media\Windows Background.wav
	Send, {LButton Down}
return
; Middle Button
; Use Control + Shift + Middle Click
$^+MButton::
	SoundPlay, %A_WinDir%\Media\Windows Background.wav
	Send, {MButton Down}
return
; And Right Button
; Use Control + Shift + Right Click
$^+RButton::
	SoundPlay, %A_WinDir%\Media\Windows Background.wav
	Send, {RButton Down}
return
; Repeat `e` loop
; Press Shift + Control + E
$^+E::
	Loop
	{
		if (BreakLoop == 1)
		{
			BreakLoop = 0
			break
		}
		Send, {e Down}
		SoundPlay, %A_WinDir%\Media\Windows Background.wav
		Sleep, % SMin
		Send, {e Up}
	}
return
; Break Loops
$^C::
	SoundPlay, %A_WinDir%\Media\Windows Foreground.wav
	BreakLoop = 1
return
