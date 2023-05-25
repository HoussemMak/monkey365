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


function Get-MonkeyADFeatureEnabled {
<#
        .SYNOPSIS
		Plugin to extract information about existing features enabled in Azure AD

        .DESCRIPTION
		Plugin to extract information about existing features enabled in Azure AD

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .NOTES
	        Author		: Juan Garrido
            Twitter		: @tr1ana
            File Name	: Get-MonkeyADFeatureEnabled
            Version     : 1.0

        .LINK
            https://github.com/silverhack/monkey365
    #>

	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $false,HelpMessage = "Background Plugin ID")]
		[string]$pluginId
	)
	begin {
		$features = $null
		#Plugin metadata
		$monkey_metadata = @{
			Id = "aad0004";
			Provider = "AzureAD";
			Resource = "AzureAD";
			ResourceType = $null;
			resourceName = $null;
			PluginName = "Get-MonkeyADFeatureEnabled";
			ApiType = "Graph";
			Title = "Plugin to extract information about existing features enabled in Azure AD";
			Group = @("AzureAD");
			Tags = @{
				"enabled" = $true
			};
			Docs = "https://silverhack.github.io/monkey365/"
		}
		#Excluded auth
		$ExcludedAuths = @("certificate_credentials","client_credentials")
		#Getting Environment
		$Environment = $O365Object.Environment
		#Get Graph Authentication
		$AADAuth = $O365Object.auth_tokens.Graph
		$msg = @{
			MessageData = ($message.MonkeyGenericTaskMessage -f $pluginId,"Azure AD Features",$O365Object.TenantID);
			callStack = (Get-PSCallStack | Select-Object -First 1);
			logLevel = 'info';
			InformationAction = $O365Object.InformationAction;
			Tags = @('AzureGraphADFeatures');
		}
		Write-Information @msg
		$allowed_features = @(
			'AllowEmailVerifiedUsers',
			'AllowInvitations',
			'AllowMemberUsersToInviteOthersAsMembers',
			'AllowUsersToChangeTheirDisplayName',
			'B2CFeature',
			'BlockAllTenantAuth',
			'ConsentedForMigrationToPublicCloud',
			'EnableExchangeDualWrite',
			'EnableHiddenMembership',
			'EnableSharedEmailDomainApis',
			'EnableWindowsLegacyCredentials',
			'EnableWindowsSupplementalCredentials',
			'ElevatedGuestsAccessEnabled',
			'ExchangeDualWriteUsersV1',
			'GuestsCanInviteOthersEnabled',
			'InvitationsEnabled',
			'LargeScaleTenant',
			'TestTenant',
			'USGovTenant',
			'DisableOnPremisesWindowsLegacyCredentialsSync',
			'DisableOnPremisesWindowsSupplementalCredentialsSync',
			'RestrictPublicNetworkAccess',
			'AutoApproveSameTenantRequests',
			'RedirectPpeUsersToMsaInt'
		)
		if ($ExcludedAuths -contains $O365Object.AuthType) {
			Write-Warning ("This request is not allowed with {0} authentication flow" -f $O365Object.AuthType)
            break
		}
        #Get Config
        try{
            $aadConf = $O365Object.internal_config.azuread.provider.graph
        }
        catch{
            $msg = @{
                MessageData = ($message.MonkeyInternalConfigError);
                callStack = (Get-PSCallStack | Select-Object -First 1);
                logLevel = 'verbose';
                InformationAction = $O365Object.InformationAction;
                Tags = @('Monkey365ConfigError');
            }
            Write-Verbose @msg
            break
        }
	}
	process {
		$features = @{}
		$OwnQuery = ("{0}/myorganization/isDirectoryFeatureEnabled?api-version={1}" -f $Environment.Graph, $aadConf.internal_api_version)
		if ($null -ne $Environment -and $null -ne $AADAuth) {
			foreach ($feature in $allowed_features) {
				$postData = @{
					directoryFeature = $feature
				} | ConvertTo-Json
				$params = @{
					Authentication = $AADAuth;
					OwnQuery = $OwnQuery;
					Data = $postData;
					Environment = $Environment;
					ContentType = 'application/json';
					Method = "POST";
					returnRawResponse = $true;
                    InformationAction = $O365Object.InformationAction;
			        Verbose = $O365Object.Verbose;
			        Debug = $O365Object.Debug;
				}
				$returned_feature = Get-MonkeyGraphObject @params
				if ($null -ne $returned_feature -and $null -ne $returned_feature.PSObject.Properties.Item('value')) {
					$features.Add($feature,$returned_feature.value)
					#Close response
					$returned_feature.Close()
					$returned_feature.Dispose()
				}
			}
		}
	}
	end {
		if ($null -ne $features) {
			$features.PSObject.TypeNames.Insert(0,'Monkey365.AzureAD.FeatureInfo')
			[pscustomobject]$obj = @{
				Data = $features;
				Metadata = $monkey_metadata;
			}
			$returnData.aad_enabled_features = $obj
		}
		else {
			$msg = @{
				MessageData = ($message.MonkeyEmptyResponseMessage -f "Azure AD Features",$O365Object.TenantID);
				callStack = (Get-PSCallStack | Select-Object -First 1);
				logLevel = "verbose";
				InformationAction = $O365Object.InformationAction;
				Tags = @('AzureADFeaturesEmptyResponse');
				Verbose = $O365Object.Verbose;
			}
			Write-Verbose @msg
		}
	}
}




