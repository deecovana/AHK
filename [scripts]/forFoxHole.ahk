;-=-\ Let's intro \-=-
;ver 23.1129.1
;for AHK 1.1.34.04
;by cheva (c) MIT 2012-2024

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
SoundPlay %A_WinDir%\Media\Windows Message Nudge.wav

;reload
$^+R::
  Reload
Return

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
  SoundPlay %A_WinDir%\Media\Windows Logoff Sound.wav
  Sleep, 1000
  ExitApp
Return

;Steam {PrintScreen}
$PrintScreen::
  Send, {PrintScreen}
  Send, {F12}
return

;-----Let's play!-----
; Emergency process kill
;$^F1::
;	SoundPlay %A_WinDir%\Media\Windows Pop-up Blocked.wav
;	Process,Close,svchost.exe
;return

;; Enable mouse clicker (Shift-Click, random time 200-400 msec, return to current mouse position)
$^+C::
	Send, {^+C}
	MouseGetPos, ClickX, ClickY
	SoundPlay %A_WinDir%\Media\Windows Pop-up Blocked.wav
	Sleep, 500
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
		SoundPlay %A_WinDir%\Media\Windows Navigation Start.wav
		Send, {LShift Up}
		MouseMove, %OrigX%, %OrigY%
		Sleep, % ran(SMin, SMax)
		MouseSpeed = % ran(MMin, MMax)
		SetDefaultMouseSpeed, MouseSpeed
	}
return

;; Hold keys Down

$^+G::
	Send, {G Down}
	SoundPlay %A_WinDir%\Media\Windows Pop-up Blocked.wav
return

$^+LButton::
	Send, {LButton Down}
	SoundPlay %A_WinDir%\Media\Windows Pop-up Blocked.wav
return

$^+RButton::
	Send, {RButton Down}
	SoundPlay %A_WinDir%\Media\Windows Pop-up Blocked.wav
return

; View 
$MButton::
	Send, {LAlt Down}
	SoundPlay %A_WinDir%\Media\Windows Pop-up Blocked.wav
return

; View and Run
$!Space::
	Send, {LAlt Up}
	Sleep, 200
	Send, {LAlt Down}
	Sleep, 200
	Send, {W Down}
	SoundPlay %A_WinDir%\Media\Windows Pop-up Blocked.wav
return

;move
$!W::
  Send, {W Down}
Return

; Zoom 100%
$CapsLock::
	Send, {LControl Down}
	global Zoom = not(Zoom)
	SoundPlay %A_WinDir%\Media\Windows Pop-up Blocked.wav
	loop 25 {
		if Zoom {
			Send, {WheelUp}
		}
		else {
			Send, {WheelDown}
		}
		Sleep, 40
	}
	Send, {LControl Up}
return

; Release all keys
$BackSpace::
	Send, {BackSpace}
	SoundPlay %A_WinDir%\Media\Windows Message Nudge.wav
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