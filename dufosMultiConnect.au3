#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Constants.au3>
#include <File.au3>
#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <ColorConstants.au3>
#Include <StaticConstants.au3>
#Include <TabConstants.au3>
#Include <WindowsConstants.au3>
#include <GuiTab.au3>

Global $couleurDuWaitingScreen = 0xFAF3EB

Global $desktopWidth = @DesktopWidth / 1920 ; desktopWidth / 1920 = ratio basé sur du 1920
Global $desktopHeight = @DesktopHeight / 1080 ; desktopHeight / 1080 = ratio basé sur du 1080

Global $mousespeed = 3
Global $arrRead[20]
Global $arrBoth[0]
Global $arrNdc[0]
Global $arrPw[0]
Global $arrServ[0]
Global $arrChar[0]
Global $count = 0
Global $nbrComptes = ""
Global $optionsOpti = 0

Global $pathClient = "C:\Users\User\AppData\Local\Ankama\zaap\retro\Dofus.exe"
Global $path86 = "C:\Program Files (x86)\Dofus\Dofus.exe"
Global $path64 = "C:\Program Files (x64)\Dofus\Dofus.exe"
Global $path32 = "C:\Program Files (x32)\Dofus\Dofus.exe"
Global $ProgFiles = "C:\Program Files\Dofus\Dofus.exe"
Global $pathProg = "C:\Programmes\Dofus\Dofus.exe"
Global $path = "C:\";
Global $cheminCourant = @WorkingDir

Global $retournLigne = @CR
Global $emptyString = ""
Global $iPID[0]
Global $label2
Global $choixNombreComptes
Global $buttonNouveauCompte
Global $buttonLancerScript
Global $buttonSupprimerComptes

Global $inputUserNdc
Global $inputUserPw
Global $inputUserServ
Global $inputUserChar

Global $inputAddNdc
Global $inputAddPw
Global $inputAddServ
Global $inputAddChar

Global $inputModifNdc
Global $inputModifPw
Global $inputModifServ
Global $inputModifChar

Global $createdAccountLabel
Global $createServerLabel
Global $createdCharacterLabel

Global $checkOptions

Global $Pic[5]
Global $arrayNoms[5]


; ----------------------------------------------------------------------- Macro Stop -----------------------------------------------------------------------

HotKeySet("{UP}","Terminate") ; Appuyer sur la flèche du haut pour stop le programme
Func Terminate()
    Exit 0
EndFunc



savePart1()
newGUI()

; ----------------------------------------------------------------------- Début Nouvelle GUI -----------------------------------------------------------------------

Func newGUI()

$hGUI= GUICreate('Dufos MultiConnect', 705, 369)
GUISetBkColor(0xFFFFFF)
GUICtrlCreatePic('img_bg.bmp', 0, 0, 705, 369)
GUICtrlSetState(-1, $GUI_DISABLE)

$arrayNoms[0] = 'Résumé'
$arrayNoms[1] = 'Ajout Compte'
$arrayNoms[2] = 'Modifier Compte'
$arrayNoms[3] = 'Options'
$arrayNoms[4] = 'About Us'

For $i = 0 To 4
	$Pic[$i] = GUICtrlCreatePic(@ScriptDir & '\img_black.bmp', 10, 24 + 50 * $i, 162, 49)
	GUICtrlCreateLabel($arrayNoms[$i], 21, 40 + 50 * $i, 140, 18, $SS_CENTER)
	GUICtrlSetFont(-1, 11, 400, 0, 'Tahoma')
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetcolor(-1, 0xFFFFFF)
Next

$stringNbAccount = ""

If $nbrComptes <> 0 Then
   $stringNbAccount = "Nombre de comptes : " & $nbrComptes
EndIf

$stringAccount = ""
$check1 = true

For $i = 0 To UBound($arrNdc) - 1
   If($check1) Then
	  $stringAccount &= "Comptes" & @CRLF & @CRLF
	  $check1 = false
   EndIf
   $stringAccount &=  $arrNdc[$i] & @CRLF
Next

$stringServer = ""
$check2 = true

If UBound($arrNdc) = 0 Then
   $stringServer = "Veuillez tout d'abord ajouter des données dans l'onglet << Ajout Compte >>"
EndIF

For $i = 0 To UBound($arrServ) - 1
   If($check2) Then
	  $stringServer &= "N°Serveur" & @CRLF & @CRLF
	  $check2 = false
   EndIf
   $stringServer &= $arrServ[$i] & @CRLF
Next

$stringCharacter = ""
$check3 = true

For $i = 0 To UBound($arrChar) - 1
   If($check3) Then
	  $stringCharacter &= "N°Personnage" & @CRLF & @CRLF
	  $check3 = false
   EndIf
   $stringCharacter &=  $arrChar[$i] & @CRLF
Next

$Tab = GUICtrlCreateTab(172 + 4, 10 + 4, 523 - 8, 349 - 8)
GUICtrlCreateTabItem('Résumé') ; -------------------------------------- Tout ce qui constitue Ajout Résumé --------------------------------------

;images
GUICtrlCreatePic("IMG/Tiwabbitkiafin.jpg", 178, 13, 50, 50)
GUICtrlCreatePic("IMG/Meulou.jpg", 595, 155, 96, 119)

