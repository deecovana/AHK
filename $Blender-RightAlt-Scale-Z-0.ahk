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


;; Send to Blender Scale on Z Axis to 0
$F4::
	Send, s
	Send, z
	Send, 0
	Send, {Enter}