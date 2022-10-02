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


function Get-MonkeyEXOAuthenticationPolicy {
<#
        .SYNOPSIS
		Plugin to get information about Auth policy in Exchange Online

        .DESCRIPTION
		Plugin to get information about Auth policy in Exchange Online

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .NOTES
	        Author		: Juan Garrido
            Twitter		: @tr1ana
            File Name	: Get-MonkeyEXOAuthenticationPolicy
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
		$auth_policy = $null
		#Plugin metadata
		$monkey_metadata = @{
			Id = "exo0008";
			Provider = "Microsoft365";
			Title = "Plugin to get information about Auth policy in Exchange Online";
			Group = @("ExchangeOnline");
			ServiceName = "Exchange Online Auth Policy";
			PluginName = "Get-MonkeyEXOAuthenticationPolicy";
			Docs = "https://silverhack.github.io/monkey365/"
		}
		#Check if already connected to Exchange Online
		$exo_session = Test-EXOConnection
	}
	process {
		if ($null -ne $exo_session) {
			$msg = @{
				MessageData = ($message.MonkeyGenericTaskMessage -f $pluginId,"Exchange Online authentication policy",$O365Object.TenantID);
				callStack = (Get-PSCallStack | Select-Object -First 1);
				logLevel = 'info';
				InformationAction = $InformationAction;
				Tags = @('ExoAuthPolicyInfo');
			}
			Write-Information @msg
			#Get authentication policy
			#https://docs.microsoft.com/en-us/exchange/clients-and-mobile-in-exchange-online/disable-basic-authentication-in-exchange-online
			$auth_policy = Get-ExoMonkeyAuthenticationPolicy
		}
	}
	end {
		if ($null -ne $auth_policy) {
			$auth_policy.PSObject.TypeNames.Insert(0,'Monkey365.ExchangeOnline.AuthPolicy')
			[pscustomobject]$obj = @{
				Data = $auth_policy;
				Metadata = $monkey_metadata;
			}
			$returnData.o365_exo_auth_policy = $obj
		}
		else {
			$msg = @{
				MessageData = ($message.MonkeyEmptyResponseMessage -f "Exchange Online authentication policy",$O365Object.TenantID);
				callStack = (Get-PSCallStack | Select-Object -First 1);
				logLevel = 'warning';
				InformationAction = $InformationAction;
				Tags = @('ExoAuthPolicyEmptyResponse');
			}
			Write-Warning @msg
		}
	}
}