$label3 = GUICtrlCreateLabel("/!\ Lorsque vous lancez le script, il ne faut plus toucher à rien jusqu'à ce que tout soit connecté, ni souris ni clavier ! (Flèche du haut pour arreter le programme à tout moment)", 180, 300, 480, 60)
GUICtrlSetFont($label3, 11)
GUICtrlSetColor($label3, $COLOR_RED)
$label2 = GUICtrlCreateLabel("Nombre de comptes : ", 180, 274, 135, 20)
GUICtrlSetFont($label2, 11)
$choixNombreComptes = GUICtrlCreateCombo("1", 322, 271, 40, 10)
GUICtrlSetFont($choixNombreComptes, 11)
GUICtrlSetData($choixNombreComptes, "2", "2")
GUICtrlSetData($choixNombreComptes, "3", "3")
GUICtrlSetData($choixNombreComptes, "4", "4")
GUICtrlSetData($choixNombreComptes, "5", "5")
GUICtrlSetData($choixNombreComptes, "6", "6")
GUICtrlSetData($choixNombreComptes, "7", "7")
GUICtrlSetData($choixNombreComptes, "8", "8")
if $nbrComptes<> "" Then
	GUICtrlSetData($choixNombreComptes, $nbrComptes, $nbrComptes)
EndIf
GUICtrlSetFont($choixNombreComptes, 11)
$createdAccountLabel = GUICtrlCreateLabel("Comptes", 240, 60, 130, 200)
GUICtrlSetFont($createdAccountLabel, 11)
$modifiedAccountLabel = GUICtrlSetData (-1, $stringAccount)
$createServerLabel = GUICtrlCreateLabel("N° Serveur", 397, 60, 130, 200)
GUICtrlSetFont($createServerLabel, 11)
$modifiedServerLabel = GUICtrlSetData (-1, $stringServer)
$createdCharacterLabel = GUICtrlCreateLabel("N° Personnage", 554, 60, 130, 200)
GUICtrlSetFont($createdCharacterLabel, 11)
$modifiedCharacterLabel = GUICtrlSetData (-1, $stringCharacter)
$buttonLancerScript = GUICtrlCreateButton('GO !', 380, 269, 100, 28)
$checkOptions = GUICtrlCreateCheckbox("Options optimisées?", 490, 274, 185, 20)
GUICtrlSetFont($checkOptions, 11)



GUICtrlCreateTabItem('Ajout Compte') ; -------------------------------------- Tout ce qui constitue Ajout Compte --------------------------------------

;images
GUICtrlCreatePic("IMG/Dofus_Logo.jpg", 200, 10, 121, 92)
GUICtrlCreatePic("IMG/Atouin_Sabre.jpg", 400, 10, 98, 75)
GUICtrlCreatePic("IMG/Atouin_Knife.jpg", 500, 10, 70, 74)
GUICtrlCreatePic("IMG/Dragoune_Rose.jpg", 300, 265, 63, 86)

 $buttonNouveauCompte = GUICtrlCreateButton('Ajouter un Compte', 398, 300, 100, 30)
 $labelAddCompte = GUICtrlCreateLabel("Nom de compte :", 200, 100, 120, 20)
 GUICtrlSetFont($labelAddCompte, 11)
 $inputAddNdc = GUICtrlCreateInput('', 321, 88, 364, 40)
 GUICtrlSetFont($inputAddNdc, 11)
 _GUICtrlEdit_SetCueBanner($inputAddNdc, "Remplacer par le nom de compte") ; si empty

$labelAddPassword = GUICtrlCreateLabel("Mot de passe :", 200, 150, 120, 20)
GUICtrlSetFont($labelAddPassword, 11)
 $inputAddPw = GUICtrlCreateInput('', 321, 138, 364, 40)
 GUICtrlSetFont($inputAddPw, 11)
 _GUICtrlEdit_SetCueBanner($inputAddPw, "Remplacer par le mot de passe") ; si empty
 _GUICtrlEdit_SetPasswordChar($inputAddPw, "*")

 $labelAddServ = GUICtrlCreateLabel("Numéro du serveur à utiliser (1, 2 ou 3) :", 200, 200, 260, 20)
 GUICtrlSetFont($labelAddServ, 11)
 $inputAddServ = GUICtrlCreateInput('', 465, 190, 220, 40)
 GUICtrlSetFont($inputAddServ, 11)
 _GUICtrlEdit_SetCueBanner($inputAddServ, "Remplacer par le n° du serveur") ; si empty

  $labelAddChar = GUICtrlCreateLabel("Numéro du personnage à connecter (1, 2, 3, 4 ou 5) :	", 200, 250, 340, 20)
  GUICtrlSetFont($labelAddChar, 11)
 $inputAddChar = GUICtrlCreateInput('', 550, 240, 135, 40)
 GUICtrlSetFont($inputAddChar, 11)
 _GUICtrlEdit_SetCueBanner($inputAddChar, "Remplacer par le n° du personnage à jouer") ; si empty

GUICtrlCreateTabItem('Modifier mes Comptes') ; -------------------------------------- Tout ce qui constitue Modifier Comptes --------------------------------------

