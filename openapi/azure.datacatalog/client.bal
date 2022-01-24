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

import ballerina/http;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
public type ClientConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig auth;
    # The HTTP version understood by the client
    string httpVersion = "1.1";
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects? followRedirects = ();
    # Configurations associated with request pooling
    http:PoolConfiguration? poolConfig = ();
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig? circuitBreaker = ();
    # Configurations associated with retrying
    http:RetryConfig? retryConfig = ();
    # Configurations associated with cookies
    http:CookieConfig? cookieConfig = ();
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket? secureSocket = ();
|};

# The Azure Data Catalog Resource Provider Services API.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + clientConfig - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ClientConfig clientConfig, string serviceUrl = "https://management.azure.com/") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Lists all the available Azure Data Catalog service operations.
    #
    # + apiVersion - Client Api Version. 
    # + return - HTTP 200 (OK) if the operation was successful. 
    remote isolated function adcoperationsList(string apiVersion) returns OperationEntityListResult|error {
        string resourcePath = string `/providers/Microsoft.DataCatalog/operations`;
        map<anydata> queryParam = {"api-version": apiVersion};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OperationEntityListResult response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List catalogs in Resource Group (GET Resources)
    #
    # + apiVersion - Client Api Version. 
    # + subscriptionId - Gets subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call. 
    # + resourceGroupName - The name of the resource group within the user's subscription. The name is case insensitive. 
    # + return - HTTP 200 (OK) if the operation was successful. 
    remote isolated function adccatalogsListtbyresourcegroup(string apiVersion, string subscriptionId, string resourceGroupName) returns ADCCatalogsListResult|error {
        string resourcePath = string `/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.DataCatalog/catalogs`;
        map<anydata> queryParam = {"api-version": apiVersion};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ADCCatalogsListResult response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get Azure Data Catalog service (GET Resources)
    #
    # + apiVersion - Client Api Version. 
    # + subscriptionId - Gets subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call. 
    # + resourceGroupName - The name of the resource group within the user's subscription. The name is case insensitive. 
    # + catalogName - The name of the data catalog in the specified subscription and resource group. 
    # + return - HTTP 200 (OK) if the operation was successful. 
    remote isolated function adccatalogsGet(string apiVersion, string subscriptionId, string resourceGroupName, string catalogName) returns ADCCatalog|error {
        string resourcePath = string `/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.DataCatalog/catalogs/${catalogName}`;
        map<anydata> queryParam = {"api-version": apiVersion};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ADCCatalog response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create or Update Azure Data Catalog service (PUT Resource)
    #
    # + apiVersion - Client Api Version. 
    # + subscriptionId - Gets subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call. 
    # + resourceGroupName - The name of the resource group within the user's subscription. The name is case insensitive. 
    # + catalogName - The name of the data catalog in the specified subscription and resource group. 
    # + payload - Properties supplied to the Create or Update a data catalog. 
    # + return - HTTP 200 (OK) if the operation was successful. 
    remote isolated function adccatalogsCreateorupdate(string apiVersion, string subscriptionId, string resourceGroupName, string catalogName, ADCCatalog payload) returns ADCCatalog|error {
        string resourcePath = string `/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.DataCatalog/catalogs/${catalogName}`;
        map<anydata> queryParam = {"api-version": apiVersion};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ADCCatalog response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete Azure Data Catalog Service (DELETE Resource)
    #
    # + apiVersion - Client Api Version. 
    # + subscriptionId - Gets subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call. 
    # + resourceGroupName - The name of the resource group within the user's subscription. The name is case insensitive. 
    # + catalogName - The name of the data catalog in the specified subscription and resource group. 
    # + return - OK. An existing annotation was updated. 
    remote isolated function adccatalogsDelete(string apiVersion, string subscriptionId, string resourceGroupName, string catalogName) returns http:Response|error {
        string resourcePath = string `/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.DataCatalog/catalogs/${catalogName}`;
        map<anydata> queryParam = {"api-version": apiVersion};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Update Azure Data Catalog Service (PATCH Resource)
    #
    # + apiVersion - Client Api Version. 
    # + subscriptionId - Gets subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call. 
    # + resourceGroupName - The name of the resource group within the user's subscription. The name is case insensitive. 
    # + catalogName - The name of the data catalog in the specified subscription and resource group. 
    # + payload - Properties supplied to the Update a data catalog. 
    # + return - HTTP 200 (OK) if the operation was successful. 
    remote isolated function adccatalogsUpdate(string apiVersion, string subscriptionId, string resourceGroupName, string catalogName, ADCCatalog payload) returns ADCCatalog|error {
        string resourcePath = string `/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.DataCatalog/catalogs/${catalogName}`;
        map<anydata> queryParam = {"api-version": apiVersion};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ADCCatalog response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
}
