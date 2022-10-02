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


function Get-MonkeyAZInsight {
<#
        .SYNOPSIS
		Azure plugin to get Insights for every single resource group

        .DESCRIPTION
		Azure plugin to get Insights for every single resource group

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .NOTES
	        Author		: Juan Garrido
            Twitter		: @tr1ana
            File Name	: Get-MonkeyAZInsight
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
			Id = "az00027";
			Provider = "Azure";
			Title = "Plugin to get Insights for Azure resource groups";
			Group = @("Subscription");
			ServiceName = "Azure Insights";
			PluginName = "Get-MonkeyAZInsight";
			Docs = "https://silverhack.github.io/monkey365/"
		}
		#Import Localized data
		$LocalizedDataParams = $O365Object.LocalizedDataParams
		Import-LocalizedData @LocalizedDataParams;
		#Get Environment
		$Environment = $O365Object.Environment
		#Get Azure RM Auth
		$rm_auth = $O365Object.auth_tokens.ResourceManager
		#Set array
		$all_alerts = @();
	}
	process {
		$msg = @{
			MessageData = ($message.MonkeyGenericTaskMessage -f $pluginId,"Azure Insights",$O365Object.current_subscription.displayName);
			callStack = (Get-PSCallStack | Select-Object -First 1);
			logLevel = 'info';
			InformationAction = $InformationAction;
			Tags = @('AzureInsightsInfo');
		}
		Write-Information @msg
		$URI = ("{0}{1}/providers/microsoft.insights/activityLogAlerts?api-Version={2}" `
 				-f $O365Object.Environment.ResourceManager,$O365Object.current_subscription.id,'2020-10-01')

		$params = @{
			Authentication = $rm_auth;
			OwnQuery = $URI;
			Environment = $Environment;
			ContentType = 'application/json';
			Method = "GET";
		}
		$configured_alerts = Get-MonkeyRMObject @params
		foreach ($configured_alert in $configured_alerts) {
			#Try to get operationName
			$operation_name = $configured_alert.Properties.condition.allOf | Where-Object { $_.field -eq 'operationName' } | Select-Object -ExpandProperty equals
			#Get category
			$category_name = $configured_alert.Properties.condition.allOf | Where-Object { $_.field -eq 'category' } | Select-Object -ExpandProperty equals
			$new_alert = New-Object -TypeName PSCustomObject
			$new_alert | Add-Member -Type NoteProperty -Name id -Value $configured_alert.id
			$new_alert | Add-Member -Type NoteProperty -Name name -Value $configured_alert.Name
			$new_alert | Add-Member -Type NoteProperty -Name properties -Value $configured_alert.Properties
			$new_alert | Add-Member -Type NoteProperty -Name description -Value $configured_alert.Properties.description
			$new_alert | Add-Member -Type NoteProperty -Name location -Value $configured_alert.location
			$new_alert | Add-Member -Type NoteProperty -Name scopes -Value (@($configured_alert.Properties.scopes) -join ',')
			$new_alert | Add-Member -Type NoteProperty -Name operationName -Value $operation_name
			$new_alert | Add-Member -Type NoteProperty -Name categoryName -Value $category_name
			$new_alert | Add-Member -Type NoteProperty -Name enabled -Value $configured_alert.Properties.enabled
			$new_alert | Add-Member -Type NoteProperty -Name rawObject -Value $configured_alert
			$all_alerts += $new_alert
		}
		#mock data if not alerts were created
		if ($all_alerts.Count -eq 0) {
			$mock_alert = [ordered]@{
				id = 0;
				Name = 'Monkey alert';
				Properties = $null;
				description = 'Mock alert';
			}
			$all_alerts += New-Object PSObject -Property $mock_alert
		}
	}
	end {
		if ($all_alerts) {
			$all_alerts.PSObject.TypeNames.Insert(0,'Monkey365.Azure.insights.alerts')
			[pscustomobject]$obj = @{
				Data = $all_alerts;
				Metadata = $monkey_metadata;
			}
			$returnData.az_monitor_alerts = $obj
		}
		else {
			$msg = @{
				MessageData = ($message.MonkeyEmptyResponseMessage -f "Azure Insights",$O365Object.TenantID);
				callStack = (Get-PSCallStack | Select-Object -First 1);
				logLevel = 'warning';
				InformationAction = $InformationAction;
				Tags = @('AzureInsightsEmptyResponse');
			}
			Write-Warning @msg
		}
	}
}