;images
GUICtrlCreatePic("IMG/Tofu.jpg", 420, 56, 75, 88)

 Global $buttonModifCompte = GUICtrlCreateButton('Mettre à jour le Compte', 338, 300, 200, 30)
 Global	$buttonUpdate = GUICtrlCreateButton('Charger', 200, 90, 200, 30)
 Global $labelModifCompte = GUICtrlCreateLabel("Choisir le Compte à modifier :", 200, 30, 200, 30)
 GUICtrlSetFont($labelModifCompte, 11)
 Global $labelModifCompte2 = GUICtrlCreateLabel("Puis cliquer sur 'Charger' ", 209, 60, 200, 30)
 GUICtrlSetFont($labelModifCompte2, 11)


 Global $choixCompteModif = GUICtrlCreateCombo("", 401, 30, 284, 90)
 GUICtrlSetFont($choixCompteModif, 11)

 		For $el In $arrNdc
			GUICtrlSetData($choixCompteModif, String($el), String($el))
		Next


 $labelModifPassword = GUICtrlCreateLabel("Nouveau Mot de Passe :", 200, 150, 160, 20)
 GUICtrlSetFont($labelModifPassword, 11)
 $inputModifPw = GUICtrlCreateInput('', 361, 138, 324, 40)
 GUICtrlSetFont($inputModifPw, 11)
 _GUICtrlEdit_SetCueBanner($inputModifPw, "Remplacer par le mot de passe") ; si empty
 _GUICtrlEdit_SetPasswordChar($inputModifPw, "*")

 $labelModifServ = GUICtrlCreateLabel("Nouveau numéro de serveur (1, 2 ou 3) :", 200, 200, 260, 20)
 GUICtrlSetFont($labelModifServ, 11)
 $inputModifServ = GUICtrlCreateInput('', 465, 190, 220, 40)
 GUICtrlSetFont($inputModifServ, 11)
 _GUICtrlEdit_SetCueBanner($inputModifServ, "Remplacer par le n° du serveur") ; si empty

  $labelModifChar = GUICtrlCreateLabel("Nouveau n° du personnage à connecter (1, 2, 3, 4, 5) :", 200, 250, 350, 20)
  GUICtrlSetFont($labelModifChar, 11)
 $inputModifChar = GUICtrlCreateInput('', 550, 240, 135, 40)
 GUICtrlSetFont($inputModifChar, 11)
 _GUICtrlEdit_SetCueBanner($inputModifChar, "Remplacer par le n° du personnage à jouer") ; si empty

GUICtrlCreateTabItem('Options') ; -------------------------------------- Tout ce qui constitue Options --------------------------------------

;images
GUICtrlCreatePic("IMG/6_Dofus.jpg", 185, 30, 501, 96)
GUICtrlCreatePic("IMG/Bestiaire.jpg", 300, 190, 256, 152)

 Global $buttonSupprimerComptes = GUICtrlCreateButton('Supprimer toutes les données', 190, 150, 155, 30)
 GUICtrlSetFont($labelModifCompte, 11)
 Global	$buttonPath = GUICtrlCreateButton("Choisir un Chemin d'accès à Dofus.exe", 355, 150, 220, 30)
 GUICtrlSetFont($labelModifCompte, 11)
 Global	$buttonDonate = GUICtrlCreateButton('Faire un don', 585, 150, 100, 30)
 GUICtrlSetFont($labelModifCompte, 11)


GUICtrlCreateTabItem('About Us') ; -------------------------------------- Tout ce qui constitue About Us --------------------------------------

;images
GUICtrlCreatePic("IMG/Tanukoui_San.jpg", 520, 180, 129, 166)

Global $labelAboutUs = GUICtrlCreateLabel("Étant des joueurs passionnés par Dofus 1.29, nous " & @CRLF & "avons passés plusieurs semaines à développer Dufos MultiConnect qui facilitera grandement l'aventure Multi-Comptes !" & @CRLF & "Si le projet vous est utile et que vous voulez nous aider à réaliser d'autres projets en lien avec Dofus 1.29, n'hésitez pas à passer dans l'onglet << Options >> pour nous faire un don, peu importe le montant cela nous aiderait grandement!" & @CRLF & "Pour toute question, passez sur le Discord DufosMC !", 210, 30, 350, 190)
GUICtrlSetFont($labelAboutUs, 11)
GUICtrlCreateInput("https://discord.gg/gw4qxsA", 300, 230, 150, 30)
GUICtrlCreateTabItem('')

GUISetState()

$Item = -1
$Over = -1

While 1
	$Info = GUIGetCursorInfo()
	If @error Then
		If $Over <> -1 Then
			GUICtrlSetImage($Pic[$Over], @ScriptDir & '\img_black.bmp')
		EndIf
		$Over = -1
	Else
		$Index = _Index($Info[4])
		If $Index <> $Over Then
			If $Over <> -1 Then
				GUICtrlSetImage($Pic[$Over], @ScriptDir & '\img_black.bmp')
			EndIf
			If ($Index <> -1) And ($Index <> $Item) Then
				GUICtrlSetImage($Pic[$Index], @ScriptDir & '\img_over.bmp')
				$Over = $Index
			Else
				$Over = -1
			EndIf
		EndIf
	EndIf

	$Msg = GUIGetMsg()
	If $Item = -1 Then
		$Msg = $Pic[0]
		$Item = 1
	EndIf

	Switch $Msg
		Case 0
			ContinueLoop
		Case $GUI_EVENT_CLOSE
			Exit
		Case $msg = $buttonNouveauCompte
			button1()
		Case $msg = $buttonLancerScript
			button2()
		Case $msg = $buttonSupprimerComptes
			button3()
		Case $msg = $buttonUpdate
			button4()
		Case $msg = $buttonModifCompte
			button5()
		Case $msg = $buttonPath
			buttonPath()
		Case $msg = $buttonDonate
			buttonDonate()
		Case $Pic[0] To $Pic[UBound($Pic) - 1]
			If $Msg <> $Pic[$Item] Then
				GUICtrlSetImage($Pic[$Item], @ScriptDir & '\img_black.bmp')
				GUICtrlSetcolor($Pic[$Item] + 1, 0xFFFFFF)
				GUICtrlSetImage($Msg, @ScriptDir & '\img_white.bmp')
				GUICtrlSetcolor($Msg + 1, 0x313A42)
				$Item = _Index($Msg)
				GUICtrlSendMsg($Tab, $TCM_SETCURFOCUS, $Item, 0)
				$Over = -1
			EndIf
	EndSwitch
