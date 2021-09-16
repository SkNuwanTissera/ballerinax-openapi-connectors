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

import ballerina/http;
import ballerina/xmldata;
import ballerina/url;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
public type ClientConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig|http:CredentialsConfig auth;
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

# Documentum REST, Copyright 2020 Open Text corporation.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + clientConfig - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ClientConfig clientConfig, string serviceUrl) returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }
    # Get the repositories
    #
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getRepositories(boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories`;
        map<anydata> queryParam = {"inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the repository
    #
    # + repositoryName - The repository name. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + includeDomains - Whether include domains. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getRepository(string repositoryName, boolean links = true, string includeDomains = "false", string? accept = ()) returns Repository|error {
        string  path = string `/repositories/${repositoryName}`;
        map<anydata> queryParam = {"links": links, "include-domains": includeDomains};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Repository response = check self.clientEp-> get(path, accHeaders, targetType = Repository);
        return response;
    }
    # Get the acls
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAcls(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/acls`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the acl
    #
    # + repositoryName - The repository name. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createAcl(string repositoryName, AclBase payload, string? accept = (), string? contentType = ()) returns Acl|error {
        string  path = string `/repositories/${repositoryName}/acls`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Acl response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Acl);
        return response;
    }
    # Get the acl
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAcl(string repositoryName, string objectId, string view = ":default", boolean links = true, string? accept = ()) returns Acl|error {
        string  path = string `/repositories/${repositoryName}/acls/${objectId}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Acl response = check self.clientEp-> get(path, accHeaders, targetType = Acl);
        return response;
    }
    # Update the acl
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateAcl(string repositoryName, string objectId, AclBase payload, string? accept = (), string? contentType = ()) returns Acl|error {
        string  path = string `/repositories/${repositoryName}/acls/${objectId}`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Acl response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Acl);
        return response;
    }
    # Delete the acl
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + force - Indicates whether to destroy the ACL object even if it is referenced by other objects in the repository. * 'true', would destroy the ACL object even if it is referenced by other objects in the repository. * 'false', do not destroy the ACL object if it is referenced by other objects. 
    # + return - Operation successfully 
    remote isolated function deleteAcl(string repositoryName, string objectId, string? force = ()) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/acls/${objectId}`;
        map<anydata> queryParam = {"force": force};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the aclAssociations
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAclAssociations(string repositoryName, string objectId, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/acls/${objectId}/associations`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the archivedContents
    #
    # + repositoryName - The repository name. 
    # + objectIdQueryParam - The r_object_id of required sysobject. 
    # + includeChildren - Specifies whether to get its child nodes' contents for a virtual document. * 'true', would include its child nodes' contents. * 'false', do not include its child nodes' contents, means only get this root node's contents. 
    # + bindingLabel - Specifies the version label to use to resolve late bound nodes for a virtual document. 
    # + includeBroken - Specifies whether to include nodes with broken bindings for a virtual document. * 'true', would include nodes with broken bindings with current version. * 'false', do not include nodes with broken bindings. 
    # + depth - Specifies to what depth level the virtual document hierarchy will be returned. -1 means return the whole virtual document tree. 
    # + format - The format of the content uploaded. 
    # + return - Operation successfully 
    remote isolated function getArchivedContents(string repositoryName, string? objectIdQueryParam = (), string includeChildren = "false", string bindingLabel = "CURRENT", string includeBroken = "false", int depth = 1, string? format = ()) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/archived-contents`;
        map<anydata> queryParam = {"object-id-query-param": objectIdQueryParam, "include-children": includeChildren, "binding-label": bindingLabel, "include-broken": includeBroken, "depth": depth, "format": format};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> get(path, targetType = http:Response);
        return response;
    }
    # Update the archivedContent
    #
    # + repositoryName - The repository name. 
    # + allContents - Specifies whether to include all contents of an object or only get the first page contents. * 'true', would include all contents of the specified objects. * 'false', would only include the first page contents of the specified objects. 
    # + format - The format of the content uploaded. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateArchivedContent(string repositoryName, ArchivedContentsBase payload, string allContents = "false", string? format = (), string? contentType = ()) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/archived-contents`;
        map<anydata> queryParam = {"all-contents": allContents, "format": format};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        http:Response response = check self.clientEp->post(path, request, headers = accHeaders, targetType=http:Response);
        return response;
    }
    # Get the aspectTypes
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAspectTypes(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/aspect-types`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the aspectType
    #
    # + repositoryName - The repository name. 
    # + aspectTypeName - The name of the aspect type. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + locale - The locale name. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAspectType(string repositoryName, string aspectTypeName, string view = ":default", boolean links = true, string? locale = (), string? accept = ()) returns AspectType|error {
        string  path = string `/repositories/${repositoryName}/aspect-types/${aspectTypeName}`;
        map<anydata> queryParam = {"view": view, "links": links, "locale": locale};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        AspectType response = check self.clientEp-> get(path, accHeaders, targetType = AspectType);
        return response;
    }
    # Get the auditPolicies
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAuditPolicies(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/audit-policies`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the auditPolicy
    #
    # + repositoryName - The repository name. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createAuditPolicy(string repositoryName, AuditPolicyBase payload, string view = ":default", boolean links = true, string? accept = (), string? contentType = ()) returns AuditPolicy|error {
        string  path = string `/repositories/${repositoryName}/audit-policies`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        AuditPolicy response = check self.clientEp->post(path, request, headers = accHeaders, targetType=AuditPolicy);
        return response;
    }
    # Get the auditPolicy
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAuditPolicy(string repositoryName, string id, string view = ":default", boolean links = true, string? accept = ()) returns AuditPolicy|error {
        string  path = string `/repositories/${repositoryName}/audit-policies/${id}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        AuditPolicy response = check self.clientEp-> get(path, accHeaders, targetType = AuditPolicy);
        return response;
    }
    # Update the auditPolicy
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateAuditPolicy(string repositoryName, string id, AuditPolicyBase payload, string view = ":default", boolean links = true, string? accept = (), string? contentType = ()) returns AuditPolicy|error {
        string  path = string `/repositories/${repositoryName}/audit-policies/${id}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        AuditPolicy response = check self.clientEp->post(path, request, headers = accHeaders, targetType=AuditPolicy);
        return response;
    }
    # Delete the auditPolicy
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + return - Operation successfully 
    remote isolated function deleteAuditPolicy(string repositoryName, string id) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/audit-policies/${id}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the auditTrails
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAuditTrails(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/audit-trails`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the auditTrail
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAuditTrail(string repositoryName, string id, string view = ":default", boolean links = true, string? accept = ()) returns AuditTrail|error {
        string  path = string `/repositories/${repositoryName}/audit-trails/${id}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        AuditTrail response = check self.clientEp-> get(path, accHeaders, targetType = AuditTrail);
        return response;
    }
    # Delete the auditTrail
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + trace - Whether make the audit trail traceable when purging it. 
    # + return - Operation successfully 
    remote isolated function deleteAuditTrail(string repositoryName, string id, string trace = "false") returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/audit-trails/${id}`;
        map<anydata> queryParam = {"trace": trace};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the availableAuditEvents
    #
    # + repositoryName - The repository name. 
    # + objectIdQueryParam - The r_object_id of required sysobject. 
    # + objectType - The type of the queried object. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAvailableAuditEvents(string repositoryName, string? objectIdQueryParam = (), string? objectType = (), boolean links = true, string? accept = ()) returns AuditEventList|error {
        string  path = string `/repositories/${repositoryName}/available-audit-events`;
        map<anydata> queryParam = {"object-id-query-param": objectIdQueryParam, "object-type": objectType, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        AuditEventList response = check self.clientEp-> get(path, accHeaders, targetType = AuditEventList);
        return response;
    }
    # Get the batchCapabilities
    #
    # + repositoryName - The repository name. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getBatchCapabilities(string repositoryName, boolean links = true, string? accept = ()) returns BatchCapabilities|error {
        string  path = string `/repositories/${repositoryName}/batch-capabilities`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        BatchCapabilities response = check self.clientEp-> get(path, accHeaders, targetType = BatchCapabilities);
        return response;
    }
    # Update the batch
    #
    # + repositoryName - The repository name. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateBatch(string repositoryName, Body payload, string? accept = (), string? contentType = ()) returns BatchResponse|error {
        string  path = string `/repositories/${repositoryName}/batches`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        BatchResponse response = check self.clientEp->post(path, request, headers = accHeaders, targetType=BatchResponse);
        return response;
    }
    # Get the cabinets
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + objectType - The type of the queried object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getCabinets(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? objectType = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/cabinets`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "object-type": objectType};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the cabinet
    #
    # + repositoryName - The repository name. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createCabinet(string repositoryName, CabinetBase payload, string? accept = (), string? contentType = ()) returns Cabinet|error {
        string  path = string `/repositories/${repositoryName}/cabinets`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Cabinet response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Cabinet);
        return response;
    }
    # Get the cabinet
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + checkSubscription - Ensures whether to show subscriptions on the object instance. * 'true', return subscriptions on the object instance. * 'false', do not return subscriptions on the object instance. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getCabinet(string repositoryName, string id, string view = ":default", boolean links = true, string checkSubscription = "false", string? accept = ()) returns Cabinet|error {
        string  path = string `/repositories/${repositoryName}/cabinets/${id}`;
        map<anydata> queryParam = {"view": view, "links": links, "check-subscription": checkSubscription};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Cabinet response = check self.clientEp-> get(path, accHeaders, targetType = Cabinet);
        return response;
    }
    # Update the cabinet
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateCabinet(string repositoryName, string id, CabinetBase payload, string? accept = (), string? contentType = ()) returns Cabinet|error {
        string  path = string `/repositories/${repositoryName}/cabinets/${id}`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Cabinet response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Cabinet);
        return response;
    }
    # Delete the cabinet
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + delNonEmpty - Ensures whether to delete the folder instance when it is not empty. * 'true', would delete the folder and all of its descendants. * 'false', would not delete the folder instance only. 
    # + delAllLinks - Ensures whether to unlink the links on folder instance and all its descendants when deleted. * 'true', would delete the folder and all descendants, regardless of other folders into which they are linked * 'false', would unlink folder descendants from the folder being deleted if the folder descendants have links to other folders, and to remove folder descendants that are only linked to the folder being deleted. 
    # + return - Operation successfully 
    remote isolated function deleteCabinet(string repositoryName, string id, string? delNonEmpty = (), string? delAllLinks = ()) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/cabinets/${id}`;
        map<anydata> queryParam = {"del-non-empty": delNonEmpty, "del-all-links": delAllLinks};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the wordSuggestions
    #
    # + repositoryName - The repository name. 
    # + word - The word that needs to be passed to CCE(Contextual Content Engine) to check. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + suggestionView - The suggestion view for the word to be checked in CCE(Contextual Content Engine). * 'typeahead' or do not provide, would give typeahead results of given word. * 'homophone', would give homophone results of given word. * 'all', would give both typeahead and homophone results of given word. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWordSuggestions(string repositoryName, string word, int itemsPerPage = 100, int page = 1, boolean links = true, string suggestionView = "typeahead", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/cce/suggestions`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "links": links, "suggestion-view": suggestionView, "word": word};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the synonymCategories
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSynonymCategories(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/cce/synonym-categories`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the synonyms
    #
    # + repositoryName - The repository name. 
    # + word - The word that needs to be passed to CCE(Contextual Content Engine) to check. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + category - The category in Synonyms built-in dictionary of CCE(Contextual Content Engine) to search for word. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSynonyms(string repositoryName, string word, int itemsPerPage = 100, int page = 1, boolean links = true, string? category = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/cce/synonyms`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "links": links, "category": category, "word": word};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the checkedOutObjects
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + checkedOutBy - Specifies the lock owner of the checked out objects with the following valid values 
    # + userName - Specifies the user name of the lock owner. Only works when the checked-out-by parameter is set to specific-user 
    # + includeAllVersions - Whether include all versions 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getCheckedOutObjects(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string checkedOutBy = "current-user", string? userName = (), string includeAllVersions = "false", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/checked-out-objects`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "checked-out-by": checkedOutBy, "user-name": userName, "include-all-versions": includeAllVersions};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the currentUser
    #
    # + repositoryName - The repository name. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getCurrentUser(string repositoryName, string view = ":default", boolean links = true, string? accept = ()) returns User|error {
        string  path = string `/repositories/${repositoryName}/currentuser`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        User response = check self.clientEp-> get(path, accHeaders, targetType = User);
        return response;
    }
    # Get the currentUserPreferences
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getCurrentUserPreferences(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/currentuser-preferences`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the currentUserPreference
    #
    # + repositoryName - The repository name. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createCurrentUserPreference(string repositoryName, PreferenceBase payload, string? accept = (), string? contentType = ()) returns Preference|error {
        string  path = string `/repositories/${repositoryName}/currentuser-preferences`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Preference response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Preference);
        return response;
    }
    # Get the currentUserPreference
    #
    # + repositoryName - The repository name. 
    # + clientCode - The client identification. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getCurrentUserPreference(string repositoryName, string clientCode, string view = ":default", boolean links = true, string? accept = ()) returns Preference|error {
        string  path = string `/repositories/${repositoryName}/currentuser-preferences/${clientCode}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Preference response = check self.clientEp-> get(path, accHeaders, targetType = Preference);
        return response;
    }
    # Update the currentUserPreference
    #
    # + repositoryName - The repository name. 
    # + clientCode - The client identification. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateCurrentUserPreference(string repositoryName, string clientCode, PreferenceBase payload, string view = ":default", boolean links = true, string? accept = (), string? contentType = ()) returns Preference|error {
        string  path = string `/repositories/${repositoryName}/currentuser-preferences/${clientCode}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Preference response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Preference);
        return response;
    }
    # Delete the currentUserPreference
    #
    # + repositoryName - The repository name. 
    # + clientCode - The client identification. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function deleteCurrentUserPreference(string repositoryName, string clientCode, string? accept = ()) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/currentuser-preferences/${clientCode}`;
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Response response = check self.clientEp-> delete(path, accHeaders, targetType = http:Response);
        return response;
    }
    # Get the document
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + checkSubscription - Ensures whether to show subscriptions on the object instance. * 'true', return subscriptions on the object instance. * 'false', do not return subscriptions on the object instance. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getDocument(string repositoryName, string id, string view = ":default", boolean links = true, string checkSubscription = "false", string? accept = ()) returns Document|error {
        string  path = string `/repositories/${repositoryName}/documents/${id}`;
        map<anydata> queryParam = {"view": view, "links": links, "check-subscription": checkSubscription};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Document response = check self.clientEp-> get(path, accHeaders, targetType = Document);
        return response;
    }
    # Update the document
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateDocument(string repositoryName, string id, DocumentBase payload, string? accept = (), string? contentType = ()) returns Document|error {
        string  path = string `/repositories/${repositoryName}/documents/${id}`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Document response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Document);
        return response;
    }
    # Delete the document
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + delVersion - Delete options for multi-version document object. * 'selected_version', delete selected version only. * 'non_used_versions', delete non used versions. * 'all_versions', delete all versions. 
    # + delVdAll - Whether remove the all the descendants if the object is virtual. 
    # + return - Operation successfully 
    remote isolated function deleteDocument(string repositoryName, string id, int? delVersion = (), string delVdAll = "false") returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/documents/${id}`;
        map<anydata> queryParam = {"del-version": delVersion, "del-vd-all": delVdAll};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the relatedDocs
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getRelatedDocs(string repositoryName, string id, int itemsPerPage = 100, int page = 1, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/documents/${id}/related-docs`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the relatedSme
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getRelatedSme(string repositoryName, string id, int itemsPerPage = 100, int page = 1, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/documents/${id}/related-sme`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the significantTerms
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + docIds - The r_object_id of the documents that needs to be checked with CCE(Contextual Content Engine). 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSignificantTerms(string repositoryName, string id, int itemsPerPage = 100, int page = 1, boolean links = true, string[]? docIds = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/documents/${id}/significant-terms`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "links": links, "doc-ids": docIds};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the folderChildDocuments
    #
    # + repositoryName - The repository name. 
    # + folderId - The r_object_id of queried folder. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + objectType - The type of the queried object. 
    # + includeAllVersions - Whether include all versions 
    # + hideSharedParent - Whether hide the shared parent of child folders. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getFolderChildDocuments(string repositoryName, string folderId, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? objectType = (), string includeAllVersions = "false", string hideSharedParent = "false", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/folders/${folderId}/documents`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "object-type": objectType, "include-all-versions": includeAllVersions, "hide-shared-parent": hideSharedParent};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the folderChildFolders
    #
    # + repositoryName - The repository name. 
    # + folderId - The r_object_id of queried folder. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + objectType - The type of the queried object. 
    # + hideSharedParent - Whether hide the shared parent of child folders. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getFolderChildFolders(string repositoryName, string folderId, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? objectType = (), string hideSharedParent = "false", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/folders/${folderId}/folders`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "object-type": objectType, "hide-shared-parent": hideSharedParent};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the folderChildFolder
    #
    # + repositoryName - The repository name. 
    # + folderId - The r_object_id of queried folder. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createFolderChildFolder(string repositoryName, string folderId, FolderBase payload, string? accept = (), string? contentType = ()) returns Folder|error {
        string  path = string `/repositories/${repositoryName}/folders/${folderId}/folders`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Folder response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Folder);
        return response;
    }
    # Get the folderChildObjects
    #
    # + repositoryName - The repository name. 
    # + folderId - The r_object_id of queried folder. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + objectType - The type of the queried object. 
    # + includeAllVersions - Whether include all versions 
    # + hideSharedParent - Whether hide the shared parent of child folders. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getFolderChildObjects(string repositoryName, string folderId, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? objectType = (), string includeAllVersions = "false", string hideSharedParent = "false", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/folders/${folderId}/objects`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "object-type": objectType, "include-all-versions": includeAllVersions, "hide-shared-parent": hideSharedParent};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the folder
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + checkSubscription - Ensures whether to show subscriptions on the object instance. * 'true', return subscriptions on the object instance. * 'false', do not return subscriptions on the object instance. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getFolder(string repositoryName, string id, string view = ":default", boolean links = true, string checkSubscription = "false", string? accept = ()) returns Folder|error {
        string  path = string `/repositories/${repositoryName}/folders/${id}`;
        map<anydata> queryParam = {"view": view, "links": links, "check-subscription": checkSubscription};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Folder response = check self.clientEp-> get(path, accHeaders, targetType = Folder);
        return response;
    }
    # Update the folder
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateFolder(string repositoryName, string id, FolderBase payload, string? accept = (), string? contentType = ()) returns Folder|error {
        string  path = string `/repositories/${repositoryName}/folders/${id}`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Folder response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Folder);
        return response;
    }
    # Delete the folder
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + delNonEmpty - Ensures whether to delete the folder instance when it is not empty. * 'true', would delete the folder and all of its descendants. * 'false', would not delete the folder instance only. 
    # + delAllLinks - Ensures whether to unlink the links on folder instance and all its descendants when deleted. * 'true', would delete the folder and all descendants, regardless of other folders into which they are linked * 'false', would unlink folder descendants from the folder being deleted if the folder descendants have links to other folders, and to remove folder descendants that are only linked to the folder being deleted. 
    # + return - Operation successfully 
    remote isolated function deleteFolder(string repositoryName, string id, string? delNonEmpty = (), string? delAllLinks = ()) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/folders/${id}`;
        map<anydata> queryParam = {"del-non-empty": delNonEmpty, "del-all-links": delAllLinks};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the childFolderLinks
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + includeAllVersions - Whether include all versions 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getChildFolderLinks(string repositoryName, string objectId, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string includeAllVersions = "false", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/folders/${objectId}/child-links`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "include-all-versions": includeAllVersions};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the childFolderLink
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createChildFolderLink(string repositoryName, string objectId, FolderLinkBase payload, string? accept = (), string? contentType = ()) returns FolderLink|error {
        string  path = string `/repositories/${repositoryName}/folders/${objectId}/child-links`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        FolderLink response = check self.clientEp->post(path, request, headers = accHeaders, targetType=FolderLink);
        return response;
    }
    # Get the childFolderLink
    #
    # + repositoryName - The repository name. 
    # + parentFolderId - The r_object_id of parent folder for the object. 
    # + objectId - The r_object_id of required sysobject. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getChildFolderLink(string repositoryName, string parentFolderId, string objectId, boolean links = true, string? accept = ()) returns FolderLink|error {
        string  path = string `/repositories/${repositoryName}/folders/${parentFolderId}/child-links/${objectId}`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        FolderLink response = check self.clientEp-> get(path, accHeaders, targetType = FolderLink);
        return response;
    }
    # Delete the childFolderLink
    #
    # + repositoryName - The repository name. 
    # + parentFolderId - The r_object_id of parent folder for the object. 
    # + objectId - The r_object_id of required sysobject. 
    # + return - Operation successfully 
    remote isolated function deleteChildFolderLink(string repositoryName, string parentFolderId, string objectId) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/folders/${parentFolderId}/child-links/${objectId}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the formats
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getFormats(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/formats`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the format
    #
    # + repositoryName - The repository name. 
    # + formatName - The name of the dm_format object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getFormat(string repositoryName, string formatName, string view = ":default", boolean links = true, string? accept = ()) returns Format|error {
        string  path = string `/repositories/${repositoryName}/formats/${formatName}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Format response = check self.clientEp-> get(path, accHeaders, targetType = Format);
        return response;
    }
    # Get the groups
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + userName - Specifies the username to get parent groups which contains this user. 
    # + groupName - Specifies the group name to get parent groups which contains this group. 
    # + recursive - Whether return users included in sub groups. * 'true', would include sub groups' users. * 'false', only return users which directly belong to given group. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getGroups(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? userName = (), string? groupName = (), string recursive = "false", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/groups`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "user-name": userName, "group-name": groupName, "recursive": recursive};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the group
    #
    # + repositoryName - The repository name. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createGroup(string repositoryName, GroupBase payload, string? accept = (), string? contentType = ()) returns Group|error {
        string  path = string `/repositories/${repositoryName}/groups`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Group response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Group);
        return response;
    }
    # Get the group
    #
    # + repositoryName - The repository name. 
    # + groupName - The encoded name of group. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getGroup(string repositoryName, string groupName, string view = ":default", boolean links = true, string? accept = ()) returns Group|error {
        string  path = string `/repositories/${repositoryName}/groups/${groupName}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Group response = check self.clientEp-> get(path, accHeaders, targetType = Group);
        return response;
    }
    # Update the group
    #
    # + repositoryName - The repository name. 
    # + groupName - The encoded name of group. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateGroup(string repositoryName, string groupName, GroupBase payload, string view = ":default", boolean links = true, string? accept = (), string? contentType = ()) returns Group|error {
        string  path = string `/repositories/${repositoryName}/groups/${groupName}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Group response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Group);
        return response;
    }
    # Delete the group
    #
    # + repositoryName - The repository name. 
    # + groupName - The encoded name of group. 
    # + return - Operation successfully 
    remote isolated function deleteGroup(string repositoryName, string groupName) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/groups/${groupName}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the groupMemberGroups
    #
    # + repositoryName - The repository name. 
    # + groupName - The encoded name of group. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + recursive - Whether return users included in sub groups. * 'true', would include sub groups' users. * 'false', only return users which directly belong to given group. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getGroupMemberGroups(string repositoryName, string groupName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string recursive = "false", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/groups/${groupName}/groups`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "recursive": recursive};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the groupMemberGroup
    #
    # + repositoryName - The repository name. 
    # + groupName - The encoded name of group. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createGroupMemberGroup(string repositoryName, string groupName, GroupBase payload, string? accept = (), string? contentType = ()) returns Group|error {
        string  path = string `/repositories/${repositoryName}/groups/${groupName}/groups`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Group response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Group);
        return response;
    }
    # Delete the groupMemberGroup
    #
    # + repositoryName - The repository name. 
    # + groupName - The encoded name of group. 
    # + memberName - The encoded name of sub group. 
    # + return - Operation successfully 
    remote isolated function deleteGroupMemberGroup(string repositoryName, string groupName, string memberName) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/groups/${groupName}/groups/${memberName}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the groupMemberUsers
    #
    # + repositoryName - The repository name. 
    # + groupName - The encoded name of group. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + recursive - Whether return users included in sub groups. * 'true', would include sub groups' users. * 'false', only return users which directly belong to given group. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getGroupMemberUsers(string repositoryName, string groupName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string recursive = "false", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/groups/${groupName}/users`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "recursive": recursive};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the groupMemberUser
    #
    # + repositoryName - The repository name. 
    # + groupName - The encoded name of group. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createGroupMemberUser(string repositoryName, string groupName, UserBase payload, string? accept = (), string? contentType = ()) returns User|error {
        string  path = string `/repositories/${repositoryName}/groups/${groupName}/users`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        User response = check self.clientEp->post(path, request, headers = accHeaders, targetType=User);
        return response;
    }
    # Delete the groupMemberUser
    #
    # + repositoryName - The repository name. 
    # + groupName - The encoded name of group. 
    # + userName - The encoded username. 
    # + return - Operation successfully 
    remote isolated function deleteGroupMemberUser(string repositoryName, string groupName, string userName) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/groups/${groupName}/users/${userName}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the inbox
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + itemType - Specifies what kind of items the inbox should return. By default is to return all notifications and workflow tasks, namely 7, it is value of 0x001|0x0002|0x0004. It can be any of the following value bitwise OR'ed together. * '0xFFFF', (DF_ALL) including all notifications and tasks. * '0x0001', (DF_NOTIFICATION) including only notifications but not queued notifications. * '0x0002', (DF_QUEUED) including only queued notifications. * '0x0004', (DF_WORKFLOWTASK) including only workflow tasks * '0x0008', (DF_ROUTERTASK) including only router task. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getInbox(string repositoryName, int itemsPerPage = 100, int page = 1, boolean inline = false, boolean links = true, int? itemType = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/inbox`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "inline": inline, "links": links, "item-type": itemType};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the inboxItem
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getInboxItem(string repositoryName, string itemId, boolean links = true, string? accept = ()) returns InboxItem|error {
        string  path = string `/repositories/${repositoryName}/inbox/${itemId}`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        InboxItem response = check self.clientEp-> get(path, accHeaders, targetType = InboxItem);
        return response;
    }
    # Put the inboxItem
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + action - Specifies what action will be done on the workflow task inbox item, currently, only these actions are supported, ACQUIRE,FORWARD,REJECT,DELEGATE,REPEAT,SIGNOFF. 
    # + delegateUser - Specifies the user to be delegated for a workflow task, this is mandatory when action is DELEGATE, for other actions, the value will be ignored. 
    # + repeatUsers - Specifies the user names and/or group names to repeat the workflow task, and more values are separated by the comma, e.g. userA,userB,groupC. This is mandatory when action is REPEAT, for other actions,this value will be ignored. 
    # + signoffPassword - Specifies the signoff password when the action is SIGNOFF, this value will be ignored for other actions. 
    # + activity - Specifies the activity name. 
    # + assignPerformers - Specifies URL encoded user names and/or group names to whom the target activity will be assigned. Separated by commas. Mandatory when performing ASSIGN action. Ignored for other actions. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putInboxItem(string repositoryName, string itemId, string action, string? delegateUser = (), string? repeatUsers = (), string? signoffPassword = (), string? activity = (), string? assignPerformers = (), string? accept = (), string? contentType = ()) returns InboxItem|error {
        string  path = string `/repositories/${repositoryName}/inbox/${itemId}`;
        map<anydata> queryParam = {"action": action, "delegate-user": delegateUser, "repeat-users": repeatUsers, "signoff-password": signoffPassword, "activity": activity, "assign-performers": assignPerformers};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        //TODO: Update the request as needed;
        InboxItem response = check self.clientEp-> put(path, request, headers = accHeaders, targetType = InboxItem);
        return response;
    }
    # Delete the inboxItem
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + return - Operation successfully 
    remote isolated function deleteInboxItem(string repositoryName, string itemId) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/inbox/${itemId}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the lifecycles
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + includeAllVersions - Whether include all versions 
    # + objectIdQueryParam - The r_object_id of required sysobject. 
    # + objectType - The type of the queried object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getLifecycles(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string includeAllVersions = "false", string? objectIdQueryParam = (), string? objectType = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/lifecycles`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "include-all-versions": includeAllVersions, "object-id-query-param": objectIdQueryParam, "object-type": objectType};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the lifecycle
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getLifecycle(string repositoryName, string objectId, boolean links = true, string? accept = ()) returns Lifecycle|error {
        string  path = string `/repositories/${repositoryName}/lifecycles/${objectId}`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Lifecycle response = check self.clientEp-> get(path, accHeaders, targetType = Lifecycle);
        return response;
    }
    # Get the networkLocations
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getNetworkLocations(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/network-locations`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the networkLocation
    #
    # + repositoryName - The repository name. 
    # + networkLocationIdentifier - The netloc_identifier of the dm_network_location_map location object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getNetworkLocation(string repositoryName, string networkLocationIdentifier, string view = ":default", boolean links = true, string? accept = ()) returns NetworkLocation|error {
        string  path = string `/repositories/${repositoryName}/network-locations/${networkLocationIdentifier}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        NetworkLocation response = check self.clientEp-> get(path, accHeaders, targetType = NetworkLocation);
        return response;
    }
    # Get the object
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + checkSubscription - Ensures whether to show subscriptions on the object instance. * 'true', return subscriptions on the object instance. * 'false', do not return subscriptions on the object instance. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getObject(string repositoryName, string id, string view = ":default", boolean links = true, string checkSubscription = "false", string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}`;
        map<anydata> queryParam = {"view": view, "links": links, "check-subscription": checkSubscription};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the object
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createObject(string repositoryName, string id, ObjectBase payload, string? accept = (), string? contentType = ()) returns Object|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Object response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Object);
        return response;
    }
    # Delete the object
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + delVersion - Delete options for multi-version document object. * 'selected_version', delete selected version only. * 'non_used_versions', delete non used versions. * 'all_versions', delete all versions. 
    # + delNonEmpty - Ensures whether to delete the folder instance when it is not empty. * 'true', would delete the folder and all of its descendants. * 'false', would not delete the folder instance only. 
    # + delAllLinks - Ensures whether to unlink the links on folder instance and all its descendants when deleted. * 'true', would delete the folder and all descendants, regardless of other folders into which they are linked * 'false', would unlink folder descendants from the folder being deleted if the folder descendants have links to other folders, and to remove folder descendants that are only linked to the folder being deleted. 
    # + delVdAll - Whether remove the all the descendants if the object is virtual. 
    # + return - Operation successfully 
    remote isolated function deleteObject(string repositoryName, string id, int? delVersion = (), string? delNonEmpty = (), string? delAllLinks = (), string delVdAll = "false") returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}`;
        map<anydata> queryParam = {"del-version": delVersion, "del-non-empty": delNonEmpty, "del-all-links": delAllLinks, "del-vd-all": delVdAll};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the comments
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getComments(string repositoryName, string id, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/comments`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the comment
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createComment(string repositoryName, string id, CommentBase payload, string view = ":default", boolean links = true, string? accept = (), string? contentType = ()) returns Comment|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/comments`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Comment response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Comment);
        return response;
    }
    # Get the comment
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + commentId - The r_object_id of the comment instance. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getComment(string repositoryName, string id, string commentId, string view = ":default", boolean links = true, string? accept = ()) returns Comment|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/comments/${commentId}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Comment response = check self.clientEp-> get(path, accHeaders, targetType = Comment);
        return response;
    }
    # Delete the comment
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + commentId - The r_object_id of the comment instance. 
    # + return - Operation successfully 
    remote isolated function deleteComment(string repositoryName, string id, string commentId) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/comments/${commentId}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the contentMedia
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + format - Specifies the format name of the specific content or rendition. 
    # + page - Specifies the page number of the specific content or rendition. 
    # + modifier - Specifies the page modifier of the specific rendition. 
    # + return - Operation successfully 
    remote isolated function getContentMedia(string repositoryName, string id, string? format = (), int page = 0, string? modifier = ()) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/content-media`;
        map<anydata> queryParam = {"format": format, "page": page, "modifier": modifier};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> get(path, targetType = http:Response);
        return response;
    }
    # Get the content
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + format - Specifies the format name of the specific content or rendition. 
    # + page - Specifies the page number of the specific content or rendition. 
    # + modifier - Specifies the page modifier of the specific rendition. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + mediaUrlPolicy - Specifies the content media URL return policy. * 'dc-pref', would try to retrieve a distributed content URL first. If no distributed content URL is available, a Content Media resource URL from the REST server is still acceptable. * 'dc-only', return a distributed content URL. If there is no ACS server or BOCS server, the REST server returns the HTTP 400 Conflict error. * 'local', return a Content Media resource URL from the REST server regardless of the availability of the ACS server and the BOCS server. * 'all', all available Content Media links are returned. 
    # + networkLocation - The network location for distributed content write. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getContent(string repositoryName, string id, string? format = (), int page = 0, string? modifier = (), boolean links = true, int? mediaUrlPolicy = (), string? networkLocation = (), string? accept = ()) returns Content|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/contents/content`;
        map<anydata> queryParam = {"format": format, "page": page, "modifier": modifier, "links": links, "media-url-policy": mediaUrlPolicy, "network-location": networkLocation};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Content response = check self.clientEp-> get(path, accHeaders, targetType = Content);
        return response;
    }
    # Update the content
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + format - Specifies the format name of the specific content or rendition. 
    # + page - Specifies the page number of the specific content or rendition. 
    # + modifier - Specifies the page modifier of the specific rendition. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateContent(string repositoryName, string id, ContentBase payload, string view = ":default", boolean links = true, string? format = (), int page = 0, string? modifier = (), string? accept = (), string? contentType = ()) returns HalContent|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/contents/content`;
        map<anydata> queryParam = {"view": view, "links": links, "format": format, "page": page, "modifier": modifier};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        HalContent response = check self.clientEp->post(path, request, headers = accHeaders, targetType=HalContent);
        return response;
    }
    # Delete the content
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + format - Specifies the format name of the specific content or rendition. 
    # + page - Specifies the page number of the specific content or rendition. 
    # + modifier - Specifies the page modifier of the specific rendition. 
    # + return - Operation successfully 
    remote isolated function deleteContent(string repositoryName, string id, string? format = (), int page = 0, string? modifier = ()) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/contents/content`;
        map<anydata> queryParam = {"format": format, "page": page, "modifier": modifier};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Put the materialization
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putMaterialization(string repositoryName, string id, string? accept = (), string? contentType = ()) returns Object|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/materialization`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        //TODO: Update the request as needed;
        Object response = check self.clientEp-> put(path, request, headers = accHeaders, targetType = Object);
        return response;
    }
    # Delete the materialization
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + return - Operation successfully 
    remote isolated function deleteMaterialization(string repositoryName, string id) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/materialization`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the objectParent
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getObjectParent(string repositoryName, string id, string view = ":default", boolean links = true, string? accept = ()) returns Object|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/parent`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Object response = check self.clientEp-> get(path, accHeaders, targetType = Object);
        return response;
    }
    # Update the objectParent
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateObjectParent(string repositoryName, string id, ObjectParentBase payload, string? accept = (), string? contentType = ()) returns Object|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/parent`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Object response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Object);
        return response;
    }
    # Put the objectSubscription
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putObjectSubscription(string repositoryName, string id, SubscribersBase payload, string? accept = (), string? contentType = ()) returns Object|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/subscription`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Object response = check self.clientEp->put(path, request, headers = accHeaders, targetType=Object);
        return response;
    }
    # Delete the objectSubscription
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + return - Operation successfully 
    remote isolated function deleteObjectSubscription(string repositoryName, string id) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/objects/${id}/subscription`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the objectAspects
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getObjectAspects(string repositoryName, string objectId, boolean links = true, string? accept = ()) returns ObjectAspects|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/aspects`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        ObjectAspects response = check self.clientEp-> get(path, accHeaders, targetType = ObjectAspects);
        return response;
    }
    # Update the objectAspect
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateObjectAspect(string repositoryName, string objectId, ObjectAspectsBase payload, string? accept = (), string? contentType = ()) returns ObjectAspects|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/aspects`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        ObjectAspects response = check self.clientEp->post(path, request, headers = accHeaders, targetType=ObjectAspects);
        return response;
    }
    # Delete the objectAspect
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + aspectName - The name of the aspect. 
    # + return - Operation successfully 
    remote isolated function deleteObjectAspect(string repositoryName, string objectId, string aspectName) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/aspects/${aspectName}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the contents
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + mediaUrlPolicy - Specifies the content media URL return policy. * 'dc-pref', would try to retrieve a distributed content URL first. If no distributed content URL is available, a Content Media resource URL from the REST server is still acceptable. * 'dc-only', return a distributed content URL. If there is no ACS server or BOCS server, the REST server returns the HTTP 400 Conflict error. * 'local', return a Content Media resource URL from the REST server regardless of the availability of the ACS server and the BOCS server. * 'all', all available Content Media links are returned. 
    # + networkLocation - The network location for distributed content write. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getContents(string repositoryName, string objectId, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, int? mediaUrlPolicy = (), string? networkLocation = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/contents`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "media-url-policy": mediaUrlPolicy, "network-location": networkLocation};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the content
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + format - Specifies the format name of the specific content or rendition. 
    # + page - Specifies the page number of the specific content or rendition. 
    # + modifier - Specifies the page modifier of the specific rendition. 
    # + primary - Specifies whether the imported content is primary content or a rendition. 
    # + contentLength - The byte count of the content uploaded. 
    # + contentCharset - The charset of the content uploaded. 
    # + overwrite - Specifies whether or not to overwrite the existing content with the same content properties. * 'true', would overwrite the existing primary content. * 'false', throw an exception when the primary content or rendition with the same content properties already exists. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createContent(string repositoryName, string objectId, ContentBase payload, string? format = (), int page = 0, string? modifier = (), string? primary = (), int contentLength = 0, string? contentCharset = (), string? overwrite = (), string? accept = (), string? contentType = ()) returns Content|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/contents`;
        map<anydata> queryParam = {"format": format, "page": page, "modifier": modifier, "primary": primary, "content-length": contentLength, "content-charset": contentCharset, "overwrite": overwrite};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Content response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Content);
        return response;
    }
    # Get the objectLightweightObjects
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getObjectLightweightObjects(string repositoryName, string objectId, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/lw-objects`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the objectLightweightObject
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + format - The format of the content uploaded. 
    # + contentLength - The byte count of the content uploaded. 
    # + contentCharset - The charset of the content uploaded. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createObjectLightweightObject(string repositoryName, string objectId, ObjectBase payload, string? format = (), int contentLength = 0, string? contentCharset = (), string? accept = (), string? contentType = ()) returns Object|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/lw-objects`;
        map<anydata> queryParam = {"format": format, "content-length": contentLength, "content-charset": contentCharset};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Object response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Object);
        return response;
    }
    # Get the parentFolderLinks
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getParentFolderLinks(string repositoryName, string objectId, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/parent-links`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the parentFolderLink
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createParentFolderLink(string repositoryName, string objectId, FolderLinkBase payload, string? accept = (), string? contentType = ()) returns FolderLink|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/parent-links`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        FolderLink response = check self.clientEp->post(path, request, headers = accHeaders, targetType=FolderLink);
        return response;
    }
    # Get the parentFolderLink
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + parentFolderId - The r_object_id of parent folder for the object. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getParentFolderLink(string repositoryName, string objectId, string parentFolderId, boolean links = true, string? accept = ()) returns FolderLink|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/parent-links/${parentFolderId}`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        FolderLink response = check self.clientEp-> get(path, accHeaders, targetType = FolderLink);
        return response;
    }
    # Put the parentFolderLink
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + parentFolderId - The r_object_id of parent folder for the object. 
    # + includeAllVersions - Whether include all versions 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putParentFolderLink(string repositoryName, string objectId, string parentFolderId, FolderLinkBase payload, string includeAllVersions = "false", string? accept = (), string? contentType = ()) returns FolderLink|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/parent-links/${parentFolderId}`;
        map<anydata> queryParam = {"include-all-versions": includeAllVersions};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        FolderLink response = check self.clientEp->put(path, request, headers = accHeaders, targetType=FolderLink);
        return response;
    }
    # Delete the parentFolderLink
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + parentFolderId - The r_object_id of parent folder for the object. 
    # + return - Operation successfully 
    remote isolated function deleteParentFolderLink(string repositoryName, string objectId, string parentFolderId) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/parent-links/${parentFolderId}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the permissionSet
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getPermissionSet(string repositoryName, string objectId, boolean links = true, string? accept = ()) returns PermissionSet|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/permission-set`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        PermissionSet response = check self.clientEp-> get(path, accHeaders, targetType = PermissionSet);
        return response;
    }
    # Put the permissionSet
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putPermissionSet(string repositoryName, string objectId, PermissionSetBase payload, string? accept = (), string? contentType = ()) returns PermissionSet|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/permission-set`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        PermissionSet response = check self.clientEp->put(path, request, headers = accHeaders, targetType=PermissionSet);
        return response;
    }
    # Get the permissions
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accessor - Specifies a user or group name to check his permissions on this object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getPermissions(string repositoryName, string objectId, boolean links = true, string? accessor = (), string? accept = ()) returns Permission|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/permissions`;
        map<anydata> queryParam = {"links": links, "accessor": accessor};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Permission response = check self.clientEp-> get(path, accHeaders, targetType = Permission);
        return response;
    }
    # Get the virtualDocumentNodes
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + bindingLabel - Specifies the version label to use to resolve late bound nodes for a virtual document. 
    # + followAssembly - The follow-assembly property determines whether the server selects component descendants using the containment objects or a snapshot associated with the component. Only when follow-assembly is true and there is a snapshot, then the server selects components from the snapshot. 
    # + includeBroken - Specifies whether to include nodes with broken bindings for a virtual document. * 'true', would include nodes with broken bindings with current version. * 'false', do not include nodes with broken bindings. 
    # + depth - Specifies to what depth level the virtual document hierarchy will be returned. -1 means return the whole virtual document tree. 
    # + vdmNumber - The node's number in the virtual document tree. The schema of vdm-number is based on the level of the node, e.g., * 1st level, 1, 2, 3, ... * 2nd level, 1.1, 1.2, 3.1, ... * 3rd level, 1.1.1, 1.1.2, 1.1.3, ... * ... 
    # + objectIdQueryParam - The r_object_id of required sysobject. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getVirtualDocumentNodes(string repositoryName, string objectId, int itemsPerPage = 100, int page = 1, boolean inline = false, boolean links = true, string bindingLabel = "CURRENT", string? followAssembly = (), string includeBroken = "false", int depth = 1, string? vdmNumber = (), string? objectIdQueryParam = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/vd-nodes`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "inline": inline, "links": links, "binding-label": bindingLabel, "follow-assembly": followAssembly, "include-broken": includeBroken, "depth": depth, "vdm-number": vdmNumber, "object-id-query-param": objectIdQueryParam};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the virtualDocumentNode
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createVirtualDocumentNode(string repositoryName, string objectId, VdNodeBase payload, string? accept = (), string? contentType = ()) returns VdNode|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/vd-nodes`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        VdNode response = check self.clientEp->post(path, request, headers = accHeaders, targetType=VdNode);
        return response;
    }
    # Get the currentVersion
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getCurrentVersion(string repositoryName, string objectId, boolean links = true, string? accept = ()) returns Object|error {
        string  path = string `/repositories/${repositoryName}/objects/${objectId}/versions/current`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Object response = check self.clientEp-> get(path, accHeaders, targetType = Object);
        return response;
    }
    # Get the queueTasks
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + userName - Specifies the login name of user to whom the queue tasks belong. Defaults to currently logged in user. 
    # + queueNames - Specifies the names of queues which the tasks are inside. Separated by commas. 
    # + filterType - Specifies the range of tasks to be filtered. The following values are supported.(case insensitive) * ALL, Shows all tasks in the work queue. * UNASSIGNED, Shows unassigned tasks in the work queue. * ELIGIBLE_AND_OWNED, Shows the tasks that the processor can work on and the tasks that the processor owns in the work queue. * ELIGIBLE, Shows the tasks that the processor can work on in the work queue. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getQueueTasks(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? userName = (), string? queueNames = (), string? filterType = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/queue-tasks`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "user-name": userName, "queue-names": queueNames, "filter-type": filterType};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the queueTask
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getQueueTask(string repositoryName, string itemId, boolean links = true, string? accept = ()) returns WorkQueueTask|error {
        string  path = string `/repositories/${repositoryName}/queue-tasks/${itemId}`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        WorkQueueTask response = check self.clientEp-> get(path, accHeaders, targetType = WorkQueueTask);
        return response;
    }
    # Put the queueTask
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + action - Specifies what action to perform on the work queue task. The following actions are supported. * HOLD, Sets the work item a_held_by to indicate if the task is being worked on. * REASSIGN, Reassigns this task to the specified user, user-name is required, and pulled is optional. This action will unsuspend a suspended task. * SUSPEND, Suspends this task with the specified expected unsuspend date and time, unsuspend-time is optional. * UNSUSPEND, Unsuspends or resumes this task. * UNHOLD, Releases the task. 
    # + userName - Specifies the login name of the user to whom the task will be reassigned. 
    # + pulled - Set to true to indicate that it's an end user's action, or false if a supervisor or administrator assigns the task. Defaults to false. 
    # + unsuspendTime - Specifies the absolute date and time when the task must be unsuspended automatically. Used when performing a SUSPEND action. Pass in NULL if the timer is not used for suspending the task. The date format should comply with ISO 8601. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putQueueTask(string repositoryName, string itemId, string action, string? userName = (), string? pulled = (), string? unsuspendTime = (), string? accept = (), string? contentType = ()) returns WorkQueueTask|error {
        string  path = string `/repositories/${repositoryName}/queue-tasks/${itemId}`;
        map<anydata> queryParam = {"action": action, "user-name": userName, "pulled": pulled, "unsuspend-time": unsuspendTime};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        //TODO: Update the request as needed;
        WorkQueueTask response = check self.clientEp-> put(path, request, headers = accHeaders, targetType = WorkQueueTask);
        return response;
    }
    # Get the auditEvents
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + auditScope - The scope of the audit event would effect to register and would use with 'object-id' to get the intersection to operate. * 'repository', means the event would register over whole repository. * 'type', means the event would register over type. * 'object', means the event would register over object. 
    # + objectIdQueryParam - The r_object_id of required sysobject. 
    # + objectType - The type of the queried object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAuditEvents(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? auditScope = (), string? objectIdQueryParam = (), string? objectType = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/registered-audit-events`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "audit-scope": auditScope, "object-id-query-param": objectIdQueryParam, "object-type": objectType};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the auditEvent
    #
    # + repositoryName - The repository name. 
    # + auditScope - The scope of the audit event would effect to register and would use with 'object-id' to get the intersection to operate. * 'repository', means the event would register over whole repository. * 'type', means the event would register over type. * 'object', means the event would register over object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + objectIdQueryParam - The r_object_id of required sysobject. 
    # + objectType - The type of the queried object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createAuditEvent(string repositoryName, string auditScope, AuditEventBase payload, string view = ":default", boolean links = true, string? objectIdQueryParam = (), string? objectType = (), string? accept = (), string? contentType = ()) returns AuditEvent|error {
        string  path = string `/repositories/${repositoryName}/registered-audit-events`;
        map<anydata> queryParam = {"view": view, "links": links, "audit-scope": auditScope, "object-id-query-param": objectIdQueryParam, "object-type": objectType};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        AuditEvent response = check self.clientEp->post(path, request, headers = accHeaders, targetType=AuditEvent);
        return response;
    }
    # Delete the auditEvents
    #
    # + repositoryName - The repository name. 
    # + auditScope - The scope of the audit event would effect to register and would use with 'object-id' to get the intersection to operate. * 'repository', means the event would register over whole repository. * 'type', means the event would register over type. * 'object', means the event would register over object. 
    # + objectIdQueryParam - The r_object_id of required sysobject. 
    # + objectType - The type of the queried object. 
    # + return - Operation successfully 
    remote isolated function deleteAuditEvents(string repositoryName, string auditScope, string? objectIdQueryParam = (), string? objectType = ()) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/registered-audit-events`;
        map<anydata> queryParam = {"audit-scope": auditScope, "object-id-query-param": objectIdQueryParam, "object-type": objectType};
        path = path + check getPathForQueryParam(queryParam);
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the auditEvent
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getAuditEvent(string repositoryName, string id, string view = ":default", boolean links = true, string? accept = ()) returns AuditEvent|error {
        string  path = string `/repositories/${repositoryName}/registered-audit-events/${id}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        AuditEvent response = check self.clientEp-> get(path, accHeaders, targetType = AuditEvent);
        return response;
    }
    # Delete the auditEvent
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + return - Operation successfully 
    remote isolated function deleteAuditEvent(string repositoryName, string id) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/registered-audit-events/${id}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the relationTypes
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getRelationTypes(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/relation-types`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the relationType
    #
    # + repositoryName - The repository name. 
    # + relationName - The relation name. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getRelationType(string repositoryName, string relationName, string view = ":default", boolean links = true, string? accept = ()) returns RelationType|error {
        string  path = string `/repositories/${repositoryName}/relation-types/${relationName}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        RelationType response = check self.clientEp-> get(path, accHeaders, targetType = RelationType);
        return response;
    }
    # Get the relations
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + relatedObjectId - The r_object_id of the related object in the relation. 
    # + relatedObjectRole - The role of the related object. Only when 'related-object-id' is provided would take effect. * 'any'='0', role can be parent or child. * 'parent'='1', role should be parent. * 'child'='2', role should be child. 
    # + relationName - The name of the relation. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getRelations(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? relatedObjectId = (), int? relatedObjectRole = (), string? relationName = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/relations`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "related-object-id": relatedObjectId, "related-object-role": relatedObjectRole, "relation-name": relationName};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the relation
    #
    # + repositoryName - The repository name. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createRelation(string repositoryName, RelationBase payload, string? accept = (), string? contentType = ()) returns Relation|error {
        string  path = string `/repositories/${repositoryName}/relations`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Relation response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Relation);
        return response;
    }
    # Get the relation
    #
    # + repositoryName - The repository name. 
    # + relationId - The r_object_id of the relation instance. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getRelation(string repositoryName, string relationId, string view = ":default", boolean links = true, string? accept = ()) returns Relation|error {
        string  path = string `/repositories/${repositoryName}/relations/${relationId}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Relation response = check self.clientEp-> get(path, accHeaders, targetType = Relation);
        return response;
    }
    # Delete the relation
    #
    # + repositoryName - The repository name. 
    # + relationId - The r_object_id of the relation instance. 
    # + return - Operation successfully 
    remote isolated function deleteRelation(string repositoryName, string relationId) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/relations/${relationId}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the savedSearches
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSavedSearches(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/saved-searches`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the savedSearch
    #
    # + repositoryName - The repository name. 
    # + queryLocale - A locale used to evaluate the query and parse word into language dependent token. Only supported with xPlore. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createSavedSearch(string repositoryName, SavedSearchBase payload, string queryLocale = "en", string? accept = (), string? contentType = ()) returns SavedSearch|error {
        string  path = string `/repositories/${repositoryName}/saved-searches`;
        map<anydata> queryParam = {"query-locale": queryLocale};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        SavedSearch response = check self.clientEp->post(path, request, headers = accHeaders, targetType=SavedSearch);
        return response;
    }
    # Get the searchTemplates
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSearchTemplates(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/search-templates`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the searchTemplate
    #
    # + repositoryName - The repository name. 
    # + queryLocale - A locale used to evaluate the query and parse word into language dependent token. Only supported with xPlore. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createSearchTemplate(string repositoryName, SearchTemplateBase payload, string queryLocale = "en", string? accept = (), string? contentType = ()) returns SearchTemplate|error {
        string  path = string `/repositories/${repositoryName}/search-templates`;
        map<anydata> queryParam = {"query-locale": queryLocale};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        SearchTemplate response = check self.clientEp->post(path, request, headers = accHeaders, targetType=SearchTemplate);
        return response;
    }
    # Get the vdSnapshots
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getVdSnapshots(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/snapshots`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the vdSnapshot
    #
    # + repositoryName - The repository name. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + bindingLabel - Specifies the version label to use to resolve late bound nodes for a virtual document. 
    # + includeBroken - Specifies whether to include nodes with broken bindings for a virtual document. * 'true', would include nodes with broken bindings with current version. * 'false', do not include nodes with broken bindings. 
    # + frozen - Specifies whether to freeze the snapshot right after creation. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createVdSnapshot(string repositoryName, VdSnapshotBase payload, string view = ":default", boolean links = true, string bindingLabel = "CURRENT", string includeBroken = "false", string frozen = "true", string? accept = (), string? contentType = ()) returns VdSnapshot|error {
        string  path = string `/repositories/${repositoryName}/snapshots`;
        map<anydata> queryParam = {"view": view, "links": links, "binding-label": bindingLabel, "include-broken": includeBroken, "frozen": frozen};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        VdSnapshot response = check self.clientEp->post(path, request, headers = accHeaders, targetType=VdSnapshot);
        return response;
    }
    # Get the vdSnapshotNodes
    #
    # + repositoryName - The repository name. 
    # + objectId - The r_object_id of required sysobject. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + depth - Specifies to what depth level the virtual document hierarchy will be returned. -1 means return the whole virtual document tree. 
    # + vdmNumber - The node's number in the virtual document tree. The schema of vdm-number is based on the level of the node, e.g., * 1st level, 1, 2, 3, ... * 2nd level, 1.1, 1.2, 3.1, ... * 3rd level, 1.1.1, 1.1.2, 1.1.3, ... * ... 
    # + objectIdQueryParam - The r_object_id of required sysobject. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getVdSnapshotNodes(string repositoryName, string objectId, int itemsPerPage = 100, int page = 1, boolean inline = false, boolean links = true, int depth = 1, string? vdmNumber = (), string? objectIdQueryParam = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/snapshots/${objectId}/vd-nodes`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "inline": inline, "links": links, "depth": depth, "vdm-number": vdmNumber, "object-id-query-param": objectIdQueryParam};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the vdSnapshot
    #
    # + repositoryName - The repository name. 
    # + snapshotId - The r_object_id of the associated snapshot. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getVdSnapshot(string repositoryName, string snapshotId, boolean links = true, string? accept = ()) returns VdSnapshot|error {
        string  path = string `/repositories/${repositoryName}/snapshots/${snapshotId}`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        VdSnapshot response = check self.clientEp-> get(path, accHeaders, targetType = VdSnapshot);
        return response;
    }
    # Delete the vdSnapshot
    #
    # + repositoryName - The repository name. 
    # + snapshotId - The r_object_id of the associated snapshot. 
    # + return - Operation successfully 
    remote isolated function deleteVdSnapshot(string repositoryName, string snapshotId) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/snapshots/${snapshotId}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Put the vdSnapshotFrozen
    #
    # + repositoryName - The repository name. 
    # + snapshotId - The r_object_id of the associated snapshot. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putVdSnapshotFrozen(string repositoryName, string snapshotId, string? accept = (), string? contentType = ()) returns VdSnapshot|error {
        string  path = string `/repositories/${repositoryName}/snapshots/${snapshotId}/frozen`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        //TODO: Update the request as needed;
        VdSnapshot response = check self.clientEp-> put(path, request, headers = accHeaders, targetType = VdSnapshot);
        return response;
    }
    # Delete the vdSnapshotFrozen
    #
    # + repositoryName - The repository name. 
    # + snapshotId - The r_object_id of the associated snapshot. 
    # + return - Operation successfully 
    remote isolated function deleteVdSnapshotFrozen(string repositoryName, string snapshotId) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/snapshots/${snapshotId}/frozen`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the subscriptions
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSubscriptions(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/subscriptions`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the supportedFacets
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSupportedFacets(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string? accept = ()) returns SupportedFacets|error {
        string  path = string `/repositories/${repositoryName}/supported-facets`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        SupportedFacets response = check self.clientEp-> get(path, accHeaders, targetType = SupportedFacets);
        return response;
    }
    # Get the types
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + parentType - Gets direct sub types or all sub types of the specified type. 
    # + recursive - Specifies whether get direct or indirect sub types 
    # + inherited - Specifies whether or not to include all of the properties of a type including the inherited properties from the parent type. 
    # + locale - The locale name. 
    # + includeLifecycle - Specifies whether or not to get the type related information for the different lifecycles and states. 
    # + includeAuditableEvents - Specifies whether or not to get the type auditable system and app events. 
    # + includeDisplayConfigs - Specifies whether or not to get the type display configuration information. 
    # + includeMappingTables - Specifies whether or not to get the type and properties mapping table information. 
    # + includeValueConstraints - Specifies whether or not to get the type and properties value constraints information. 
    # + includeAll - Specifies whether or not to get all the type related information. 
    # + dmlView - Specifies what shall be returned for the collection. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getTypes(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? parentType = (), string recursive = "false", string inherited = "true", string? locale = (), string includeLifecycle = "false", string includeAuditableEvents = "false", string includeDisplayConfigs = "false", string includeMappingTables = "false", string includeValueConstraints = "false", string includeAll = "false", string? dmlView = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/types`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "parent-type": parentType, "recursive": recursive, "inherited": inherited, "locale": locale, "include-lifecycle": includeLifecycle, "include-auditable-events": includeAuditableEvents, "include-display-configs": includeDisplayConfigs, "include-mapping-tables": includeMappingTables, "include-value-constraints": includeValueConstraints, "include-all": includeAll, "dml-view": dmlView};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Update the typeAssistValue
    #
    # + repositoryName - The repository name. 
    # + typeName - Specifies the name of the type. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + includedProperties - The property names to be included in the Response. The property names are comma separated. For example, included-properties=attr1,attr2,attr3 
    # + lifecycleId - The id of the lifecycle. 
    # + state - The state name of the lifecycle. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateTypeAssistValue(string repositoryName, string typeName, XmlAssistValuesRequest payload, string view = ":default", boolean links = true, string? includedProperties = (), string? lifecycleId = (), string? state = (), string? accept = (), string? contentType = ()) returns JsonAssistValuesResponse|error {
        string  path = string `/repositories/${repositoryName}/types/${typeName}/assist-values`;
        map<anydata> queryParam = {"view": view, "links": links, "included-properties": includedProperties, "lifecycle-id": lifecycleId, "state": state};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        JsonAssistValuesResponse response = check self.clientEp->post(path, request, headers = accHeaders, targetType=JsonAssistValuesResponse);
        return response;
    }
    # Get the type
    #
    # + repositoryName - The repository name. 
    # + 'type - Specifies the type name. 
    # + inherited - Specifies whether or not to include all of the properties of a type including the inherited properties from the parent type. 
    # + locale - The locale name. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + includeValueAssist - Specifies whether the Response includes the definition information of the value assist. 
    # + includeLifecycle - Specifies whether or not to get the type related information for the different lifecycles and states. 
    # + includeAuditableEvents - Specifies whether or not to get the type auditable system and app events. 
    # + includeDisplayConfigs - Specifies whether or not to get the type display configuration information. 
    # + includeMappingTables - Specifies whether or not to get the type and properties mapping table information. 
    # + includeValueConstraints - Specifies whether or not to get the type and properties value constraints information. 
    # + includeAll - Specifies whether or not to get all the type related information. 
    # + scopeConfig - Specifies whether to get type properties based on the specified scope and display configuration. The value you can set is the scope configuration name. The scope-configuration and the display-configuration must be provided together. 
    # + displayConfig - Specifies whether to get type properties based on the specified scope and display configuration. The value you can set is the display configuration display name. The scope-configuration and display-configuration must be provided together. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getType(string repositoryName, string 'type, string inherited = "true", string? locale = (), boolean links = true, string includeValueAssist = "false", string includeLifecycle = "false", string includeAuditableEvents = "false", string includeDisplayConfigs = "false", string includeMappingTables = "false", string includeValueConstraints = "false", string includeAll = "false", string? scopeConfig = (), string? displayConfig = (), string? accept = ()) returns JsonType|error {
        string  path = string `/repositories/${repositoryName}/'types/${'type}`;
        map<anydata> queryParam = {"inherited": inherited, "locale": locale, "links": links, "include-value-assist": includeValueAssist, "include-lifecycle": includeLifecycle, "include-auditable-events": includeAuditableEvents, "include-display-configs": includeDisplayConfigs, "include-mapping-tables": includeMappingTables, "include-value-constraints": includeValueConstraints, "include-all": includeAll, "scope-config": scopeConfig, "display-config": displayConfig};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        JsonType response = check self.clientEp-> get(path, accHeaders, targetType = JsonType);
        return response;
    }
    # Get the users
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getUsers(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/users`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the user
    #
    # + repositoryName - The repository name. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createUser(string repositoryName, UserBase payload, string? accept = (), string? contentType = ()) returns User|error {
        string  path = string `/repositories/${repositoryName}/users`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        User response = check self.clientEp->post(path, request, headers = accHeaders, targetType=User);
        return response;
    }
    # Get the user
    #
    # + repositoryName - The repository name. 
    # + userName - The encoded username. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getUser(string repositoryName, string userName, string view = ":default", boolean links = true, string? accept = ()) returns User|error {
        string  path = string `/repositories/${repositoryName}/users/${userName}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        User response = check self.clientEp-> get(path, accHeaders, targetType = User);
        return response;
    }
    # Update the user
    #
    # + repositoryName - The repository name. 
    # + userName - The encoded username. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateUser(string repositoryName, string userName, UserBase payload, string view = ":default", boolean links = true, string? accept = (), string? contentType = ()) returns User|error {
        string  path = string `/repositories/${repositoryName}/users/${userName}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        User response = check self.clientEp->post(path, request, headers = accHeaders, targetType=User);
        return response;
    }
    # Delete the user
    #
    # + repositoryName - The repository name. 
    # + userName - The encoded username. 
    # + return - Operation successfully 
    remote isolated function deleteUser(string repositoryName, string userName) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/users/${userName}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the defaultFolder
    #
    # + repositoryName - The repository name. 
    # + userName - The encoded username. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getDefaultFolder(string repositoryName, string userName, string view = ":default", boolean links = true, string? accept = ()) returns Folder|error {
        string  path = string `/repositories/${repositoryName}/users/${userName}/home`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Folder response = check self.clientEp-> get(path, accHeaders, targetType = Folder);
        return response;
    }
    # Get the userPermissionSet
    #
    # + repositoryName - The repository name. 
    # + userName - The encoded username. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getUserPermissionSet(string repositoryName, string userName, boolean links = true, string? accept = ()) returns PermissionSet|error {
        string  path = string `/repositories/${repositoryName}/users/${userName}/permission-set`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        PermissionSet response = check self.clientEp-> get(path, accHeaders, targetType = PermissionSet);
        return response;
    }
    # Get the virtualDocumentRelation
    #
    # + repositoryName - The repository name. 
    # + nodeId - The id of virtual document node, which is actually r_object_id of relation instance. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + objectIdQueryParam - The r_object_id of required sysobject. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getVirtualDocumentRelation(string repositoryName, string nodeId, boolean links = true, string? objectIdQueryParam = (), string? accept = ()) returns VdNode|error {
        string  path = string `/repositories/${repositoryName}/vd-relations/${nodeId}`;
        map<anydata> queryParam = {"links": links, "object-id-query-param": objectIdQueryParam};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        VdNode response = check self.clientEp-> get(path, accHeaders, targetType = VdNode);
        return response;
    }
    # Update the virtualDocumentRelation
    #
    # + repositoryName - The repository name. 
    # + nodeId - The id of virtual document node, which is actually r_object_id of relation instance. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateVirtualDocumentRelation(string repositoryName, string nodeId, VdNodeBase payload, string? accept = (), string? contentType = ()) returns VdNode|error {
        string  path = string `/repositories/${repositoryName}/vd-relations/${nodeId}`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        VdNode response = check self.clientEp->post(path, request, headers = accHeaders, targetType=VdNode);
        return response;
    }
    # Delete the virtualDocumentRelation
    #
    # + repositoryName - The repository name. 
    # + nodeId - The id of virtual document node, which is actually r_object_id of relation instance. 
    # + return - Operation successfully 
    remote isolated function deleteVirtualDocumentRelation(string repositoryName, string nodeId) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/vd-relations/${nodeId}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the workItem
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkItem(string repositoryName, string itemId, string view = ":default", boolean links = true, string? accept = ()) returns WorkItem|error {
        string  path = string `/repositories/${repositoryName}/work-items/${itemId}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        WorkItem response = check self.clientEp-> get(path, accHeaders, targetType = WorkItem);
        return response;
    }
    # Get the workflowTaskPackages
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkflowTaskPackages(string repositoryName, string itemId, boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/work-items/${itemId}/packages`;
        map<anydata> queryParam = {"inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the workflowTaskPackage
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + index - The index of the package in the workflow task packages. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkflowTaskPackage(string repositoryName, string itemId, string index, boolean links = true, string? accept = ()) returns WorkflowTaskPackageResponse|error {
        string  path = string `/repositories/${repositoryName}/work-items/${itemId}/packages/${index}`;
        map<anydata> queryParam = {"links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        WorkflowTaskPackageResponse response = check self.clientEp-> get(path, accHeaders, targetType = WorkflowTaskPackageResponse);
        return response;
    }
    # Update the workflowTaskPackage
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + index - The index of the package in the workflow task packages. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateWorkflowTaskPackage(string repositoryName, string itemId, string index, WorkflowTaskPackageRequest payload, string? accept = (), string? contentType = ()) returns WorkflowTaskPackageResponse|error {
        string  path = string `/repositories/${repositoryName}/work-items/${itemId}/packages/${index}`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        WorkflowTaskPackageResponse response = check self.clientEp->post(path, request, headers = accHeaders, targetType=WorkflowTaskPackageResponse);
        return response;
    }
    # Delete the workflowTaskPackageDocuments
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + index - The index of the package in the workflow task packages. 
    # + return - Operation successfully 
    remote isolated function deleteWorkflowTaskPackageDocuments(string repositoryName, string itemId, string index) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/work-items/${itemId}/packages/${index}/documents`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Delete the workflowTaskPackageNote
    #
    # + repositoryName - The repository name. 
    # + itemId - The object id of the inbox item. 
    # + index - The index of the package in the workflow task packages. 
    # + noteId - The id of the workflow task package's note. 
    # + return - Operation successfully 
    remote isolated function deleteWorkflowTaskPackageNote(string repositoryName, string itemId, string index, string noteId) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/work-items/${itemId}/packages/${index}/notes/${noteId}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the workQueues
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + userName - Specifies the login name of user to whom the work queues belong. Defaults to currently loggged in user. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkQueues(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? userName = (), string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/work-queues`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links, "user-name": userName};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the workQueue
    #
    # + repositoryName - The repository name. 
    # + queueId - The object id of the work queue. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkQueue(string repositoryName, string queueId, string view = ":default", boolean links = true, string? accept = ()) returns WorkQueue|error {
        string  path = string `/repositories/${repositoryName}/work-queues/${queueId}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        WorkQueue response = check self.clientEp-> get(path, accHeaders, targetType = WorkQueue);
        return response;
    }
    # Get the workflowActivity
    #
    # + repositoryName - The repository name. 
    # + activityId - The object id of the workflow activity. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkflowActivity(string repositoryName, string activityId, string view = ":default", boolean links = true, string? accept = ()) returns WorkflowActivity|error {
        string  path = string `/repositories/${repositoryName}/workflow-activities/${activityId}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        WorkflowActivity response = check self.clientEp-> get(path, accHeaders, targetType = WorkflowActivity);
        return response;
    }
    # Get the workflowTemplates
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkflowTemplates(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/workflow-templates`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the workflowTemplate
    #
    # + repositoryName - The repository name. 
    # + templateId - The object id of the workflow template. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkflowTemplate(string repositoryName, string templateId, string view = ":default", boolean links = true, string? accept = ()) returns WorkflowTemplate|error {
        string  path = string `/repositories/${repositoryName}/workflow-templates/${templateId}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        WorkflowTemplate response = check self.clientEp-> get(path, accHeaders, targetType = WorkflowTemplate);
        return response;
    }
    # Put the workflowTemplate
    #
    # + repositoryName - The repository name. 
    # + templateId - The object id of the workflow template. 
    # + action - Specifies what action will be done on the workflow template, currently, only these actions are supported, VALIDATE,INSTALL,INVALIDATE,UNINSTALL. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putWorkflowTemplate(string repositoryName, string templateId, string action, string? accept = (), string? contentType = ()) returns WorkflowTemplate|error {
        string  path = string `/repositories/${repositoryName}/workflow-templates/${templateId}`;
        map<anydata> queryParam = {"action": action};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        //TODO: Update the request as needed;
        WorkflowTemplate response = check self.clientEp-> put(path, request, headers = accHeaders, targetType = WorkflowTemplate);
        return response;
    }
    # Update the workflowTemplate
    #
    # + repositoryName - The repository name. 
    # + templateId - The object id of the workflow template. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateWorkflowTemplate(string repositoryName, string templateId, WorkflowTemplateBase payload, string? accept = (), string? contentType = ()) returns WorkflowTemplate|error {
        string  path = string `/repositories/${repositoryName}/workflow-templates/${templateId}`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        WorkflowTemplate response = check self.clientEp->post(path, request, headers = accHeaders, targetType=WorkflowTemplate);
        return response;
    }
    # Get the workflowActivities
    #
    # + repositoryName - The repository name. 
    # + templateId - The object id of the workflow template. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkflowActivities(string repositoryName, string templateId, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/workflow-templates/${templateId}/activities`;
        map<anydata> queryParam = {"view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Get the workflows
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkflows(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/workflows`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the workflow
    #
    # + repositoryName - The repository name. 
    # + quickFlow - Specifies whether to start an ad-hoc workflow or start a workflow from template. * 'true', would creates and starts an ad-hoc workflow to route objects to users and/or groups. * 'false', would creates and starts a workflow from the template. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createWorkflow(string repositoryName, WorkflowsRequestBase payload, string? quickFlow = (), string? accept = (), string? contentType = ()) returns Workflow|error {
        string  path = string `/repositories/${repositoryName}/workflows`;
        map<anydata> queryParam = {"quick-flow": quickFlow};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        Workflow response = check self.clientEp->post(path, request, headers = accHeaders, targetType=Workflow);
        return response;
    }
    # Get the workflow
    #
    # + repositoryName - The repository name. 
    # + workflowId - The object id of the workflow instance. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkflow(string repositoryName, string workflowId, string view = ":default", boolean links = true, string? accept = ()) returns Workflow|error {
        string  path = string `/repositories/${repositoryName}/workflows/${workflowId}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Workflow response = check self.clientEp-> get(path, accHeaders, targetType = Workflow);
        return response;
    }
    # Put the workflow
    #
    # + repositoryName - The repository name. 
    # + workflowId - The object id of the workflow instance. 
    # + action - Specifies what action will be done on the workflow instance, currently, only these actions are supported, RESTART,RESTART-ALL,HALT,HALT-ALL,RESUME,RESUME-ALL,ABORT,CHANGE-SUPERVISOR. 
    # + activity - Specifies the activity name. 
    # + supervisor - Specifies the new supervisor name when action is CHANGE-SUPERVISOR. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putWorkflow(string repositoryName, string workflowId, string action, string? activity = (), string? supervisor = (), string? accept = (), string? contentType = ()) returns Workflow|error {
        string  path = string `/repositories/${repositoryName}/workflows/${workflowId}`;
        map<anydata> queryParam = {"action": action, "activity": activity, "supervisor": supervisor};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        //TODO: Update the request as needed;
        Workflow response = check self.clientEp-> put(path, request, headers = accHeaders, targetType = Workflow);
        return response;
    }
    # Get the workflowAttachments
    #
    # + repositoryName - The repository name. 
    # + workflowId - The object id of the workflow instance. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkflowAttachments(string repositoryName, string workflowId, boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/workflows/${workflowId}/attachments`;
        map<anydata> queryParam = {"inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Create the workflowAttachment
    #
    # + repositoryName - The repository name. 
    # + workflowId - The object id of the workflow instance. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createWorkflowAttachment(string repositoryName, string workflowId, WorkflowAttachmentsRequestBase payload, string? accept = (), string? contentType = ()) returns WorkflowAttachmentResponse|error {
        string  path = string `/repositories/${repositoryName}/workflows/${workflowId}/attachments`;
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        WorkflowAttachmentResponse response = check self.clientEp->post(path, request, headers = accHeaders, targetType=WorkflowAttachmentResponse);
        return response;
    }
    # Delete the workflowAttachment
    #
    # + repositoryName - The repository name. 
    # + workflowId - The object id of the workflow instance. 
    # + id - The r_object_id of queried object. 
    # + return - Operation successfully 
    remote isolated function deleteWorkflowAttachment(string repositoryName, string workflowId, string id) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/workflows/${workflowId}/attachments/${id}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the workItems
    #
    # + repositoryName - The repository name. 
    # + workflowId - The object id of the workflow instance. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + filter - A filter expression in a subset of XPath. 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getWorkItems(string repositoryName, string workflowId, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? filter = (), string? sort = (), boolean inline = false, boolean links = true, string? accept = ()) returns Feed|error {
        string  path = string `/repositories/${repositoryName}/workflows/${workflowId}/work-items`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "filter": filter, "sort": sort, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        Feed response = check self.clientEp-> get(path, accHeaders, targetType = Feed);
        return response;
    }
    # Execute simple search across repositories
    #
    # + 'start - Defines the start index of result range for each target repository. 
    # + 'limit - Defines the maximum of result range for each target repository. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + objectType - The type of the queried object. 
    # + collections - Specifies a list of collections separated by comma (,). to which the query is scoped. The collections must exist in xPlore. 
    # + facet - Specifies the property to be used as facet. 
    # + timezone - Indicates the time zone used to compute date facets. Valid time zones include (case-insensitive): - Abbreviation, such as GMT and UTC - Full names, such as America/Los_Angeles - Custom time zones, such as GMT-8:00 
    # + q - Specifies the search criterion with a full-text expression in Simple Search Language. Parameter q must be encoded because it may contain non-English locale characters. International characters that are used in this query parameter must be sent with URL encoded by the UTF-8 charset. Otherwise, the result may be incorrect. 
    # + facetValueConstraints - Specifies a property constraint expression. For example, when facet is set to r_object_type facet-value-constraints is set to dm_object, only dm_object instances are returned. You can use boolean operators + for AND and | for OR in a property constraint expression to define more complex constraints. For example, the expression dm_object|dm_folder returns both dm_object and dm_folder instances. Parameter facet-value-constraints must be encoded because it may contain non-English locale characters. International characters that are used in this query parameter must be sent with URL encoded by the UTF-8 charset. Otherwise, the result may be incorrect. 
    # + facetIdConstraints - Contains the key value pairs for each facet id and its constraint. The id should comply with the facet id in the AQL. 
    # + queryLocale - A locale used to evaluate the query and parse word into language dependent token. Only supported with xPlore. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getFederatedSearch(int 'start = 1, int 'limit = 100, boolean includeTotal = false, string view = ":default", string? sort = (), boolean inline = false, boolean links = true, string? objectType = (), string? collections = (), string? facet = (), string timezone = "GMT", string? q = (), string? facetValueConstraints = (), string? facetIdConstraints = (), string queryLocale = "en", string? accept = ()) returns FederatedSearchResultsFeed|error {
        string  path = string `/search`;
        map<anydata> queryParam = {"start": 'start, "limit": 'limit, "include-total": includeTotal, "view": view, "sort": sort, "inline": inline, "links": links, "object-type": objectType, "collections": collections, "facet": facet, "timezone": timezone, "q": q, "facet-value-constraints": facetValueConstraints, "facet-id-constraints": facetIdConstraints, "query-locale": queryLocale};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        FederatedSearchResultsFeed response = check self.clientEp-> get(path, accHeaders, targetType = FederatedSearchResultsFeed);
        return response;
    }
    # Execute AQL search across repositories
    #
    # + 'start - Defines the start index of result range for each target repository. 
    # + 'limit - Defines the maximum of result range for each target repository. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + facetIdConstraints - Contains the key value pairs for each facet id and its constraint. The id should comply with the facet id in the AQL. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createFederatedSearch(SearchQuery payload, int 'start = 1, int 'limit = 100, boolean includeTotal = false, boolean inline = false, boolean links = true, string? facetIdConstraints = (), string? accept = (), string? contentType = ()) returns FederatedSearchResultsFeed|error {
        string  path = string `/search`;
        map<anydata> queryParam = {"start": 'start, "limit": 'limit, "include-total": includeTotal, "inline": inline, "links": links, "facet-id-constraints": facetIdConstraints};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        FederatedSearchResultsFeed response = check self.clientEp->post(path, request, headers = accHeaders, targetType=FederatedSearchResultsFeed);
        return response;
    }
    # Execute simple search
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + sort - Sorting for entries in collection result. A sort consists of multiple sort specifications, separated by comma (','). Each sort specification consists of an attribute to be sorted and its sort order, separated by the spacpe (' '). Sort order can be either DESC orASC, case insensitive. Sort order is optional, if not specified, the default sort order isASC. Optionally it can be specified with non-repeating attributes. Sort order can be forced to be in case insensitive mode, with the hint no-case. Whether the default sort is in case sensitive mode or not is determined by the database. Example: sort=r_modify_date desc,object_name asc no-case,title. If any attribute with invalid name is specified, error will be thrown. 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + objectType - The type of the queried object. 
    # + collections - Specifies a list of collections separated by comma (,). to which the query is scoped. The collections must exist in xPlore. 
    # + facet - Specifies the property to be used as facet. 
    # + timezone - Indicates the time zone used to compute date facets. Valid time zones include (case-insensitive): - Abbreviation, such as GMT and UTC - Full names, such as America/Los_Angeles - Custom time zones, such as GMT-8:00 
    # + q - Specifies the search criterion with a full-text expression in Simple Search Language. Parameter q must be encoded because it may contain non-English locale characters. International characters that are used in this query parameter must be sent with URL encoded by the UTF-8 charset. Otherwise, the result may be incorrect. 
    # + locations - Specifies a list of folder paths separated by comma (,) to which the query is scoped. Parameter locations must be encoded because it may contain non-English locale characters. International characters that are used in this query parameter must be sent with URL encoded by the UTF-8 charset. Otherwise, the result may be incorrect. 
    # + facetValueConstraints - Specifies a property constraint expression. For example, when facet is set to r_object_type facet-value-constraints is set to dm_object, only dm_object instances are returned. You can use boolean operators + for AND and | for OR in a property constraint expression to define more complex constraints. For example, the expression dm_object|dm_folder returns both dm_object and dm_folder instances. Parameter facet-value-constraints must be encoded because it may contain non-English locale characters. International characters that are used in this query parameter must be sent with URL encoded by the UTF-8 charset. Otherwise, the result may be incorrect. 
    # + facetIdConstraints - Contains the key value pairs for each facet id and its constraint. The id should comply with the facet id in the AQL. 
    # + queryLocale - A locale used to evaluate the query and parse word into language dependent token. Only supported with xPlore. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSearch(string repositoryName, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, string view = ":default", string? sort = (), boolean inline = false, boolean links = true, string? objectType = (), string? collections = (), string? facet = (), string timezone = "GMT", string? q = (), string? locations = (), string? facetValueConstraints = (), string? facetIdConstraints = (), string queryLocale = "en", string? accept = ()) returns SearchResultsFeed|error {
        string  path = string `/repositories/${repositoryName}/search`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "view": view, "sort": sort, "inline": inline, "links": links, "object-type": objectType, "collections": collections, "facet": facet, "timezone": timezone, "q": q, "locations": locations, "facet-value-constraints": facetValueConstraints, "facet-id-constraints": facetIdConstraints, "query-locale": queryLocale};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        SearchResultsFeed response = check self.clientEp-> get(path, accHeaders, targetType = SearchResultsFeed);
        return response;
    }
    # Execute AQL search
    #
    # + repositoryName - The repository name. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + facetIdConstraints - Contains the key value pairs for each facet id and its constraint. The id should comply with the facet id in the AQL. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createSearch(string repositoryName, SearchQuery payload, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, boolean inline = false, boolean links = true, string? facetIdConstraints = (), string? accept = (), string? contentType = ()) returns SearchResultsFeed|error {
        string  path = string `/repositories/${repositoryName}/search`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "inline": inline, "links": links, "facet-id-constraints": facetIdConstraints};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        SearchResultsFeed response = check self.clientEp->post(path, request, headers = accHeaders, targetType=SearchResultsFeed);
        return response;
    }
    # Get the saved search
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSavedSearch(string repositoryName, string id, string view = ":default", boolean links = true, string? accept = ()) returns SavedSearch|error {
        string  path = string `/repositories/${repositoryName}/saved-searches/${id}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        SavedSearch response = check self.clientEp-> get(path, accHeaders, targetType = SavedSearch);
        return response;
    }
    # Update the saved search
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + queryLocale - A locale used to evaluate the query and parse word into language dependent token. Only supported with xPlore. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function updateSavedSearch(string repositoryName, string id, SavedSearchBase payload, string queryLocale = "en", string? accept = (), string? contentType = ()) returns SavedSearch|error {
        string  path = string `/repositories/${repositoryName}/saved-searches/${id}`;
        map<anydata> queryParam = {"query-locale": queryLocale};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        SavedSearch response = check self.clientEp->post(path, request, headers = accHeaders, targetType=SavedSearch);
        return response;
    }
    # Delete the saved search
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + return - Operation successfully 
    remote isolated function deleteSavedSearch(string repositoryName, string id) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/saved-searches/${id}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Get the search template
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + view - Properties to return. The pattern is like:?view=(:view-name)?(,column)*. (:view-name) and (,columns)* must be mutually exclusive names of predefined views start with colon (':'). The following view-name are defined: :all :default If no view-name is specified, names of properties or predefined views should be returned, separated by comma (','). 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSearchTemplate(string repositoryName, string id, string view = ":default", boolean links = true, string? accept = ()) returns SearchTemplate|error {
        string  path = string `/repositories/${repositoryName}/search-templates/${id}`;
        map<anydata> queryParam = {"view": view, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        SearchTemplate response = check self.clientEp-> get(path, accHeaders, targetType = SearchTemplate);
        return response;
    }
    # Delete the search template
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + return - Operation successfully 
    remote isolated function deleteSearchTemplate(string repositoryName, string id) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/search-templates/${id}`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
    # Execute the saved search
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + facetIdConstraints - Contains the key value pairs for each facet id and its constraint. The id should comply with the facet id in the AQL. 
    # + queryLocale - A locale used to evaluate the query and parse word into language dependent token. Only supported with xPlore. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSavedSearchExecution(string repositoryName, string id, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, boolean inline = false, boolean links = true, string? facetIdConstraints = (), string queryLocale = "en", string? accept = ()) returns SearchResultsFeed|error {
        string  path = string `/repositories/${repositoryName}/saved-searches/${id}/execution`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "inline": inline, "links": links, "facet-id-constraints": facetIdConstraints, "query-locale": queryLocale};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        SearchResultsFeed response = check self.clientEp-> get(path, accHeaders, targetType = SearchResultsFeed);
        return response;
    }
    # Execute the search template
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + facetIdConstraints - Contains the key value pairs for each facet id and its constraint. The id should comply with the facet id in the AQL. 
    # + queryLocale - A locale used to evaluate the query and parse word into language dependent token. Only supported with xPlore. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function createSearchTemplateExecution(string repositoryName, string id, SearchTemplate payload, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, boolean inline = false, boolean links = true, string? facetIdConstraints = (), string queryLocale = "en", string? accept = (), string? contentType = ()) returns SearchResultsFeed|error {
        string  path = string `/repositories/${repositoryName}/search-templates/${id}/execution`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "inline": inline, "links": links, "facet-id-constraints": facetIdConstraints, "query-locale": queryLocale};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        xml? xmlBody = check xmldata:fromJson(jsonBody);
        request.setPayload(xmlBody);
        SearchResultsFeed response = check self.clientEp->post(path, request, headers = accHeaders, targetType=SearchResultsFeed);
        return response;
    }
    # Get the saved search results
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + accept - The Accept header. 
    # + return - Operation successfully 
    remote isolated function getSavedSearchResults(string repositoryName, string id, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, boolean inline = false, boolean links = true, string? accept = ()) returns SearchResultsFeed|error {
        string  path = string `/repositories/${repositoryName}/saved-searches/${id}/results`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "inline": inline, "links": links};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        SearchResultsFeed response = check self.clientEp-> get(path, accHeaders, targetType = SearchResultsFeed);
        return response;
    }
    # Enable and refresh the saved search results
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + itemsPerPage - The number of entries per page. When the result feed is paged, the attribute items-per-page will be displayed in the feed. 
    # + page - The number of the page to be served. When the result feed is paged, the attribute page will be displayed in the feed. 
    # + includeTotal - Indicate to calculate the total count of the feed items as though not returning them all in one page. When the result feed is paged, the attribute include-total will be displayed in the feed. * true - the total count of feed items is calculated by server and returned * false - neither calculate nor return the total count 
    # + inline - Ensures whether to show content (the object instance) in the atom entry for a collection. * 'true', return object instance and embed object instance into entry's content element. * 'false', do not return object instance within entry's content. 
    # + links - Ensures whether link relations to be returned for this object representation. * 'true', return links for the object. * 'false' do not return links for the object. 
    # + maxResultsCount - The maximum number of results to for a saved search When -1 is used as the value for the max-results-count parameter, the Request may require more time to retrieve as many matching objects as possible. The number of matching objects returned is only limited by the DFC configuration. Using a default value of 1000 , which returns 10 pages at once by default, greatly improves performance. -1: Apply the DFC configuration Any non-negative integer: the smaller of max-results -count and DFC configuration takes effect. 
    # + accept - The Accept header. 
    # + contentType - The Content-Type header. 
    # + return - Operation successfully 
    remote isolated function putSavedSearchResult(string repositoryName, string id, int itemsPerPage = 100, int page = 1, boolean includeTotal = false, boolean inline = false, boolean links = true, int maxResultsCount = 1000, string? accept = (), string? contentType = ()) returns SearchResultsFeed|error {
        string  path = string `/repositories/${repositoryName}/saved-searches/${id}/results`;
        map<anydata> queryParam = {"items-per-page": itemsPerPage, "page": page, "include-total": includeTotal, "inline": inline, "links": links, "max-results-count": maxResultsCount};
        path = path + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Accept": accept, "Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        //TODO: Update the request as needed;
        SearchResultsFeed response = check self.clientEp-> put(path, request, headers = accHeaders, targetType = SearchResultsFeed);
        return response;
    }
    # Delete the savedSearchResults
    #
    # + repositoryName - The repository name. 
    # + id - The r_object_id of queried object. 
    # + return - Operation successfully 
    remote isolated function deleteSavedSearchResults(string repositoryName, string id) returns http:Response|error {
        string  path = string `/repositories/${repositoryName}/saved-searches/${id}/results`;
        http:Response response = check self.clientEp-> delete(path, targetType = http:Response);
        return response;
    }
}

# Generate query path with query parameter.
#
# + queryParam - Query parameter map 
# + return - Returns generated Path or error at failure of client initialization 
isolated function  getPathForQueryParam(map<anydata> queryParam)  returns  string|error {
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

# Generate header map for given header values.
#
# + headerParam - Headers  map 
# + return - Returns generated map or error at failure of client initialization 
isolated function  getMapForHeaders(map<any> headerParam)  returns  map<string|string[]> {
    map<string|string[]> headerMap = {};
    foreach  var [key, value] in  headerParam.entries() {
        if  value  is  string ||  value  is  string[] {
            headerMap[key] = value;
        }
    }
    return headerMap;
}
