﻿# en-US
ConvertFrom-StringData @'
GraphV2ErrorMessage              = Identity was not granted permissions to access Microsoft Graph
EntraIDTenantNameError           = Unable to get Tenant name
MonkeyObjectCreationFailed       = Unable to create {0} object
AcquireLockMessage               = Thread {0} is requesting lock
AcquireLockInfoMessage           = Thread {0} lock successfully requested
ReleaseLockMessage               = Thread {0} lock released
AzureSelectedSubscriptionInfo    = Suscription {0} was selected
AzureSubscriptionAllInfo         = Getting suscriptions from Azure
AzureSubscriptionPolicy          = Getting suscription policy from Azure
AzureSubscriptionInfo            = Getting information from {0} suscription
AzureSbsPolicyAssignment         = Getting policy assignment for {0} definition Id
AzureSbsPolicyAssignmentAll      = Getting policy assignments
AzureSbsPolicySetDefinitionAll   = Getting policy set definitions from Azure
AzureSbsPolicySetDefinition      = Getting {0} policy set definitions from Azure
EntraIDSelectedTenantInfo        = Tenant {0} was selected
AzureConsoleBadInputError        = Bad input received. Please type only a valid number from the [ID] column
EntraIDServicePrincipalInfo      = Getting service principal {0} from Microsoft Entra ID
EntraIDServicePrincipalAllInfo   = Getting service principals from Microsoft Entra ID
EntraIDServicePrincipalPermInfo  = Getting permissions for service principal {0}
EntraIDApplicationInfo           = Getting application {0} from Microsoft Entra ID
EntraIDApplicationAllInfo        = Getting applications from Microsoft Entra ID
EntraIDAppPermissionInfo         = Getting permissions for application {0}
ExoMailBoxPermissionInfo         = Getting permissions for {0} mailbox
SuccessfullyConnected            = Successfully connected to Resource Management API
AdalUnsupportedOSErrorMessage    = Use of ADAL library is not supported on PowerShell core on {0}. Importing MSAL library
MSALGenericLibraryLoadMessage    = Loading MSAL authentication library
AADTenantInfoMessage             = Getting tenant information from {0} Id
AADUserErrorMessage              = Unable to set UserPrincipalName
AADEmptyTenantMessage            = Found empty tenantId in local settings. Setting TenantID to {0}
O365TenantInfoError              = Unable to get information from Tenant
RBACUserInfoError                = Unable to get RBAC information for {0}
AADRMServiceLocatorError         = Unable to resolve AADRM service locator
LyncDomainNotResolved            = The Lync discover domain could not be resolved
LyncFederatedDomainNotFound      = No federated domain was found on {0}
M365AADInfoError                 = Unable to get Microsoft Entra ID license information
M365ATPInfoError                 = Unable to get Advanced Threat Protection settings
M365LicenseInfoError             = Unable to get friendly name of SKU licenses
MonkeyInternalConfigError        = Unable to get configuration file
MonkeyProfileLoadError           = Unable to load profile
MonkeyParametersGenericError     = Unable to get parameters
MonkeyDefaultParametersLoad      = Loading default profile
MonkeyWrongParametersFound       = Wrong parameters were found: {0}
MonkeyProfileNotExists           = {0} does not exists
UnableToGetPlugins               = Unable to get plugins for {0}
TimeElapsedScript                = Total time for JOBs: {0} Minutes
UnableToCreateRunspacePool       = Unable to create runspace pool. Empty plugins loaded
RunspacePoolErrorMessage         = Unable to create runspace pool. The error was {0}
RunspacePoolError                = Unable to create runspace pool. Possible errors are invalid plugins or empty libraries
OpenRunspaceMessage              = Opening runspacePool
TimeSpentInvokeBatchMessage      = Time spent on Invoking Batch number {0}: {1}
TimeSpentCollectBatchMessage     = Time spent on Collecting Batch number {0}: {1}
SleepMessage                     = Sleeping for {0} Milliseconds
TerminateJobMessage              = Finishing the {0} job(s) that are still running
NullAuthenticationDetected       = Unable to connect to {0}. Null token detected
MonkeyGenericTaskMessage         = Task [{0}] - Getting {1} from {2}
GraphAPISwitchMessage            = Switching api version to 1.6-internal
MonkeyEmptyResponseMessage       = The {0} query did not return any data in {1} tenant
MonkeyResponseCountMessage       = The query returned {0} elements
SubscriptionWorkingMessage       = Working on {0}
AuthObjectErrorMessage           = Unable to update authentication object for {0}
RbacPermissionsMessage           = Getting RBAC permissions for {0} {1}
RbacUnknownPrincipalType         = Unable to get permissions for {0}. Unknown PrincipalType
UserPermissionsMessage           = Getting user permissions for {0}
RBACPermissionErrorMessage       = Unable to get permissions for {0}
RBACPermissionEmptyResponse      = Directory Role permissions were not found for {0}
RoleBasedPermissionsMessage      = Getting permissions for roleId {0}
RoleBasedGetUsersMessage         = Getting users from roleId {0}
GroupMessageInfo                 = A Group with objectId {0} was found. Getting users
GroupMemberErrorMessage          = Unable to get members for group object {0}
NestedGroupMessageInfo           = Found a group id {0} inside of {1}. Getting users
PotentialNestedGroupDetected     = Potential nested group with name {0} was detected inside of {1}
ResourceGroupsMessage            = Getting resource groups for subscription {0}
ResourceGroupNotFoundMessage     = Resource Group {0} was not found on {1} Azure subscription
AzureUnitResourceMessage         = Getting information from {0} {1}
AzureDatabasesQueryMessage       = Getting databases from {0}
AzureDbThreatDetectionMessage    = Getting Server Threat Detection Policy on {0}
ServerAuditPolicyMessage         = Getting server auditing policy on {0}
DatabaseServerTDEMessage         = Getting Transparent Data Encryption Status on {0}
NoClassicStorageAccounts         = No classic storage accounts were found in {0} tenant
StorageAccountFoundMessage       = Found storage {0} account in {1}
StorageObjectCreationFailed      = Unable to create Monkey storage object
DatabaseObjectCreationFailed     = Unable to create Monkey database object
SecurityBaselineENotFoundMessage = Security baseline table was not found for {0}
WorkSpaceIdNotFoundMessage       = Security baseline table was not found for {0}
UnableToCreateQuery              = Unable to create query for {0}
WorkSpaceIdNotFound              = It seems that workspace was not configured for {0} virtual machine
GroupMembersMessage              = Getting group members for {0}
PotentialNestedGroupMessage      = Found a potential nested group name {0} inside of {1}
GroupWithRoleMessage             = Group {0} with a role of {1} was found
SubscriptionResourcesMessage     = Getting resources on {0}
ConvertObjectErrorMessage        = Unable to clone Object
UnableToCreateMonkeyObject       = Unable to create Monkey object
NewFolderMessage                 = New directory created in {0}
UnableToCreateDirectory          = Failed to create new directory on {0}
ExportDataToInfo                 = Exporting {0} to {1} format
MetadataInfoMessage              = Metadata object was successfully generated for {0} instance
ProjectDirectoryInfoMessage      = A new directory was successfully created on {0}
SaveDataToInfoMessage            = Saving output to {0}
UnableToExport                   = Unable to export {0} Object to {0} format
SharedAccessUri                  = Getting new Shared Access Uri for {0}
SchemeNotSupported               = Url scheme is not supported. The Url {0} must start with a scheme such as https://
ObjectIdMessageInfo              = Getting {0} information from {1}
EmptyAccessTokensErrorMessage    = Access tokens were not found
StopMonkeyWatcher                = Stopping jobs and access token watcher
MonkeyWatcherAlreadyRunning      = A watcher is already running
RestartMonkeyWatchter            = Restarting monkey watcher
StartMonkeyWatcher               = Starting monkey watcher
MonkeyWatcherStartSuccess        = Monkey watcher has started
MonkeyWatcherErrorMessage        = Monkey watcher has failed
MonkeyWatcherSleepMessage        = Sleeping Monkey watcher before checking access tokens
MonkeyWatcherRefreshTokenMessage = Successfully refreshed token for {0}
CloseToExpireTokenMessage		 = Access token for {0} will expire in {1} minutes. Obtaining a new access token using refresh token
ExpiredAccessTokenMessage		 = Access Token expired for {0}. Obtaining a new access token using refresh token
UnableToGetAccessToken           = Unable to get a new access token for {0}
TokenIsStillValidMessage         = Token issued for {0} resource looks good
PsSessionIsStillValidMessage     = PsSession for {0} looks good
RefreshTokenMessage              = Refreshing token for {0} using {1} library
NoPsSessionWasFound              = Unable to get {0}. No PsSession was found
O365ATPNotDetected               = Advanced Threat Detection not detected on {0} tenant
O365JobFailedReason              = The reason was {0}
O365JobFailed                    = The job {0} has failed
O365JobError                     = The error was {0}
O365JobCompletedWithError        = Job {0} was completed with errors
O365JobCompleted                 = Job {0} is completed
O365JobCompletedWithoutError     = Job {0} is completed without errors
O365JobStatus                    = Job {0} is still running
ClosingRemoteSession             = Closing remote session to {0}
SecureScoreMessage               = Getting Secure Score from Microsoft Graph
SharepointSubSitesMessage        = Getting subsites for {0}
SPSObjectErrorMessage            = Unable to get object type
UnableToSitePropertiesForUser    = Unable to get site properties using {0} account
GetSitesUsingSharePointSearchApi = Getting sites using SharePoint search api
UnableToGetSubsites              = Unable to get sub sites for {0}
UnableToProcessQuery             = Unable to process query on {0}
SPSDetailedErrorMessage          = {0}
SPSAdminErrorMessage             = User {0} does not have permission to access SharePoint Online
SPSConfidentialAppErrorMessage   = Confidential application with application secret is not allowed to access SharePoint Online
SPSCheckSiteForExternalUsers     = Searching for external users on {0}
SPSCheckSiteForOrphanedObjects   = Searching for orphaned objects on {0}
SPSCheckSiteAccessRequests       = Getting site access requests of site: {0}
SPSPermissionInfoMessage         = Getting permissions for {0} {1}
SPSInheritedPermissionInfo       = Getting inherited permissions for {0} {1}
SPSGetListsForWeb                = Getting lists from {0} site
SPSGetSharingInfoForItem         = Getting sharing info of {0} item
SPSGetPermissions                = Getting permissions on {0}
SPSScanningMessage               = Getting {0} on {1}
GenericWorkingMessage            = Working on {0} {1}
SPSWorkingMessage                = Working on {0} {1}
SPSGetObjectMessage              = Getting {0} on {1}
SPSFolderMessage                 = Working on {0} folder
SPSCastObjectMessage             = Found {0} object
SPSInheritedPermsMessage         = Getting inherited permissions on {0}
SPSUniquePermsMessage            = Found unique permissions on {0}
LoggerError                      = Unable to start Monkey logger
ReusePortErrorMessage            = Unable to set ReusePort property
AzureSubscriptionNotFound        = No Azure subscription was found on {0}
AzureSubscriptionError           = Azure subscription {0} is expired or cancelled. Subscription status is {1}
ClassicAdminsInfoMessage         = Getting classic administrators from {0}
ClassicAdminsWarningMessage      = Unable to get classic administrators
RoleAssignmentIdInfoMessage      = Getting information for roleId {0}
RoleAssignmentInfoMessage        = Getting role assignments from {0} subscription
RoleAssignmentWarningMessage     = Unable to get role assignments from {0} subscription
AzureOrphanedIdentityMessage     = Identity {0} was not found in {1} subscription
UnknownError                     = Unknown error. Probably runspace state was either broken, or closed
RunspaceError                    = Runspace state was not opened
ConditionalAccessEmptyMessage    = One or more specified conditional access policies were not found
ConditionalAccessErrorMessage    = Unable to get conditional access policies
PowerBIBackendError              = Unable to get PowerBI backend for {0} tenant
SecCompBackendError              = Unable to get Security & Compliance backend Url for {0} tenant
SuccessfullyConnectedTo          = Successfully connected to {0}
TokenRequestInfoMessage          = Acquiring a new token for {0}
TokenAcquiredInfoMessage         = A new token was successfully acquired for {0}
AADAppPermissionObjectError      = Unable to create application permission object for {0}
SPOPermissionObjectError         = Unable to create SharePoint permission object for {0}
SPOEmptyRoleAssignmentMessage    = Empty role assignment was found for {0}
SPOInvalidWebObjectMessage       = Invalid Web object
SPOInvalidSiteObjectMessage      = Invalid Site object
SPOInvalidObjectMessage          = Invalid object
MSGraphDirectoryObjectError      = Unable to get directory objects
NotConnectedTo                   = Not connected to {0}
SPNotAllowedAuthFlowErrorMessage = Service principal authentication flow is not supported for {0}
CompressingJob                   = Compressing Monkey data into {0}
TokenAcquiredGenericMessage      = A new token was successfully acquired
'@;