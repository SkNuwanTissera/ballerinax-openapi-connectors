// Copyright (c) 2022 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# An object that represents a set of mutable Analysis Services resource properties.
public type AnalysisServicesServerMutableProperties record {
    # An array of administrator user identities.
    ServerAdministrators asAdministrators?;
    # The SAS container URI to the backup container.
    string backupBlobContainerUri?;
    # The gateway details.
    GatewayDetails gatewayDetails?;
    # An array of firewall rules.
    IPv4FirewallSettings ipV4FirewallSettings?;
    # How the read-write server's participation in the query pool is controlled.<br/>It can have the following values: <ul><li>readOnly - indicates that the read-write server is intended not to participate in query operations</li><li>all - indicates that the read-write server can participate in query operations</li></ul>Specifying readOnly when capacity is 1 results in error.
    string querypoolConnectionMode?;
};

# The detail of firewall rule.
public type IPv4FirewallRule record {
    # The rule name.
    string firewallRuleName?;
    # The end range of IPv4.
    string rangeEnd?;
    # The start range of IPv4.
    string rangeStart?;
};

# An object that represents enumerating SKUs for new resources.
public type SkuEnumerationForNewResourceResult record {
    # The collection of available SKUs for new resources.
    ResourceSku[] value?;
};

# An array of firewall rules.
public type IPv4FirewallSettings record {
    # The indicator of enabling PBI service.
    boolean enablePowerBIService?;
    # An array of firewall rules.
    IPv4FirewallRule[] firewallRules?;
};

# Represents an instance of an Analysis Services resource.
public type Resource record {
    # An identifier that represents the Analysis Services resource.
    string id?;
    # Location of the Analysis Services resource.
    string location;
    # The name of the Analysis Services resource.
    string name?;
    # Represents the SKU name and Azure pricing tier for Analysis Services resource.
    ResourceSku sku;
    # Key-value pairs of additional resource provisioning properties.
    record {} tags?;
    # The type of the Analysis Services resource.
    string 'type?;
};

# Status of gateway is live.
public type GatewayListStatusLive record {
    # Live message of list gateway.
    string status?;
};

# A Consumption REST API operation.
public type Operation record {
    # The object that represents the operation.
    OperationDisplay display?;
    # Operation name: {provider}/{resource}/{operation}.
    string name?;
};

# The gateway details.
public type GatewayDetails record {
    # Uri of the DMTS cluster.
    string dmtsClusterUri?;
    # Gateway object id from in the DMTS cluster for the gateway resource.
    string gatewayObjectId?;
    # Gateway resource to be associated with the server.
    string gatewayResourceId?;
};

# The object that represents the operation.
public type OperationDisplay record {
    # Operation type: Read, write, delete, etc.
    string operation?;
    # Service provider: Microsoft.Consumption.
    string provider?;
    # Resource on which the operation is performed: UsageDetail, etc.
    string 'resource?;
};

# An object that represents SKU details for existing resources.
public type SkuDetailsForExistingResource record {
    # Represents the SKU name and Azure pricing tier for Analysis Services resource.
    ResourceSku sku?;
};

# Describes the format of Error response.
public type ErrorResponse record {
    # Error code
    string code?;
    # Error message indicating why the operation failed.
    string message?;
};

# Represents the SKU name and Azure pricing tier for Analysis Services resource.
public type ResourceSku record {
    # The number of instances in the read only query pool.
    int capacity?;
    # Name of the SKU level.
    string name;
    # The name of the Azure pricing tier to which the SKU applies.
    string tier?;
};

# An object that represents enumerating SKUs for existing resources.
public type SkuEnumerationForExistingResourceResult record {
    # The collection of available SKUs for existing resources.
    SkuDetailsForExistingResource[] value?;
};

# The checking result of server name availability.
public type CheckServerNameAvailabilityResult record {
    # The detailed message of the request unavailability.
    string message?;
    # Indicator of available of the server name.
    boolean nameAvailable?;
    # The reason of unavailability.
    string reason?;
};

# Represents an instance of an Analysis Services resource.
public type AnalysisServicesServer record {
    *Resource;
};

# Details of server name request body.
public type CheckServerNameAvailabilityParameters record {
    # Name for checking availability.
    string name?;
    # The resource type of azure analysis services.
    string 'type?;
};

# An array of Analysis Services resources.
public type AnalysisServicesServers record {
    # An array of Analysis Services resources.
    AnalysisServicesServer[] value;
};

# The status of operation.
public type OperationStatus record {
    # The end time of the operation.
    string endTime?;
    # Describes the format of Error response.
    ErrorResponse _error?;
    # The operation Id.
    string id?;
    # The operation name.
    string name?;
    # The start time of the operation.
    string startTime?;
    # The status of the operation.
    string status?;
};

# Properties of Analysis Services resource.
public type AnalysisServicesServerProperties record {
    *AnalysisServicesServerMutableProperties;
};

# Provision request specification
public type AnalysisServicesServerUpdateParameters record {
    # An object that represents a set of mutable Analysis Services resource properties.
    AnalysisServicesServerMutableProperties properties?;
    # Represents the SKU name and Azure pricing tier for Analysis Services resource.
    ResourceSku sku?;
    # Key-value pairs of additional provisioning properties.
    record {} tags?;
};

# Result of listing consumption operations. It contains a list of operations and a URL link to get the next set of results.
public type OperationListResult record {
    # URL to get the next set of operation list results if there are any.
    string nextLink?;
    # List of analysis services operations supported by the Microsoft.AnalysisServices resource provider.
    Operation[] value?;
};

# Detail of gateway errors.
public type GatewayError record {
    # Error code of list gateway.
    string code?;
    # Error message of list gateway.
    string message?;
};

# An array of administrator user identities.
public type ServerAdministrators record {
    # An array of administrator user identities.
    string[] members?;
};

# Status of gateway is error.
public type GatewayListStatusError record {
    # Detail of gateway errors.
    GatewayError _error?;
};