WEnd

EndFunc

Func _Index($CtrlID)
	For $i = 0 To UBound($Pic) - 1
		If ($CtrlID = $Pic[$i]) Or ($CtrlID = $Pic[$i] + 1) Then
			Return $i
		EndIf
	Next
	Return -1
EndFunc   ;==>_Index


; --------------------------------------------------------------- Début sauvegarde pour ne pas devoir retapper infos à chaque usage ---------------------------------------------------------------


Func savePart1()
	$test1 = 0;
	$test2 = 0;
	$test3 = 0;

	If FileExists("Dufos.txt") Then ; si sauvegarde existe
		$test1 = 1;

		local $file = FileOpen("Dufos.txt", 0)
		If $file = -1 Then
			MsgBox(0, "Erreur", "Problème lors de l'ouverture de la sauvegarde Dufos.txt.")
			Exit
		EndIf

		$arrRead = FileReadToArray( "Dufos.txt" )

		Local $iRows = UBound($arrRead, $UBOUND_ROWS)

		For $i = 0 To $iRows - 1
			If $i = 0 Then
				ReDim $arrBoth[UBound($arrBoth) + 1]
				$nbrComptes =  $arrRead[$i]
				$arrBoth[$i] = $arrRead[$i]
			ElseIf $i = 1 Then
				ReDim $arrBoth[UBound($arrBoth) + 1]
				$path = $arrRead[$i]
				$arrBoth[$i] = $arrRead[$i]
			ElseIf Mod( $i, 2 ) = 0 Then
				ReDim $arrBoth[UBound($arrBoth) + 1]
				ReDim $arrNdc[UBound($arrNdc) + 1]
				$tempI = (($i/2)-1)
				$arrNdc[$tempI] = $arrRead[$i]
				$arrBoth[$i] = $arrRead[$i]

			ElseIf Mod( $i, 2 ) = 1 Then
				ReDim $arrBoth[UBound($arrBoth) + 1]
				ReDim $arrPw[UBound($arrPw) + 1]
				$tempI2 = (((($i-1)/2))-1)
				$arrPw[$tempI2] = $arrRead[$i]
				$arrBoth[$i] = $arrRead[$i]
			Else
				Sleep(1)
			EndIf
		Next

		FileClose($file)

	EndIf

	If FileExists("Serv.txt") Then ; si sauvegarde existe
		$test2 = 1;

		Local $file1 = FileOpen("Serv.txt", 0)
			If $file1 = -1 Then
				MsgBox(0, "Erreur", "Problème lors de l'ouverture de la sauvegarde Serv.txt.")
				Exit
			EndIf
			$arrServ = FileReadToArray( "Serv.txt" )

		FileClose($file1)
	EndIf

	If FileExists("Char.txt") Then ; si sauvegarde existe
		$test3 = 1;

		Local $file2 = FileOpen("Char.txt", 0)
			If $file2 = -1 Then
				MsgBox(0, "Erreur", "Problème lors de l'ouverture de la sauvegarde Char.txt.")
				Exit
			EndIf
			$arrChar = FileReadToArray( "Char.txt" )

		FileClose($file2)
	EndIf

		GUICtrlSetData($choixNombreComptes, $nbrComptes, "9") ; met nombre de comptes au dernier utilisé
	If $test1 <> $test2 Or $test1 <> $test3 Or $test2 <> $test3 Then
		MsgBox (0,".txt manquant", "Attention, nous remarquons qu'un des fichiers .txt n'existe pas. Veuillez utiliser << Supprimer tout >> et refaire votre configuration !")
	EndIf


	If FileExists("Dufos.txt") = 0 Then ; si sauvegarde existe pas

			ReDim $arrBoth[UBound($arrBoth) + 1]
			$arrBoth[0] = "4"

			ReDim $arrBoth[UBound($arrBoth) + 1]
			$arrBoth[1] = $path
	EndIf
EndFunc ; ----------------------------------------------------------------------- Fin savePart1 -----------------------------------------------------------------------

; ----------------------------------------------------------------------- Début scripts GUI -----------------------------------------------------------------------

