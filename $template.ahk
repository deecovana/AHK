;; ver 26.02
;; for AHK 1.1.34.04
;; (C) CC3 by cheva MIT 2012-2026

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

;enable mouse clicker (random time 1-10 sec, current mouse position)
$^+C::
	Send, {^!C}
	MouseGetPos, ClickX, ClickY
	SoundPlay C:\Windows\Media\Windows Pop-up Blocked.wav
	Sleep, 1000
	Loop
	{
		if (BreakLoop == 1)
		{
			BreakLoop = 0
			break
		}
		MouseGetPos, OrigX, OrigY
		MouseClick, left, %ClickX%, %ClickY%
		SoundPlay C:\Windows\Media\Windows Navigation Start.wav
		MouseMove, %OrigX%, %OrigY%
		Sleep, % ran(1000, 9000)
		global MouseSpeed = % ran(1, 20)
		SetDefaultMouseSpeed, MouseSpeed
	}
return
