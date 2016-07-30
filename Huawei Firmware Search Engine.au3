#NoTrayIcon
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Resource\Icon.ico
#AutoIt3Wrapper_Res_Description=Huawei Firmware Search Engine
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2013 Kyaw Swar Thwin
#AutoIt3Wrapper_Res_Language=1033
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3>
#include <File.au3>

OnAutoItExitRegister("_Exit")
_IEErrorHandlerRegister()

Global Const $sAppName = "Huawei Firmware Search Engine"
Global Const $sAppVersion = "1.0"
Global Const $sAppPublisher = "Kyaw Swar Thwin"
Global Const $sAppPath = _TempFile("", "", "", 8)

Global Const $sTitle = $sAppName

Global $aMainSize
Global $oIE = _IECreateEmbedded()

DirCreate($sAppPath)
FileInstall("Resource\about.html", $sAppPath & "\about.html", 1)
FileInstall("Resource\huawei-logo.jpg", $sAppPath & "\huawei-logo.jpg", 1)

$frmMain = GUICreate($sTitle, 720, 480, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_MAXIMIZEBOX, $WS_SIZEBOX, $WS_THICKFRAME, $WS_MAXIMIZE, $WS_TABSTOP))
$aMainSize = WinGetClientSize($frmMain)
$fraSearch = GUICtrlCreateGroup("", 10, 10, $aMainSize[0] - 20, 60)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT)
$cboSearch = GUICtrlCreateCombo("", 25, 33, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Global|China", "China")
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
$txtSearch = GUICtrlCreateInput("", 110, 33, $aMainSize[0] - 220, 21)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT)
$btnSearch = GUICtrlCreateButton("&Search", $aMainSize[0] - 100, 30, 75, 25)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateObj($oIE, 10, 80, $aMainSize[0] - 20, $aMainSize[1] - 90)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM)
Dim $frmMain_AccelTable[1][2] = [["{Enter}", $btnSearch]]
GUISetAccelerators($frmMain_AccelTable)
GUICtrlSetState($txtSearch, $GUI_FOCUS)
GUISetState(@SW_SHOW)

_IENavigate($oIE, "about:blank")
_IENavigate($oIE, $sAppPath & "\about.html")
_IEAction($oIE, "refresh")

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnSearch
			Switch GUICtrlRead($cboSearch)
				Case "Global"
					_IENavigate($oIE, "http://consumer.huawei.com/en/support/downloads/index.htm?keyword=" & GUICtrlRead($txtSearch))
				Case "China"
					_IENavigate($oIE, "http://consumer.huawei.com/cn/support/downloads/index.htm?keyword=" & GUICtrlRead($txtSearch))
			EndSwitch
	EndSwitch
WEnd

Func _Exit()
	DirRemove($sAppPath, 1)
EndFunc   ;==>_Exit
