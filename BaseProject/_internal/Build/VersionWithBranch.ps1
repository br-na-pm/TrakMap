# ASGitVersion.ps1

# Define file variables
$taskDir = $args[0] + "\Logical";
$variableFile = $taskDir + "\MachineVersionInfo.var";
$versionVar = "MachineSoftwareVersion";
$dateVar = "MachineLastRevisionDate";

# Get version info from Git. example 1.2.3-45-g6789abc
#$gitVersion = git -C $args[0] describe --tags --long --always --match "V[0-9]*"; # Add --tags in case of a non-annotated tag, Add "V" for our version naming
$gitVersion = git -C $args[0] describe --tags --long --always --match "[0-9]*";

#$gitRev = [regex]::Match($gitVersion, "V(.*)-(\d+)-[g](\w+)") # option for additional "V" in the tag info
$gitRev = [regex]::Match($gitVersion, "(.*)-(\d+)-[g](\w+)")

$gitBranch = git -C $args[0] branch --show-current;

if (-Not $gitRev.Success){
	"Git command not found or version not in recognizable format";
	return;
}

$gitTag = $gitRev.Groups[1].Value
$gitCount = $gitRev.Groups[2].Value;
$gitSHA1 = $gitRev.Groups[3].Value;

$existingContent = Get-Content ($variableFile);
$currentVersion = [regex]::Match($existingContent, "$versionVar\s*:\s*STRING\[80]\s*:=\s*'.*';");

#make sure that a version number is set
If ($currentVersion.Success) {
	$newMainTask = $existingContent | %{$_ -replace [Regex]::Escape($currentVersion.Value), ("$versionVar : STRING[80] := '$gitBranch-$gitTag-$gitCount-$gitSHA1';") };
	$newMainTask | Out-File -FilePath ($variableFile) -Encoding ascii;
}

$existingContent = Get-Content ($variableFile);
$currentDate = [regex]::Match($existingContent, "$dateVar\s*:\s*DATE_AND_TIME\s*:=\s*DT#[\d\-:]*;");

$gitCommitDate = git -C $args[0] show -s --date=format:"%Y-%m-%d-%H:%M" --pretty=format:"DT#%cd";

#make sure that a version number is set
If ($currentVersion.Success) {
	$newMainTask = $existingContent | %{$_ -replace [Regex]::Escape($currentDate.Value), ("$dateVar : DATE_AND_TIME := $gitCommitDate;") };
	$newMainTask | Out-File -FilePath ($variableFile) -Encoding ascii;
}

$hardware = $args[0] + "\Physical\" + $args[1] + "\Hardware.hw";
$existingContent = Get-Content ($hardware);
$configVersion = [regex]::Match($existingContent, "<Parameter ID=""ConfigVersion"" Value=""(\d+\.\d+\.\d+)"" />");
# Updating the version causes AS to reload all tabs so only update the configuration version if it has changed.
if ($configVersion.Success -And ($configVersion.Groups[1].Value -ne $gitTag)) {
	$newHardware = $existingContent | %{$_ -replace [Regex]::Escape($configVersion.Value), ("<Parameter ID=""ConfigVersion"" Value=""$gitTag"" />") };
	$newHardware | Out-File -FilePath ($hardware) -Encoding ascii;
}
elseif (-Not $configVersion.Success){
	#if the config version is not found then it is most likely version 1.0.0 so we have to add it in after the ConfigurationID
	$configID = [regex]::Match($existingContent, "<Parameter ID=""ConfigurationID"" Value=""[\w\d_]+"" />");
	if ($configID.Success) {
		$newHardware = $existingContent | %{$_ -replace [Regex]::Escape($configID.Value), ("$configID`r`n    <Parameter ID=""ConfigVersion"" Value=""$gitTag"" />") };
		$newHardware | Out-File -FilePath ($hardware) -Encoding ascii;
	}
}
