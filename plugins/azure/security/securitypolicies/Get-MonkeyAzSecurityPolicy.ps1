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



function Get-MonkeyAzSecurityPolicy {
<#
        .SYNOPSIS
		Plugin to get information about Security Policies from Azure
        https://msdn.microsoft.com/en-us/library/azure/mt704061.aspx

        .DESCRIPTION
		Plugin to get information about Security Policies from Azure
        https://msdn.microsoft.com/en-us/library/azure/mt704061.aspx

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .NOTES
	        Author		: Juan Garrido
            Twitter		: @tr1ana
            File Name	: Get-MonkeyAzSecurityPolicy
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
		#Plugin metadata
		$monkey_metadata = @{
			Id = "az00037";
			Provider = "Azure";
			Title = "Plugin to get information about Azure security policies";
			Group = @("Subscription","DefenderForCloud");
			ServiceName = "Azure Security policies";
			PluginName = "Get-MonkeyAzSecurityPolicy";
			Docs = "https://silverhack.github.io/monkey365/"
		}
		#Get Environment
		$Environment = $O365Object.Environment
		#Get Azure RM Auth
		$rm_auth = $O365Object.auth_tokens.ResourceManager
		#Get config
		$AzureSecPolicies = $O365Object.internal_config.ResourceManager | Where-Object { $_.Name -eq "azureSecurityPolicies" } | Select-Object -ExpandProperty resource
	}
	process {
		$msg = @{
			MessageData = ($message.MonkeyGenericTaskMessage -f $pluginId,"Azure Security Policies",$O365Object.current_subscription.displayName);
			callStack = (Get-PSCallStack | Select-Object -First 1);
			logLevel = 'info';
			InformationAction = $InformationAction;
			Tags = @('AzureSecPoliciesInfo');
		}
		Write-Information @msg
		#List All Security Policies
		$params = @{
			Authentication = $rm_auth;
			Provider = $AzureSecPolicies.Provider;
			ObjectType = "policies";
			Environment = $Environment;
			ContentType = 'application/json';
			Method = "GET";
			APIVersion = $AzureSecPolicies.api_version;
		}
		$SecPolicies = Get-MonkeyRMObject @params
	}
	end {
		if ($SecPolicies) {
			$SecPolicies.PSObject.TypeNames.Insert(0,'Monkey365.Azure.SecurityPolicies')
			[pscustomobject]$obj = @{
				Data = $SecPolicies;
				Metadata = $monkey_metadata;
			}
			$returnData.az_security_policies = $obj
		}
		else {
			$msg = @{
				MessageData = ($message.MonkeyEmptyResponseMessage -f "Azure Security Policies",$O365Object.TenantID);
				callStack = (Get-PSCallStack | Select-Object -First 1);
				logLevel = 'warning';
				InformationAction = $InformationAction;
				Tags = @('AzureKeySecPoliciesEmptyResponse');
			}
			Write-Warning @msg
		}
	}
}
