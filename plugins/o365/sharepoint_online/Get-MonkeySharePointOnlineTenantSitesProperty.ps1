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


function Get-MonkeySharePointOnlineTenantSitesProperty {
<#
        .SYNOPSIS
		Plugin to extract information about O365 SharePoint Online services Tenant site properties

        .DESCRIPTION
		Plugin to extract information about O365 SharePoint Online services Tenant site properties

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .NOTES
	        Author		: Juan Garrido
            Twitter		: @tr1ana
            File Name	: Get-MonkeySharePointOnlineTenantSitesProperty
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
			Id = "sps0010";
			Provider = "Microsoft365";
			Title = "Plugin to extract information about SharePoint Online Tenant site properties";
			Group = @("SharePointOnline");
			ServiceName = "SharePoint Online Tenant site properties";
			PluginName = "Get-MonkeySharePointOnlineTenantSitesProperty";
			Docs = "https://silverhack.github.io/monkey365/"
		}
		#Get Access Token for SharePoint
		$sps_auth = $O365Object.auth_tokens.SharePointOnline
		#Get Access Token for SharePoint admin
		$sps_admin_auth = $O365Object.auth_tokens.SharePointAdminOnline
		#Check if user is sharepoint administrator
		$isSharePointAdministrator = Test-IsUserSharepointAdministrator
		#Get flag
		$scanSites = [System.Convert]::ToBoolean($O365Object.internal_config.o365.SharePointOnline.ScanSites)
	}
	process {
		$msg = @{
			MessageData = ($message.MonkeyGenericTaskMessage -f $pluginId,"SharePoint Online Tenant Sites",$O365Object.TenantID);
			callStack = (Get-PSCallStack | Select-Object -First 1);
			logLevel = 'info';
			InformationAction = $InformationAction;
			Tags = @('SPSTenantSites');
		}
		Write-Information @msg
		if ($isSharePointAdministrator) {
			if ($scanSites) {
				#Get current site
				$param = @{
					Authentication = $sps_admin_auth;
				}
				$sps_sites = Get-MonkeySPSSiteProperty @param
				if ($sps_sites) {
					$sps_sites = $sps_sites | Where-Object { $_.Template -notlike "SRCHCEN#0" -and $_.Template -notlike "SPSMSITEHOST*" }
				}
			}
			else {
				#Get current site
				$param = @{
					Authentication = $sps_auth;
				}
				$raw_site = Get-MonkeySPSSite @param
				if ($raw_site) {
					#Get site properties
					$param = @{
						Authentication = $sps_admin_auth;
						url = $raw_site.url
					}
					$sps_sites = Get-MonkeySPSSitePropertiesByUrl @param
				}
			}
		}
	}
	end {
		if ($sps_sites) {
			$sps_sites.PSObject.TypeNames.Insert(0,'Monkey365.SharePoint.Sites')
			[pscustomobject]$obj = @{
				Data = $sps_sites;
				Metadata = $monkey_metadata;
			}
			$returnData.o365_spo_tenant_sites = $obj
		}
		else {
			$msg = @{
				MessageData = ($message.MonkeyEmptyResponseMessage -f "SharePoint Online Tenant Sites",$O365Object.TenantID);
				callStack = (Get-PSCallStack | Select-Object -First 1);
				logLevel = 'warning';
				InformationAction = $InformationAction;
				Tags = @('SPSTenantSitesEmptyResponse');
			}
			Write-Warning @msg
		}
	}
}
