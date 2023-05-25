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



function Get-MonkeyADPolicy {
<#
        .SYNOPSIS
		Plugin to get policies from Azure AD
        https://msdn.microsoft.com/en-us/library/azure/ad/graph/api/policy-operations

        .DESCRIPTION
		Plugin to get policies from Azure AD
        https://msdn.microsoft.com/en-us/library/azure/ad/graph/api/policy-operations

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .NOTES
	        Author		: Juan Garrido
            Twitter		: @tr1ana
            File Name	: Get-MonkeyADPolicy
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
		$Environment = $O365Object.Environment
		#Plugin metadata
		$monkey_metadata = @{
			Id = "aad0008";
			Provider = "AzureAD";
			Resource = "AzureAD";
			ResourceType = $null;
			resourceName = $null;
			PluginName = "Get-MonkeyADPolicy";
			ApiType = "Graph";
			Title = "Plugin to get policies from Azure AD";
			Group = @("AzureAD");
			Tags = @{
				"enabled" = $true
			};
			Docs = "https://silverhack.github.io/monkey365/"
		}
		#Get Azure Active Directory Auth
		$AADAuth = $O365Object.auth_tokens.Graph
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
        #Excluded auth
		$ExcludedAuths = @("certificate_credentials","client_credentials")
        if ($ExcludedAuths -contains $O365Object.AuthType) {
			$api_version = $aadConf.api_version
		}
        else{
            $api_version = $aadConf.internal_api_version
        }
	}
	process {
		$msg = @{
			MessageData = ($message.MonkeyGenericTaskMessage -f $pluginId,"Azure AD policies",$O365Object.TenantID);
			callStack = (Get-PSCallStack | Select-Object -First 1);
			logLevel = 'info';
			InformationAction = $O365Object.InformationAction;
			Tags = @('AzureGraphPolicies');
		}
		Write-Information @msg
		#Get policies
		$URI = ("{0}/myorganization/policies?api-version={1}" -f $Environment.Graph,`
 				$api_version)
		#Get policies
		$params = @{
			Authentication = $AADAuth;
			OwnQuery = $URI;
			Environment = $Environment;
			ContentType = 'application/json';
			Method = "GET";
            InformationAction = $O365Object.InformationAction;
			Verbose = $O365Object.Verbose;
			Debug = $O365Object.Debug;
		}
		$all_policies = Get-MonkeyGraphObject @params
	}
	end {
		if ($all_policies) {
			$all_policies.PSObject.TypeNames.Insert(0,'Monkey365.AzureAD.Policies')
			[pscustomobject]$obj = @{
				Data = $all_policies;
				Metadata = $monkey_metadata;
			}
			$returnData.aad_domain_policies = $obj
		}
		else {
			$msg = @{
				MessageData = ($message.MonkeyEmptyResponseMessage -f "Azure AD Policies",$O365Object.TenantID);
				callStack = (Get-PSCallStack | Select-Object -First 1);
				logLevel = "verbose";
				InformationAction = $O365Object.InformationAction;
				Tags = @('AzureGraphPoliciesEmptyResponse');
				Verbose = $O365Object.Verbose;
			}
			Write-Verbose @msg
		}
	}
}




