// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import  ballerina/http;
import  ballerina/url;
import  ballerina/lang.'string;

# API key configuration
#
# + apiKeys - Unique API key obtained from Abstract API to access IP Geolocation API. 
#             Provide in following format in the example. Eg: `{"api_key" : "<API KEY>"}`
public type ApiKeysConfig record {
    map<string> apiKeys;
};

# Abstract IP geolocation API allows developers to retrieve the region, country and city behind any IP worldwide. The API covers the geolocation of IPv4 and IPv6 addresses in 180+ countries worldwide. Extra information can be retrieved like the currency, flag or language associated to an IP.
#
# + clientEp - Connector http endpoint
public client class Client {
    http:Client clientEp;
    map<string> apiKeys;
    # Client initialization.
    #
    # + apiKeyConfig - API key configuration detail
    # + clientConfig - Client configuration details
    # + serviceUrl - Connector server URL
    # + return - Error at failure of client initialization
    public isolated function init(ApiKeysConfig apiKeyConfig, http:ClientConfiguration clientConfig =  {}, string serviceUrl = "https://ipgeolocation.abstractapi.com") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        self.apiKeys = apiKeyConfig.apiKeys;
    }
    # Retrieve the location of an IP address
    #
    # + ipAddress - The IP address to geolocate. Both IPv4 and IPv6 addresses are supported. Note that if this parameter is left blank, the service will geolocate the IP address from which the request was made.
    # + fields - Comma separated fields to only receive a few fields from the JSON response.
    # + return - Location of geolocated IP
    remote isolated function getGeolocation(string? ipAddress = (), string? fields = ()) returns Geolocation|error {
        string  path = string `/v1/`;
        map<anydata> queryParam = {"ip_address": ipAddress, "fields": fields, api_key: self.apiKeys["api_key"]};
        path = path + check getPathForQueryParam(queryParam);
        Geolocation response = check self.clientEp-> get(path, targetType = Geolocation);
        return response;
    }
}

# Generate query path with query parameter.
#
# + queryParam - Query parameter map
# + return - Generated Path at success or error at failure of client initialization
isolated function  getPathForQueryParam(map<anydata>   queryParam)  returns  string|error {
    string[] param = [];
    param[param.length()] = "?";
    foreach  var [key, value] in  queryParam.entries() {
        if  value  is  () {
            _ = queryParam.remove(key);
        } else {
            if  string:startsWith( key, "'") {
                 param[param.length()] = string:substring(key, 1, key.length());
            } else {
                param[param.length()] = key;
            }
            param[param.length()] = "=";
            if  value  is  string {
                string updateV =  check url:encode(value, "UTF-8");
                param[param.length()] = updateV;
            } else {
                param[param.length()] = value.toString();
            }
            param[param.length()] = "&";
        }
    }
    _ = param.remove(param.length()-1);
    if  param.length() ==  1 {
        _ = param.remove(0);
    }
    string restOfPath = string:'join("", ...param);
    return restOfPath;
}