Func button1() ; Ajouter un compte
	$inputUserNdc = GUICtrlRead($inputAddNdc)
	$inputUserPw = GUICtrlRead($inputAddPw)
	$inputUserServ = GUICtrlRead($inputAddServ)
	$inputUserChar = GUICtrlRead($inputAddChar)

	If $inputUserNdc = "" Then
		MsgBox (0,"Nom de compte manquant", "Nom de compte obligatoire")
	ElseIf $inputUserPw = "" Then
		MsgBox (0,"Mot de passe manquant", "Mot de passe obligatoire")
	ElseIf $inputUserServ <> "1" And $inputUserServ <> "2" And $inputUserServ <> "3" Then
		MsgBox (0,"Numéro de serveur manquant", "Le numéro de serveur doit être entre 1 et 3")
	ElseIf $inputUserChar <> "1" And $inputUserChar <> "2" And $inputUserChar <> "3" And $inputUserChar <> "4" And $inputUserChar <> "5" Then
		MsgBox (0,"Numéro du personnage manquant", "Le numéro de personnage doit être entre 1 et 5")
	Else

		ReDim $arrBoth[UBound($arrBoth) + 1] ; augmente de 1 la range de l'array
		Local $iRows = UBound($arrBoth, $UBOUND_ROWS)
		$arrBoth[$iRows-1] = $inputUserNdc

		ReDim $arrBoth[UBound($arrBoth) + 1]
		Local $iRows = UBound($arrBoth, $UBOUND_ROWS)
		$arrBoth[$iRows-1] = $inputUserPw

		ReDim $arrServ[UBound($arrServ) + 1] ; augmente de 1 la range de l'array
		Local $iRows = UBound($arrServ, $UBOUND_ROWS)
		$arrServ[$iRows-1] = $inputUserServ

		ReDim $arrChar[UBound($arrChar) + 1]
		Local $iRows = UBound($arrChar, $UBOUND_ROWS)
		$arrChar[$iRows-1] = $inputUserChar

		ReDim $arrNdc[UBound($arrNdc) + 1]
		Local $iRows = UBound($arrNdc, $UBOUND_ROWS)
		$arrNdc[$iRows-1] = $inputUserNdc

		ReDim $arrPw[UBound($arrPw) + 1]
		Local $iRows = UBound($arrPw, $UBOUND_ROWS)
		$arrPw[$iRows-1] = $inputUserPw


		GUICtrlSetData($inputAddNdc, "") ; reset case ndc
		GUICtrlSetData($inputAddPw, "") ; reset case pw
		GUICtrlSetData($inputAddServ, "") ; reset case serv
		GUICtrlSetData($inputAddChar, "") ; reset case char

		GUICtrlSetData($choixCompteModif, $inputUserNdc, $inputUserNdc)

		$tempNdc = "Comptes" & @CRLF & @CRLF
		For $i = 0 To UBound($arrNdc) - 1
		   $tempNdc &=  $arrNdc[$i] & @CRLF
		Next

		$tempServ = "N°Serveur" & @CRLF & @CRLF
		For $i = 0 To UBound($arrServ) - 1
		   $tempServ &= $arrServ[$i] & @CRLF
		Next


		$tempChar = "N°Personnage" & @CRLF & @CRLF
		For $i = 0 To UBound($arrChar) - 1
		   $tempChar &=  $arrChar[$i] & @CRLF
		Next


		GUICtrlSetData ($createdAccountLabel, $tempNdc)
		GUICtrlSetData ($createServerLabel, $tempServ)
		GUICtrlSetData ($createdCharacterLabel, $tempChar)

	EndIf
EndFunc ; ----------------------------------------------------------------------- Fin button1 -----------------------------------------------------------------------

Func button2() ;lancer le script

	$nbrComptes = GUICtrlRead($choixNombreComptes)
	$arrBoth[0] = $nbrComptes

	If FileExists($pathClient) = 1 Then
		$path = $pathClient
;	ElseIf FileExists($path86) = 1 Then
;		$path = $path86
;	ElseIf FileExists($path64) = 1 Then
;		$path = $path64
;	ElseIf FileExists($path32) = 1 Then
;		$path = $path32
;	ElseIf FileExists($ProgFiles) = 1 Then
;		$path = $ProgFiles
;	ElseIf FileExists($pathProg) = 1 Then
;		$path = $pathProg
	Else
		MsgBox(0, "Erreur", "Il semble que Dofus.exe ne soit pas la ou nous le pensions. Veuillez trouver Dofus.exe et cliquer dessus!")
		Local Const $sMessage = "Trouvez le chemin d'accès Dofus.exe (Exemple 'C:\Users\User\AppData\Local\Ankama\zaap\dofus-1.29\Dofus.exe')"
		$path = FileOpenDialog($sMessage, "Bureau", "Scripts (*.exe)")
		FileChangeDir($cheminCourant)
	EndIf

	$arrBoth[1] = $path

	ecrireDufos()

	;----------------------------------------------------------------------- Fin écriture Dufos.txt -----------------------------------------------------------------------

	ecrireServ()

	;----------------------------------------------------------------------- Fin écriture Serv.txt -----------------------------------------------------------------------

	ecrireChar()

	;----------------------------------------------------------------------- Fin écriture Char.txt -----------------------------------------------------------------------

	$optionsOpti = GUICtrlRead($checkOptions)

	If (UBound($arrServ, $UBOUND_ROWS) < $nbrComptes) Then
		GUICtrlSetColor($label2, $COLOR_RED)
		MsgBox (0,"Attention", "Veuillez renseigner des comptes supplémentaires ou diminuer le nombre de comptes à connecter")
	Else
		lanceDofusV2()
	EndIf
 EndFunc ; ----------------------------------------------------------------------- Fin button2 -----------------------------------------------------------------------

Func button3()
	Local $check1 = 0
	Local $check2 = 0
	Local $check3 = 0

    Local $iDelete = FileDelete("Dufos.txt")

    If $iDelete Then
		$check1 = 1
	EndIf

    Local $iDelete = FileDelete("Serv.txt")

    If $iDelete Then
        $check2 = 1
	EndIf

	Local $iDelete = FileDelete("Char.txt")

    If $iDelete Then
		$check3 = 1
	EndIf

	If($check1 = 1 And $check2 = 1 And $check3 = 1 ) Then
		MsgBox($MB_SYSTEMMODAL, "Suppression réussie", "Comptes et mot de passes supprimés.")
	EndIf

	If($check1 = 0 And $check2 = 0 And $check3 = 0 ) Then
	MsgBox($MB_SYSTEMMODAL, "Suppression réussie.", "Comptes et mot de passes supprimés.")
	EndIf

	GUICtrlSetData ($createdAccountLabel, "")
	GUICtrlSetData ($createServerLabel, "Veuillez tout d'abord ajouter des données dans l'onglet << Ajout Compte >>")
	GUICtrlSetData ($createdCharacterLabel, "")

	Global $arrRead[20]
	Global $arrBoth[2]
	Global $arrNdc[0]
	Global $arrPw[0]
	Global $arrServ[0]
	Global $arrChar[0]
	Global $count = 0
	Global $nbrComptes = ""

