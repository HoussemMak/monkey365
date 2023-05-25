﻿# Monkey365 - the PowerShell Cloud Security Tool for Azure and Microsoft 365 (copyright 2022) by Juan Garrido
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

[CmdletBinding()]
param ()
$compliance_session = $null
$isO365Object = Get-Variable -Name O365Object -ErrorAction Ignore
if($null -ne $isO365Object){
    $progresspreference_backup = $progresspreference;
    $progresspreference='SilentlyContinue'
    #Set Monkey365 current location
    Set-Location -Path $O365Object.InitialPath;
    #Import Localized data
    $LocalizedDataParams = $O365Object.LocalizedDataParams
    if($null -ne $LocalizedDataParams){
        #Import Localized data
        $msg = @{
            MessageData = "Importing localized messages within runspace";
            callStack = (Get-PSCallStack | Select-Object -First 1);
            logLevel = 'info';
            InformationAction = $O365Object.InformationAction;
            Tags = @('InitializeLocalizedData');
        }
        Write-Information @msg
        Import-LocalizedData @LocalizedDataParams;
    }
    #Import Exchange Online Compliance PsSession
    if($null -ne ($O365Object.o365_sessions.GetEnumerator() | Where-Object {$_.Name -eq 'ComplianceCenter'})){
        $compliance_session = $O365Object.o365_sessions.ComplianceCenter
    }
    if($null -ne $compliance_session -and $compliance_session -is [System.Management.Automation.Runspaces.PSSession]){
        $msg = @{
            MessageData = "Importing Exchange Online Compliance Center PsSession within runspace";
            callStack = (Get-PSCallStack | Select-Object -First 1);
            logLevel = 'info';
            InformationAction = $script:InformationAction;
            Tags = @('InitializePsSession');
        }
        Write-Information @msg
        $p = @{
            Session = $compliance_session;
            DisableNameChecking = $true;
            AllowClobber= $true;
        }
        [ref]$null = Import-PSSession @p
        #Sleep
        Start-Sleep -Milliseconds 500
    }
    #Return old progress preference
    $progresspreference = $progresspreference_backup;
}

