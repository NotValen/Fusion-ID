; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Fusion-ID"
#define MyAppVersion "Beta 0.3"
#define MyAppPublisher "Fusion-ID Dev Team"
#define MyAppURL "https://github.com/NotValen/Fusion-ID"
#define MyAppExeName "Fusion-ID-Installer.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{DB33067A-DE78-436A-8619-03D65F359FED}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=.
LicenseFile=..\LICENSE
InfoBeforeFile=..\README.txt
UninstallDisplayName={#MyAppName} {#MyAppVersion}

OutputBaseFilename=Fusion-ID-Installer-With-Dotnet-And-Melon

DisableFinishedPage=no
DisableWelcomePage=yes
DisableReadyPage=yes
DirExistsWarning=no
AppendDefaultDirName=no

; Remove the following line to run in administrative install mode (install for all users.)
PrivilegesRequired=lowest
Compression=lzma
SolidCompression=yes
WizardStyle=modern


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "VC_redist.x64.exe"; DestDir: "{tmp}"; Flags: ignoreversion; AfterInstall: RunVCRedistIntaller
Source: "dotnet-runtime.exe"; DestDir: "{tmp}"; Flags: ignoreversion; AfterInstall: RunOtherInstaller
Source: "..\Mods\PVZ_Hyper_Fusion\LawnStringsTranslate.json"; DestDir: "{app}\Mods\PVZ_Hyper_Fusion\"; Flags: ignoreversion
Source: "..\Mods\PVZ_Hyper_Fusion\ZombieStringsTranslate.json"; DestDir: "{app}\Mods\PVZ_Hyper_Fusion\"; Flags: ignoreversion
Source: "..\Mods\PVZ_Hyper_Fusion.dll"; DestDir: "{app}\Mods\"; Flags: ignoreversion
Source: "..\Mods\PVZ_Hyper_Fusion\Textures\*"; DestDir: "{app}\Mods\PVZ_Hyper_Fusion\Textures\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\Mods\PVZ_Hyper_Fusion\Strings\*"; DestDir: "{app}\Mods\PVZ_Hyper_Fusion\Strings\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\Mods\PVZ_Hyper_Fusion\Dumps\*"; DestDir: "{app}\Mods\PVZ_Hyper_Fusion\Dumps\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\MelonLoader\*"; DestDir: "{app}\MelonLoader"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\dobby.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\version.dll"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Code]

function NextCheck(Sender: TWizardPage): Boolean;
begin
	if not FileExists((WizardDirValue() + '\PlantsVsZombiesRH.exe'))
	then
		begin
			MsgBox('Select a directory with the PlantsVsZombiesRH.exe', mbInformation, MB_OK)
			result := False
		end
	else
		result := True;
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
	Confirm := False;
end;

procedure InitializeWizard();
var
	Page: TWizardPage;
begin
	Page := PageFromID(wpSelectDir);
	
	Page.Caption := 'Location Plant Vs Zombies RH'
  Page.Description := 'To continue the installation, select the folder with the game.'
	
	Page.OnNextButtonClick := @NextCheck;
end;

procedure RunOtherInstaller;
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{tmp}\dotnet-runtime.exe'), '', '', SW_SHOWNORMAL,
    ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('Other installer failed to run!' + #13#10 +
      SysErrorMessage(ResultCode), mbError, MB_OK);
end;

procedure RunVCRedistIntaller;
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{tmp}\VC_redist.x64.exe'), '', '', SW_SHOWNORMAL,
    ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('Other installer failed to run!' + #13#10 +
      SysErrorMessage(ResultCode), mbError, MB_OK);
end;