EndFunc ; ----------------------------------------------------------------------- Fin button3 -----------------------------------------------------------------------

Func button4()
		Global $numeroCompte = comparateurButton4(GUICtrlRead($choixCompteModif))
		If $numeroCompte = -1 Then
			Sleep(1)
		Else
			GUICtrlSetData($inputModifPw, $arrPw[$numeroCompte])
			GUICtrlSetData($inputModifServ, $arrServ[$numeroCompte])
			GUICtrlSetData($inputModifChar, $arrChar[$numeroCompte])
		EndIf

EndFunc ; ----------------------------------------------------------------------- Fin button4 -----------------------------------------------------------------------

Func comparateurButton4($str)
	For $i = 0 To UBound($arrNdc, $UBOUND_ROWS) - 1
		If $arrNdc[$i] = $str Then
			Return $i
		EndIf
	Next
	MsgBox (0,"Modifier Compte", "Erreur, compte non trouvé")
	Return -1
EndFunc ; ----------------------------------------------------------------------- Fin comparateurButton4 -----------------------------------------------------------------------

Func button5()
	$arrPw[$numeroCompte] = GUICtrlRead($inputModifPw)
	$arrServ[$numeroCompte] = GUICtrlRead($inputModifServ)
	$arrChar[$numeroCompte] = GUICtrlRead($inputModifChar)

	GUICtrlSetData($inputModifPw, "") ; reset case pw
	GUICtrlSetData($inputModifServ, "") ; reset case serv
	GUICtrlSetData($inputModifChar, "") ; reset case char

	ecrireDufos()

	;----------------------------------------------------------------------- Fin écriture Dufos.txt -----------------------------------------------------------------------

	ecrireServ()

	;----------------------------------------------------------------------- Fin écriture Dufos.txt -----------------------------------------------------------------------

	ecrireChar()

	;----------------------------------------------------------------------- Fin écriture Dufos.txt -----------------------------------------------------------------------

		$tempNdc = "Comptes" & @CRLF & @CRLF
		For $i = 0 To UBound($arrNdc) - 1
		   $tempNdc &=  $arrNdc[$i] & @CRLF
		Next

		$tempServ = "N°Serveur" & @CRLF & @CRLF
		For $i = 0 To UBound($arrServ) - 1
		   $tempServ &= $arrServ[$i] & @CRLF
		Next


		$tempChar = "N°Personnage" & @CRLF & @CRLF
		For $i = 0 To UBound($arrChar) - 1
		   $tempChar &=  $arrChar[$i] & @CRLF
		Next


		GUICtrlSetData ($createdAccountLabel, $tempNdc)
		GUICtrlSetData ($createServerLabel, $tempServ)
		GUICtrlSetData ($createdCharacterLabel, $tempChar)

EndFunc ; ----------------------------------------------------------------------- Fin button5 -----------------------------------------------------------------------

Func buttonPath()
		Local Const $sMessage = "Trouvez le chemin d'accès Dofus.exe (Exemple 'C:\Program Files (x86)\Dofus\Dofus.exe')"
		$path = FileOpenDialog($sMessage, "Bureau", "Scripts (*.exe)")
		FileChangeDir($cheminCourant)
		$arrBoth[1] = $path
EndFunc ; ----------------------------------------------------------------------- Fin Path -----------------------------------------------------------------------

Func buttonDonate()
	ShellExecute("https://www.paypal.me/DufosMC")
EndFunc ; ----------------------------------------------------------------------- Fin Donate -----------------------------------------------------------------------

Func ecrireDufos()
	Local $file = FileOpen("Dufos.txt", 2); On écrit dans notre txt Dufos
	If $file = -1 Then
		MsgBox (0,"Attention", "écriture de Dufos.txt ratée.")
	Else
		For $el In $arrBoth
			FileWrite($file, $el & @CRLF)
		Next
		FileClose($file)
	EndIf
EndFunc ; ----------------------------------------------------------------------- Fin ecrireDufos -----------------------------------------------------------------------

Func ecrireServ()
	Local $file = FileOpen("Serv.txt", 2); On écrit dans notre txt Dufos
	If $file = -1 Then
		MsgBox (0,"Attention", "écriture de Serv.txt ratée")
	Else
		For $el In $arrServ
			FileWrite($file, $el & @CRLF)
		Next
		FileClose($file)
	EndIf
EndFunc ; ----------------------------------------------------------------------- Fin ecrireServ -----------------------------------------------------------------------

Func ecrireChar()
	Local $file = FileOpen("Char.txt", 2); On écrit dans notre txt Dufos
	If $file = -1 Then
		MsgBox (0,"Attention", "écriture de Char.txt ratée")
	Else
		For $el In $arrChar
			FileWrite($file, $el & @CRLF)
		Next
		FileClose($file)
	EndIf
EndFunc ; ----------------------------------------------------------------------- Fin ecrireChar -----------------------------------------------------------------------

; ----------------------------------------------------------------------- Fin GUI -----------------------------------------------------------------------

