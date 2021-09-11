#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <json.au3>

Local $reg = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\"
Global $items = Json_Decode('[{"id":0,"name":"3D objects","reg":"{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}","height":30,"icon":-187},{"id":1,"name":"Downloads","reg":"{088e3905-0323-4b02-9826-5d99428e115f}","height":50,"icon":-175},{"id":2,"name":"Pictures","reg":"{24ad3ad4-a569-4530-98e1-ab02f9417aa8}","height":70,"icon":-108},{"id":3,"name":"Music","reg":"{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}","height":90,"icon":-103},{"id":4,"name":"Desktop","reg":"{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}","height":110,"icon":-174},{"id":5,"name":"Documents","reg":"{d3162b92-9365-467a-956b-92703aca08af}","height":130,"icon":-107},{"id":6,"name":"Videos","reg":"{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}","height":150,"icon":-178}]')
Global $Checkbox[UBound($items)]

GUICreate("This-pc libraries", 326, 246, -1, -1)

For $i In $items
	$Checkbox[$i.Item("id")] = GUICtrlCreateCheckbox($i.Item("name"), 114, $i.Item("height"), 97, 17)
	If Exists($i.Item("reg")) Then GUICtrlSetState(-1, $GUI_CHECKED)

	GUICtrlCreateIcon("C:\Windows\System32\imageres.dll", $i.Item("icon") - 1, 90, $i.Item("height"), 17, 17)
Next

$button = GUICtrlCreateButton("write to registry", 79, 190, 169, 33)

GUISetState(@SW_SHOW)

While True
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $button
			write()
	EndSwitch
WEnd

Func write()
	SoundPlay("C:\windows\media\Windows Navigation Start.wav")
	For $i In $items
		Local $CheckboxState = GUICtrlRead($Checkbox[$i.Item("id")])

		If Exists($i.Item("reg")) Then
			If $CheckboxState = 4 Then RegDelete($reg & $i.Item("reg"))
		Else
			If $CheckboxState = 1 Then RegWrite($reg & $i.Item("reg"))
		EndIf
	Next
EndFunc   ;==>write

Func Exists($item)
	RegRead($reg & $item, "")
	Return (@error <> 1)
EndFunc   ;==>Exists
