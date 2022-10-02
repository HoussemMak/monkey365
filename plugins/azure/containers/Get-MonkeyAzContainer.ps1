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



function Get-MonkeyAzContainer {
<#
        .SYNOPSIS
		Plugin to get information about Azure Containers
        https://docs.microsoft.com/en-us/rest/api/container-instances/container-groups/list-by-resource-group#encryptionproperties

        .DESCRIPTION
		Plugin to get information about Azure Containers
        https://docs.microsoft.com/en-us/rest/api/container-instances/container-groups/list-by-resource-group#encryptionproperties

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .NOTES
	        Author		: Juan Garrido
            Twitter		: @tr1ana
            File Name	: Get-MonkeyAzContainer
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
		#Import Localized data
		#Plugin metadata
		$monkey_metadata = @{
			Id = "az00007";
			Provider = "Azure";
			Title = "Plugin to get information about Azure Containers";
			Group = @("Containers");
			ServiceName = "Azure Container";
			PluginName = "Get-MonkeyAzContainer";
			Docs = "https://silverhack.github.io/monkey365/"
		}
		$LocalizedDataParams = $O365Object.LocalizedDataParams
		Import-LocalizedData @LocalizedDataParams;
		#Get Environment
		$Environment = $O365Object.Environment
		#Get Azure Active Directory Auth
		$rm_auth = $O365Object.auth_tokens.ResourceManager
		#Get Config
		$cntAPI = $O365Object.internal_config.ResourceManager | Where-Object { $_.Name -eq "azureContainers" } | Select-Object -ExpandProperty resource
		#Get container groups
		$container_groups = $O365Object.all_resources | Where-Object { $_.type -eq 'Microsoft.ContainerInstance/containerGroups' }
		if (-not $container_groups) { continue }
		$all_containers = @();
	}
	process {
		$msg = @{
			MessageData = ($message.MonkeyGenericTaskMessage -f $pluginId,"Azure Containers",$O365Object.current_subscription.displayName);
			callStack = (Get-PSCallStack | Select-Object -First 1);
			logLevel = 'info';
			InformationAction = $InformationAction;
			Tags = @('AzureContainerInfo');
		}
		Write-Information @msg
		#Get all containers registries
		if ($container_groups) {
			foreach ($container in $container_groups) {
				$URI = ("{0}{1}?api-version={2}" `
 						-f $O365Object.Environment.ResourceManager,$container.id,$cntAPI.api_version)
				#launch request
				$params = @{
					Authentication = $rm_auth;
					OwnQuery = $URI;
					Environment = $Environment;
					ContentType = 'application/json';
					Method = "GET";
				}
				$my_container = Get-MonkeyRMObject @params
				if ($my_container) {
					#Add container registries to array
					$all_containers += $my_container
				}
			}
		}
	}
	end {
		if ($all_containers) {
			$all_containers.PSObject.TypeNames.Insert(0,'Monkey365.Azure.Containers')
			[pscustomobject]$obj = @{
				Data = $all_containers;
				Metadata = $monkey_metadata;
			}
			$returnData.az_containers = $obj
		}
		else {
			$msg = @{
				MessageData = ($message.MonkeyEmptyResponseMessage -f "Azure Containers",$O365Object.TenantID);
				callStack = (Get-PSCallStack | Select-Object -First 1);
				logLevel = 'warning';
				InformationAction = $InformationAction;
				Tags = @('AzureContainersEmptyResponse');
			}
			Write-Warning @msg
		}
	}
}
