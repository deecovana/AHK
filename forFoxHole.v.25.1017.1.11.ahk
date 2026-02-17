;-=-\ Let's intro \-=-
;ver 25.1017.1.11
;for AHK 1.1.34.04
;by cheva (c) MIT 2012-2025

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
SoundPlay C:\Windows\Media\Windows Message Nudge.wav

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
  SoundPlay C:\Windows\Media\Windows Logoff Sound.wav
  Sleep, 1000
  ExitApp
Return

;-----Let's play!-----
; Emergency process kill
;$^F1::
;	SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
;	Process,Close,svchost.exe
;return

;; Enable mouse clicker (Shift-Click, random time 200-400 msec, return to current mouse position)
$^+C::
	Send, {^+C}
	MouseGetPos, ClickX, ClickY
	SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
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
		SoundPlay C:\Windows\Media\Windows Navigation Start.wav
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
	SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
return

$^+LButton::
	Send, {LButton Down}
	SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
return

$^+RButton::
	Send, {RButton Down}
	SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
return

; Fixed Camera to mouse
$^+MButton::
	Send, {LAlt Down}
	SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
return

; Fixed Camera and Run
$!Space::
	Send, {LAlt Up}
	Sleep, 200
	Send, {LAlt Down}
	Sleep, 200
	Send, {W Down}
	SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
return

; Always move
$!W::
  SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
  Send, {W Down}
Return

; Zoom In 100% and Out
$^CapsLock::
	Send, {LControl Down}
	global Zoom = not(Zoom)
	SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
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

; Release all fixed keys
$^BackSpace::
	Send, {BackSpace}
	SoundPlay C:\Windows\Media\Windows Message Nudge.wav
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