Func lanceDofusV2()

	if $optionsOpti = 1 Then
		reglageOptionsGenerales()
	EndIf

    $pixelServx = 953 * $desktopWidth
    $pixelServy = 80 * $desktopHeight
	$pixelx = 625 * $desktopWidth
    $pixely = 390 * $desktopHeight
    $couleurServer = 0x000000

    $sleep = 100 ; Dépend des performances de l'ordinateur à ouvrir les fenêtres dans l'ordre


	; ----------------------------------------------------------------------- Lancement des dofus -----------------------------------------------------------------------
	For $i = 0 To $nbrComptes - 1
		Run($path, "", @SW_MAXIMIZE)
		sleep($sleep)
	Next
	; ----------------------------------------------------------------------- Gestion des connexions ---------------------------------------------------------------------
	Local $count = 0
	For $i = $nbrComptes - 1 To 0 Step -1
		ReDim $iPID[UBound($iPID) + 1] ; augmente de 1 la range de l'array
		$iPID[$count] = WinWait("Dofus", "", 3)
		WinSetState($iPID[$count], "", @SW_MAXIMIZE)
		WinActivate($iPID[$count], "")
		While WinActive($iPID[$count]) = 0
			Sleep(50)
		Wend

		While pixelGetColor(550 * $desktopWidth, 392 * $desktopHeight) <> 0xFAF3EB
			Sleep(20)
		WEnd

	MouseClick($MOUSE_CLICK_LEFT, 550 * $desktopWidth, 392 * $desktopHeight, 1, $mousespeed)
		$count += 1
		While pixelGetColor($pixelx, $pixely) <> $couleurDuWaitingScreen
			Sleep(20)
		WEnd

		connexion($arrNdc[$i], $arrPw[$i])
	Next
	; ----------------------------------------------------------------------- Mise en ordre -----------------------------------------------------------------------------------------
;	For $i = 0 To $nbrComptes - 1
;		WinActivate($iPID[$i], "")
;	Next
	; ----------------------------------------------------------------------- Choix du serveur -------------------------------------------------------------------------------
	For $i = 0 To $nbrComptes - 1
		WinActivate($iPID[$i], "")
		While WinActive($iPID[$i]) = 0
			Sleep(50)
		Wend
		While pixelGetColor($pixelServx, $pixelServy) = $couleurServer
			Sleep(100)
		WEnd
		MouseClick($MOUSE_CLICK_LEFT, 554 * $desktopWidth, 63 * $desktopHeight, 1, $mousespeed)
		choixServeur($arrServ[$i])

	Next
    ; ----------------------------------------------------------------------- Choix du personnage -------------------------------------------------------------------------------
	For $i = 0 To $nbrComptes - 1
		 WinActivate($iPID[$i], "")
	     While WinActive($iPID[$i]) = 0
			Sleep(50)
	     Wend
		 While pixelGetColor($pixelServx, $pixelServy) = $couleurServer
			Sleep(100)
		 WEnd
		 MouseClick($MOUSE_CLICK_LEFT, 554 * $desktopWidth, 63 * $desktopHeight, 1, $mousespeed)
		 choixPersonnage($arrChar[$i])

	 Next
	; ----------------------------------------------------------------------- Fin de LanceDofusV2 -----------------------------------------------------------------------------------

EndFunc


Func altEsc()
	Send("{ALT down}")
	Sleep(20)

	Send("{ESC}")

	Sleep(20)
	Send("{ALT up}")
	Sleep(20)
EndFunc

Func connexion($nomdecompte, $password)
	Send($nomdecompte)
	Sleep(50)

	Send("{TAB}")

	Send($password)
	Sleep(50)

	Send("{TAB}")
	Sleep(20)

	Send("{ENTER}")
	Sleep(50)

	altEsc()
 EndFunc

Func choixServeur($numeroServeur)
   Select
		 Case $numeroServeur = 1
			 MouseClick($MOUSE_CLICK_LEFT, 504 * $desktopWidth, 578 * $desktopHeight, 2, $mousespeed)
		 Case $numeroServeur = 2
			 MouseClick($MOUSE_CLICK_LEFT, 731 * $desktopWidth, 578 * $desktopHeight, 2, $mousespeed)
		 Case $numeroServeur = 3
			 MouseClick($MOUSE_CLICK_LEFT, 964 * $desktopWidth, 578 * $desktopHeight, 2, $mousespeed)
   EndSelect
EndFunc

Func choixPersonnage($numeroPersonnage)
   Select
		 Case $numeroPersonnage = 1
			 MouseClick($MOUSE_CLICK_LEFT, 501 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
			 Sleep(50)
			 MouseClick($MOUSE_CLICK_LEFT, 501 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
		 Case $numeroPersonnage = 2
			 MouseClick($MOUSE_CLICK_LEFT, 730 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
			 Sleep(50)
			 MouseClick($MOUSE_CLICK_LEFT, 730 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
		 Case $numeroPersonnage = 3
			 MouseClick($MOUSE_CLICK_LEFT, 956 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
			 Sleep(50)
			 MouseClick($MOUSE_CLICK_LEFT, 956 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
		 Case $numeroPersonnage = 4
			 MouseClick($MOUSE_CLICK_LEFT, 1190 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
			 Sleep(50)
			 MouseClick($MOUSE_CLICK_LEFT, 1190 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
		 Case $numeroPersonnage = 5
			 MouseClick($MOUSE_CLICK_LEFT, 1423 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
			 Sleep(50)
			 MouseClick($MOUSE_CLICK_LEFT, 1423 * $desktopWidth, 623 * $desktopHeight, 1, $mousespeed)
   EndSelect
EndFunc

Func clickServer()

    MouseClick($MOUSE_CLICK_LEFT, 504 * $desktopWidth, 583 * $desktopHeight, 2, $mousespeed)

    altEsc()
 EndFunc


Func reglageOptionsGenerales()
	Local $cheminAcces
	$cheminAcces = Run($path, "", @SW_MAXIMIZE)

	sleep(500)
	Local $iPID10 = WinWait("Dofus", "", 3)
	WinSetState($iPID10, "", @SW_MAXIMIZE)
	WinActivate($iPID10, "")

	While WinActive($iPID10 = 0)
		Sleep(50)
	Wend

	While pixelGetColor(550 * $desktopWidth, 392 * $desktopHeight) <> 0xFAF3EB
		Sleep(20)
	WEnd

	MouseClick($MOUSE_CLICK_LEFT, 550 * $desktopWidth, 392 * $desktopHeight, 1, $mousespeed)
	MouseClick($MOUSE_CLICK_LEFT, 1549 * $desktopWidth, 57 * $desktopHeight, 1, $mousespeed) ; Ouverture de la fenêtre des options
	MouseClick($MOUSE_CLICK_LEFT, 998 * $desktopWidth, 873 * $desktopHeight, 1, $mousespeed) ; Remet les paramètres par défaut
	MouseClick($MOUSE_CLICK_LEFT, 676 * $desktopWidth, 408 * $desktopHeight, 1, $mousespeed) ; Afficher la grille (activer)
	MouseClick($MOUSE_CLICK_LEFT, 677 * $desktopWidth, 444 * $desktopHeight, 1, $mousespeed) ; Afficher les joueurs en transparence (activer)
	MouseClick($MOUSE_CLICK_LEFT, 676 * $desktopWidth, 480 * $desktopHeight, 1, $mousespeed) ; Afficher les coordonnées de la carte (activer)
	MouseClick($MOUSE_CLICK_LEFT, 677 * $desktopWidth, 516 * $desktopHeight, 1, $mousespeed) ; Auto-fermeture du panneau des attitudes (activer)
	MouseClick($MOUSE_CLICK_LEFT, 677 * $desktopWidth, 552 * $desktopHeight, 1, $mousespeed) ; Afficher tous les monstres d'un groupe (désactiver)
	MouseClick($MOUSE_CLICK_LEFT, 694 * $desktopWidth, 666 * $desktopHeight, 1, $mousespeed) ; Afficher les portées de déplacement (activer)
	MouseClick($MOUSE_CLICK_LEFT, 676 * $desktopWidth, 738 * $desktopHeight, 1, $mousespeed) ; Mettre en valeur les cases ciblables (activer)

	MouseWheel($MOUSE_WHEEL_DOWN, 25) ;Scroll en bas

	MouseClick($MOUSE_CLICK_LEFT, 677 * $desktopWidth, 343 * $desktopHeight, 1, $mousespeed) ; Afficher une astuce au démarrage (désactiver)
	MouseClick($MOUSE_CLICK_LEFT, 677 * $desktopWidth, 594 * $desktopHeight, 1, $mousespeed) ; Afficher l'heure de réception des messages dans le chat (activer)
	MouseClick($MOUSE_CLICK_LEFT, 676 * $desktopWidth, 746 * $desktopHeight, 1, $mousespeed) ; Filtrer les mots insultant dans le chat (désactiver)
	MouseClick($MOUSE_CLICK_LEFT, 677 * $desktopWidth, 782 * $desktopHeight, 1, $mousespeed) ; Autoriser les Obvijevan à parler

	MouseClick($MOUSE_CLICK_LEFT, 916 * $desktopWidth, 247 * $desktopHeight, 1, $mousespeed) ; Ouverture de l'onglet "Audio"
	MouseClick($MOUSE_CLICK_LEFT, 1152 * $desktopWidth, 345 * $desktopHeight, 1, $mousespeed) ; Musiques (Mute)
	MouseClick($MOUSE_CLICK_LEFT, 1152 * $desktopWidth, 391 * $desktopHeight, 1, $mousespeed) ; Son (Mute)
	MouseClick($MOUSE_CLICK_LEFT, 1155 * $desktopWidth, 442 * $desktopHeight, 1, $mousespeed) ; Sons d'ambiance (Mute)

	MouseClick($MOUSE_CLICK_LEFT, 1094 * $desktopWidth, 248 * $desktopHeight, 1, $mousespeed) ; Ouverture de l'onglet "Affichage"
	MouseClick($MOUSE_CLICK_LEFT, 675 * $desktopWidth, 431 * $desktopHeight, 1, $mousespeed) ; Illustration en début de tour (désactiver)
	MouseClick($MOUSE_CLICK_LEFT, 675 * $desktopWidth, 506 * $desktopHeight, 1, $mousespeed) ; Afficher les astuces du tutoriel (désactiver)
	MouseClick($MOUSE_CLICK_LEFT, 1040 * $desktopWidth, 554 * $desktopHeight, 1, $mousespeed) ; Limite de passage en mode créatures (15 créatures)
	MouseClick($MOUSE_CLICK_LEFT, 1014 * $desktopWidth, 689 * $desktopHeight, 1, $mousespeed) ; Qualité Flash
	MouseClick($MOUSE_CLICK_LEFT, 990 * $desktopWidth, 720 * $desktopHeight, 1, $mousespeed) ; Mise qualité Flash en Faible
	MouseClick($MOUSE_CLICK_LEFT, 833 * $desktopWidth, 628 * $desktopHeight, 1, $mousespeed) ; Confirmer la qualité

	WinKill($iPID10, "") ; Ferme la fenêtre

EndFunc

