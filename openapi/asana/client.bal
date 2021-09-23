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

# Configuration for Asana connector
#
# + authConfig - BearerTokenConfig or OAuth2 Refresh Token Grant Configuration
# + secureSocketConfig - SSL connection configuration
public type ClientConfig record {
    http:BearerTokenConfig|http:OAuth2RefreshTokenGrantConfig authConfig;
    http:ClientSecureSocket secureSocketConfig?;
};

# This is the interface for interacting with the [Asana Platform](https://developers.asana.com). Our API reference is generated from our [OpenAPI spec] (https://raw.githubusercontent.com/Asana/developer-docs/master/defs/asana_oas.yaml).
#
# + clientEp - Connector http endpoint
public client class Client {
    http:Client clientEp;
    # Client initialization.
    #
    # + clientConfig - Client configuration details
    # + serviceUrl - Connector server URL
    # + return - Returns error at failure of client initialization
    public isolated function init(ClientConfig clientConfig, string serviceUrl = "https://app.asana.com/api/1.0") returns error? {
        http:ClientSecureSocket? secureSocketConfig = clientConfig?.secureSocketConfig;
        http:Client httpEp = check new (serviceUrl, { auth: clientConfig.authConfig, secureSocket: secureSocketConfig });
        self.clientEp = httpEp;
    }
    # Get an attachment
    #
    # + attachment_gid - Globally unique identifier for the attachment.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the record for a single attachment.
    remote isolated function getAttachment(string attachment_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse200|error {
        string  path = string `/attachments/${attachment_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse200 response = check self.clientEp-> get(path, targetType = InlineResponse200);
        return response;
    }
    # Delete an attachment
    #
    # + attachment_gid - Globally unique identifier for the attachment.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully deleted the specified attachment.
    remote isolated function deleteAttachment(string attachment_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/attachments/${attachment_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Submit parallel requests
    #
    # + payload - The requests to batch together via the Batch API.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully completed the requested batch API operations.
    remote isolated function createBatchRequest(Body payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2002|error {
        string  path = string `/batch`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2002 response = check self.clientEp->post(path, request, targetType=InlineResponse2002);
        return response;
    }
    # Create a custom field
    #
    # + payload - The custom field object to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Custom field successfully created.
    remote isolated function createCustomField(Body1 payload, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse201|error {
        string  path = string `/custom_fields`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse201 response = check self.clientEp->post(path, request, targetType=InlineResponse201);
        return response;
    }
    # Get a custom field
    #
    # + custom_field_gid - Globally unique identifier for the custom field.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the complete definition of a custom field’s metadata.
    remote isolated function getCustomField(string custom_field_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse201|error {
        string  path = string `/custom_fields/${custom_field_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse201 response = check self.clientEp-> get(path, targetType = InlineResponse201);
        return response;
    }
    # Update a custom field
    #
    # + custom_field_gid - Globally unique identifier for the custom field.
    # + payload - The custom field object with all updated properties.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - The custom field was successfully updated.
    remote isolated function updateCustomField(string custom_field_gid, Body2 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse201|error {
        string  path = string `/custom_fields/${custom_field_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse201 response = check self.clientEp->put(path, request, targetType=InlineResponse201);
        return response;
    }
    # Delete a custom field
    #
    # + custom_field_gid - Globally unique identifier for the custom field.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - The custom field was successfully deleted.
    remote isolated function deleteCustomField(string custom_field_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/custom_fields/${custom_field_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Create an enum option
    #
    # + custom_field_gid - Globally unique identifier for the custom field.
    # + payload - The enum option object to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Custom field enum option successfully created.
    remote isolated function createEnumOptionForCustomField(string custom_field_gid, Body3 payload, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2011|error {
        string  path = string `/custom_fields/${custom_field_gid}/enum_options`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2011 response = check self.clientEp->post(path, request, targetType=InlineResponse2011);
        return response;
    }
    # Reorder a custom field's enum
    #
    # + custom_field_gid - Globally unique identifier for the custom field.
    # + payload - The enum option object to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Custom field enum option successfully reordered.
    remote isolated function insertEnumOptionForCustomField(string custom_field_gid, Body4 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2011|error {
        string  path = string `/custom_fields/${custom_field_gid}/enum_options/insert`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2011 response = check self.clientEp->post(path, request, targetType=InlineResponse2011);
        return response;
    }
    # Update an enum option
    #
    # + enum_option_gid - Globally unique identifier for the enum option.
    # + payload - The enum option object to update
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully updated the specified custom field enum.
    remote isolated function updateEnumOption(string enum_option_gid, Body5 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2011|error {
        string  path = string `/enum_options/${enum_option_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2011 response = check self.clientEp->put(path, request, targetType=InlineResponse2011);
        return response;
    }
    # Get events on a resource
    #
    # + 'resource - A resource ID to subscribe to. The resource can be a task or project.
    # + sync - A sync token received from the last request, or none on first sync. Events will be returned from the point in time that the sync token was generated.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved events.
    remote isolated function getEvents(string 'resource, string? sync = (), boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2003|error {
        string  path = string `/events`;
        map<anydata> queryParam = {"resource": 'resource, "sync": sync, "opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2003 response = check self.clientEp-> get(path, targetType = InlineResponse2003);
        return response;
    }
    # Get a job by id
    #
    # + job_gid - Globally unique identifier for the job.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved Job.
    remote isolated function getJob(string job_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2004|error {
        string  path = string `/jobs/${job_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2004 response = check self.clientEp-> get(path, targetType = InlineResponse2004);
        return response;
    }
    # Create an organization export request
    #
    # + payload - The organization to export.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully created organization export request.
    remote isolated function createOrganizationExport(Body6 payload, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2012|error {
        string  path = string `/organization_exports`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2012 response = check self.clientEp->post(path, request, targetType=InlineResponse2012);
        return response;
    }
    # Get details on an org export request
    #
    # + organization_export_gid - Globally unique identifier for the organization export.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved organization export object.
    remote isolated function getOrganizationExport(string organization_export_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2012|error {
        string  path = string `/organization_exports/${organization_export_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2012 response = check self.clientEp-> get(path, targetType = InlineResponse2012);
        return response;
    }
    # Get teams in an organization
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Returns the team records for all teams in the organization or workspace accessible to the authenticated user.
    remote isolated function getTeamsForOrganization(string workspace_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2005|error {
        string  path = string `/organizations/${workspace_gid}/teams`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2005 response = check self.clientEp-> get(path, targetType = InlineResponse2005);
        return response;
    }
    # Get multiple portfolio memberships
    #
    # + portfolio - The portfolio to filter results on.
    # + workspace - The workspace to filter results on.
    # + user - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved portfolio memberships.
    remote isolated function getPortfolioMemberships(string? portfolio = (), string? workspace = (), string? user = (), boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2006|error {
        string  path = string `/portfolio_memberships`;
        map<anydata> queryParam = {"portfolio": portfolio, "workspace": workspace, "user": user, "opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2006 response = check self.clientEp-> get(path, targetType = InlineResponse2006);
        return response;
    }
    # Get a portfolio membership
    #
    # + portfolio_membership_gid - Globally unique identifier for the portfolio membership
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the requested portfolio membership.
    remote isolated function getPortfolioMembership(string portfolio_membership_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2007|error {
        string  path = string `/portfolio_memberships/${portfolio_membership_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2007 response = check self.clientEp-> get(path, targetType = InlineResponse2007);
        return response;
    }
    # Get multiple portfolios
    #
    # + workspace - The workspace or organization to filter portfolios on.
    # + owner - The user who owns the portfolio. Currently, API users can only get a list of portfolios that they themselves own.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved portfolios.
    remote isolated function getPortfolios(string workspace, string owner, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2008|error {
        string  path = string `/portfolios`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "workspace": workspace, "owner": owner};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2008 response = check self.clientEp-> get(path, targetType = InlineResponse2008);
        return response;
    }
    # Create a portfolio
    #
    # + payload - The portfolio to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created portfolio.
    remote isolated function createPortfolio(Body7 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2013|error {
        string  path = string `/portfolios`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2013 response = check self.clientEp->post(path, request, targetType=InlineResponse2013);
        return response;
    }
    # Get a portfolio
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the requested portfolio.
    remote isolated function getPortfolio(string portfolio_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2013|error {
        string  path = string `/portfolios/${portfolio_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2013 response = check self.clientEp-> get(path, targetType = InlineResponse2013);
        return response;
    }
    # Update a portfolio
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + payload - The updated fields for the portfolio.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully updated the portfolio.
    remote isolated function updatePortfolio(string portfolio_gid, Body8 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2013|error {
        string  path = string `/portfolios/${portfolio_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2013 response = check self.clientEp->put(path, request, targetType=InlineResponse2013);
        return response;
    }
    # Delete a portfolio
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully deleted the specified portfolio.
    remote isolated function deletePortfolio(string portfolio_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/portfolios/${portfolio_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Add a custom field to a portfolio
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + payload - Information about the custom field setting.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + return - Successfully added the custom field to the portfolio.
    remote isolated function addCustomFieldSettingForPortfolio(string portfolio_gid, Body9 payload, boolean? optPretty = ()) returns InlineResponse2001|error {
        string  path = string `/portfolios/${portfolio_gid}/addCustomFieldSetting`;
        map<anydata> queryParam = {"opt_pretty": optPretty};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Add a portfolio item
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + payload - Information about the item being inserted.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully added the item to the portfolio.
    remote isolated function addItemForPortfolio(string portfolio_gid, Body10 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/portfolios/${portfolio_gid}/addItem`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Add users to a portfolio
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + payload - Information about the members being added.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully added members to the portfolio.
    remote isolated function addMembersForPortfolio(string portfolio_gid, Body11 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/portfolios/${portfolio_gid}/addMembers`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Get a portfolio's custom fields
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved custom field settings objects for a portfolio.
    remote isolated function getCustomFieldSettingsForPortfolio(string portfolio_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2009|error {
        string  path = string `/portfolios/${portfolio_gid}/custom_field_settings`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2009 response = check self.clientEp-> get(path, targetType = InlineResponse2009);
        return response;
    }
    # Get portfolio items
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested portfolio's items.
    remote isolated function getItemsForPortfolio(string portfolio_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20010|error {
        string  path = string `/portfolios/${portfolio_gid}/items`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20010 response = check self.clientEp-> get(path, targetType = InlineResponse20010);
        return response;
    }
    # Get memberships from a portfolio
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + user - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested portfolio's memberships.
    remote isolated function getPortfolioMembershipsForPortfolio(string portfolio_gid, string? user = (), boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2006|error {
        string  path = string `/portfolios/${portfolio_gid}/portfolio_memberships`;
        map<anydata> queryParam = {"user": user, "opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2006 response = check self.clientEp-> get(path, targetType = InlineResponse2006);
        return response;
    }
    # Remove a custom field from a portfolio
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + payload - Information about the custom field setting being removed.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + return - Successfully removed the custom field from the portfolio.
    remote isolated function removeCustomFieldSettingForPortfolio(string portfolio_gid, Body12 payload, boolean? optPretty = ()) returns InlineResponse2001|error {
        string  path = string `/portfolios/${portfolio_gid}/removeCustomFieldSetting`;
        map<anydata> queryParam = {"opt_pretty": optPretty};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Remove a portfolio item
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + payload - Information about the item being removed.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully removed the item from the portfolio.
    remote isolated function removeItemForPortfolio(string portfolio_gid, Body13 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/portfolios/${portfolio_gid}/removeItem`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Remove users from a portfolio
    #
    # + portfolio_gid - Globally unique identifier for the portfolio.
    # + payload - Information about the members being removed.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully removed the members from the portfolio.
    remote isolated function removeMembersForPortfolio(string portfolio_gid, Body14 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/portfolios/${portfolio_gid}/removeMembers`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Get a project membership
    #
    # + project_membership_gid - Globally unique identifier for the project membership.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the requested project membership.
    remote isolated function getProjectMembership(string project_membership_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20011|error {
        string  path = string `/project_memberships/${project_membership_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20011 response = check self.clientEp-> get(path, targetType = InlineResponse20011);
        return response;
    }
    # Get a project status
    #
    # + project_status_gid - The project status update to get.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the specified project's status updates.
    remote isolated function getProjectStatus(string project_status_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20012|error {
        string  path = string `/project_statuses/${project_status_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20012 response = check self.clientEp-> get(path, targetType = InlineResponse20012);
        return response;
    }
    # Delete a project status
    #
    # + project_status_gid - The project status update to get.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully deleted the specified project status.
    remote isolated function deleteProjectStatus(string project_status_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/project_statuses/${project_status_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Get multiple projects
    #
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + workspace - The workspace or organization to filter projects on.
    # + team - The team to filter projects on.
    # + archived - Only return projects whose `archived` field takes on the value of this parameter.
    # + return - Successfully retrieved projects.
    remote isolated function getProjects(boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = (), string? workspace = (), string? team = (), boolean? archived = ()) returns InlineResponse20010|error {
        string  path = string `/projects`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "workspace": workspace, "team": team, "archived": archived};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20010 response = check self.clientEp-> get(path, targetType = InlineResponse20010);
        return response;
    }
    # Create a project
    #
    # + payload - The project to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved projects.
    remote isolated function createProject(Body15 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2014|error {
        string  path = string `/projects`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2014 response = check self.clientEp->post(path, request, targetType=InlineResponse2014);
        return response;
    }
    # Get a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the requested project.
    remote isolated function getProject(string project_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2014|error {
        string  path = string `/projects/${project_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2014 response = check self.clientEp-> get(path, targetType = InlineResponse2014);
        return response;
    }
    # Update a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - The updated fields for the project.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully updated the project.
    remote isolated function updateProject(string project_gid, Body16 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2014|error {
        string  path = string `/projects/${project_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2014 response = check self.clientEp->put(path, request, targetType=InlineResponse2014);
        return response;
    }
    # Delete a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully deleted the specified project.
    remote isolated function deleteProject(string project_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/projects/${project_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Add a custom field to a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - Information about the custom field setting.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + return - Successfully added the custom field to the project.
    remote isolated function addCustomFieldSettingForProject(string project_gid, Body17 payload, boolean? optPretty = ()) returns InlineResponse20013|error {
        string  path = string `/projects/${project_gid}/addCustomFieldSetting`;
        map<anydata> queryParam = {"opt_pretty": optPretty};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20013 response = check self.clientEp->post(path, request, targetType=InlineResponse20013);
        return response;
    }
    # Add followers to a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - Information about the followers being added.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully added followers to the project.
    remote isolated function addFollowersForProject(string project_gid, Body18 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/projects/${project_gid}/addFollowers`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Add users to a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - Information about the members being added.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully added members to the project.
    remote isolated function addMembersForProject(string project_gid, Body19 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/projects/${project_gid}/addMembers`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Get a project's custom fields
    #
    # + project_gid - Globally unique identifier for the project.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved custom field settings objects for a project.
    remote isolated function getCustomFieldSettingsForProject(string project_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2009|error {
        string  path = string `/projects/${project_gid}/custom_field_settings`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2009 response = check self.clientEp-> get(path, targetType = InlineResponse2009);
        return response;
    }
    # Duplicate a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - Describes the duplicate's name and the elements that will be duplicated.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created the job to handle duplication.
    remote isolated function duplicateProject(string project_gid, Body20 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2004|error {
        string  path = string `/projects/${project_gid}/duplicate`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2004 response = check self.clientEp->post(path, request, targetType=InlineResponse2004);
        return response;
    }
    # Get memberships from a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + user - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested project's memberships.
    remote isolated function getProjectMembershipsForProject(string project_gid, string? user = (), boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20014|error {
        string  path = string `/projects/${project_gid}/project_memberships`;
        map<anydata> queryParam = {"user": user, "opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20014 response = check self.clientEp-> get(path, targetType = InlineResponse20014);
        return response;
    }
    # Get statuses from a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the specified project's status updates.
    remote isolated function getProjectStatusesForProject(string project_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20015|error {
        string  path = string `/projects/${project_gid}/project_statuses`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20015 response = check self.clientEp-> get(path, targetType = InlineResponse20015);
        return response;
    }
    # Create a project status
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - The project status to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created a new story.
    remote isolated function createProjectStatusForProject(string project_gid, Body21 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20012|error {
        string  path = string `/projects/${project_gid}/project_statuses`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20012 response = check self.clientEp->post(path, request, targetType=InlineResponse20012);
        return response;
    }
    # Remove a custom field from a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - Information about the custom field setting being removed.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + return - Successfully removed the custom field from the project.
    remote isolated function removeCustomFieldSettingForProject(string project_gid, Body22 payload, boolean? optPretty = ()) returns InlineResponse2001|error {
        string  path = string `/projects/${project_gid}/removeCustomFieldSetting`;
        map<anydata> queryParam = {"opt_pretty": optPretty};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Remove followers from a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - Information about the followers being removed.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully removed followers from the project.
    remote isolated function removeFollowersForProject(string project_gid, Body23 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/projects/${project_gid}/removeFollowers`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Remove users from a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - Information about the members being removed.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully removed the members from the project.
    remote isolated function removeMembersForProject(string project_gid, Body24 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/projects/${project_gid}/removeMembers`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Get sections in a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved sections in project.
    remote isolated function getSectionsForProject(string project_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20016|error {
        string  path = string `/projects/${project_gid}/sections`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20016 response = check self.clientEp-> get(path, targetType = InlineResponse20016);
        return response;
    }
    # Create a section in a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - The section to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created the specified section.
    remote isolated function createSectionForProject(string project_gid, Body25 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2015|error {
        string  path = string `/projects/${project_gid}/sections`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2015 response = check self.clientEp->post(path, request, targetType=InlineResponse2015);
        return response;
    }
    # Move or Insert sections
    #
    # + project_gid - Globally unique identifier for the project.
    # + payload - The section's move action.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully moved the specified section.
    remote isolated function insertSectionForProject(string project_gid, Body26 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/projects/${project_gid}/sections/insert`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Get task count of a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested project's task counts.
    remote isolated function getTaskCountsForProject(string project_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20017|error {
        string  path = string `/projects/${project_gid}/task_counts`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20017 response = check self.clientEp-> get(path, targetType = InlineResponse20017);
        return response;
    }
    # Get tasks from a project
    #
    # + project_gid - Globally unique identifier for the project.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested project's tasks.
    remote isolated function getTasksForProject(string project_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20018|error {
        string  path = string `/projects/${project_gid}/tasks`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20018 response = check self.clientEp-> get(path, targetType = InlineResponse20018);
        return response;
    }
    # Get a section
    #
    # + section_gid - The globally unique identifier for the section.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved section.
    remote isolated function getSection(string section_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2015|error {
        string  path = string `/sections/${section_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2015 response = check self.clientEp-> get(path, targetType = InlineResponse2015);
        return response;
    }
    # Update a section
    #
    # + section_gid - The globally unique identifier for the section.
    # + payload - The section to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully updated the specified section.
    remote isolated function updateSection(string section_gid, Body27 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2015|error {
        string  path = string `/sections/${section_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2015 response = check self.clientEp->put(path, request, targetType=InlineResponse2015);
        return response;
    }
    # Delete a section
    #
    # + section_gid - The globally unique identifier for the section.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully deleted the specified section.
    remote isolated function deleteSection(string section_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/sections/${section_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Add task to section
    #
    # + section_gid - The globally unique identifier for the section.
    # + payload - The task and optionally the insert location.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully added the task.
    remote isolated function addTaskForSection(string section_gid, Body28 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/sections/${section_gid}/addTask`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Get tasks from a section
    #
    # + section_gid - The globally unique identifier for the section.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the section's tasks.
    remote isolated function getTasksForSection(string section_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20018|error {
        string  path = string `/sections/${section_gid}/tasks`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20018 response = check self.clientEp-> get(path, targetType = InlineResponse20018);
        return response;
    }
    # Get a story
    #
    # + story_gid - Globally unique identifier for the story.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the specified story.
    remote isolated function getStory(string story_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20019|error {
        string  path = string `/stories/${story_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20019 response = check self.clientEp-> get(path, targetType = InlineResponse20019);
        return response;
    }
    # Update a story
    #
    # + story_gid - Globally unique identifier for the story.
    # + payload - The comment story to update.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the specified story.
    remote isolated function updateStory(string story_gid, Body29 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20019|error {
        string  path = string `/stories/${story_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20019 response = check self.clientEp->put(path, request, targetType=InlineResponse20019);
        return response;
    }
    # Delete a story
    #
    # + story_gid - Globally unique identifier for the story.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully deleted the specified story.
    remote isolated function deleteStory(string story_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/stories/${story_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Get multiple tags
    #
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + workspace - The workspace to filter tags on.
    # + return - Successfully retrieved the specified set of tags.
    remote isolated function getTags(boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = (), string? workspace = ()) returns InlineResponse20020|error {
        string  path = string `/tags`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "workspace": workspace};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20020 response = check self.clientEp-> get(path, targetType = InlineResponse20020);
        return response;
    }
    # Create a tag
    #
    # + payload - The tag to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created the newly specified tag.
    remote isolated function createTag(Body30 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2016|error {
        string  path = string `/tags`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2016 response = check self.clientEp->post(path, request, targetType=InlineResponse2016);
        return response;
    }
    # Get a tag
    #
    # + tag_gid - Globally unique identifier for the tag.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the specified tag.
    remote isolated function getTag(string tag_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2016|error {
        string  path = string `/tags/${tag_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2016 response = check self.clientEp-> get(path, targetType = InlineResponse2016);
        return response;
    }
    # Update a tag
    #
    # + tag_gid - Globally unique identifier for the tag.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully updated the specified tag.
    remote isolated function updateTag(string tag_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2016|error {
        string  path = string `/tags/${tag_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2016 response = check self.clientEp-> put(path, request, targetType = InlineResponse2016);
        return response;
    }
    # Delete a tag
    #
    # + tag_gid - Globally unique identifier for the tag.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully deleted the specified tag.
    remote isolated function deleteTag(string tag_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2001|error {
        string  path = string `/tags/${tag_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Get tasks from a tag
    #
    # + tag_gid - Globally unique identifier for the tag.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the tasks associated with the specified tag.
    remote isolated function getTasksForTag(string tag_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20018|error {
        string  path = string `/tags/${tag_gid}/tasks`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20018 response = check self.clientEp-> get(path, targetType = InlineResponse20018);
        return response;
    }
    # Get multiple tasks
    #
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + assignee - The assignee to filter tasks on.
    # + project - The project to filter tasks on.
    # + section - The section to filter tasks on.
    # + workspace - The workspace to filter tasks on.
    # + completedSince - Only return tasks that are either incomplete or that have been completed since this time.
    # + modifiedSince - Only return tasks that have been modified since the given time.
    # + return - Successfully retrieved requested tasks.
    remote isolated function getTasks(boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = (), string? assignee = (), string? project = (), string? section = (), string? workspace = (), string? completedSince = (), string? modifiedSince = ()) returns InlineResponse20018|error {
        string  path = string `/tasks`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "assignee": assignee, "project": project, "section": section, "workspace": workspace, "completed_since": completedSince, "modified_since": modifiedSince};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20018 response = check self.clientEp-> get(path, targetType = InlineResponse20018);
        return response;
    }
    # Create a task
    #
    # + payload - Create Task Request
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created a new task.
    remote isolated function createTask(Body31 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2017|error {
        string  path = string `/tasks`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2017 response = check self.clientEp->post(path, request, targetType=InlineResponse2017);
        return response;
    }
    # Get a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the specified task.
    remote isolated function getTask(string task_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2017|error {
        string  path = string `/tasks/${task_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2017 response = check self.clientEp-> get(path, targetType = InlineResponse2017);
        return response;
    }
    # Update a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The task to update.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully updated the specified task.
    remote isolated function updateTask(string task_gid, Body32 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2017|error {
        string  path = string `/tasks/${task_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2017 response = check self.clientEp->put(path, request, targetType=InlineResponse2017);
        return response;
    }
    # Delete a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully deleted the specified task.
    remote isolated function deleteTask(string task_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/tasks/${task_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Set dependencies for a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The list of tasks to set as dependencies.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully set the specified dependencies on the task.
    remote isolated function addDependenciesForTask(string task_gid, Body33 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/tasks/${task_gid}/addDependencies`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Set dependents for a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The list of tasks to add as dependents.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully set the specified dependents on the given task.
    remote isolated function addDependentsForTask(string task_gid, Body34 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20018|error {
        string  path = string `/tasks/${task_gid}/addDependents`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20018 response = check self.clientEp->post(path, request, targetType=InlineResponse20018);
        return response;
    }
    # Add followers to a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The followers to add to the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully added the specified followers to the task.
    remote isolated function addFollowersForTask(string task_gid, Body35 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/tasks/${task_gid}/addFollowers`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Add a project to a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The project to add the task to.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully added the specified project to the task.
    remote isolated function addProjectForTask(string task_gid, Body36 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/tasks/${task_gid}/addProject`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Add a tag to a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The tag to add to the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully added the specified tag to the task.
    remote isolated function addTagForTask(string task_gid, Body37 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/tasks/${task_gid}/addTag`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Get attachments for a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the compact records for all attachments on the task.
    remote isolated function getAttachmentsForTask(string task_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20021|error {
        string  path = string `/tasks/${task_gid}/attachments`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20021 response = check self.clientEp-> get(path, targetType = InlineResponse20021);
        return response;
    }
    # Upload an attachment
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The file you want to upload.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully uploaded the attachment to the task.
    remote isolated function createAttachmentForTask(string task_gid, AttachmentRequest payload, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse200|error {
        string  path = string `/tasks/${task_gid}/attachments`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        InlineResponse200 response = check self.clientEp->post(path, request, targetType=InlineResponse200);
        return response;
    }
    # Get dependencies from a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the specified task's dependencies.
    remote isolated function getDependenciesForTask(string task_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20018|error {
        string  path = string `/tasks/${task_gid}/dependencies`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20018 response = check self.clientEp-> get(path, targetType = InlineResponse20018);
        return response;
    }
    # Get dependents from a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the specified dependents of the task.
    remote isolated function getDependentsForTask(string task_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20018|error {
        string  path = string `/tasks/${task_gid}/dependents`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20018 response = check self.clientEp-> get(path, targetType = InlineResponse20018);
        return response;
    }
    # Duplicate a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - Describes the duplicate's name and the fields that will be duplicated.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created the job to handle duplication.
    remote isolated function duplicateTask(string task_gid, Body38 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2004|error {
        string  path = string `/tasks/${task_gid}/duplicate`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2004 response = check self.clientEp->post(path, request, targetType=InlineResponse2004);
        return response;
    }
    # Get projects a task is in
    #
    # + task_gid - Globally unique identifier for the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the projects for the given task.
    remote isolated function getProjectsForTask(string task_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20010|error {
        string  path = string `/tasks/${task_gid}/projects`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20010 response = check self.clientEp-> get(path, targetType = InlineResponse20010);
        return response;
    }
    # Unlink dependencies from a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The list of tasks to unlink as dependencies.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully unlinked the dependencies from the specified task.
    remote isolated function removeDependenciesForTask(string task_gid, Body39 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20022|error {
        string  path = string `/tasks/${task_gid}/removeDependencies`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20022 response = check self.clientEp->post(path, request, targetType=InlineResponse20022);
        return response;
    }
    # Unlink dependents from a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The list of tasks to remove as dependents.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully unlinked the specified tasks as dependents.
    remote isolated function removeDependentsForTask(string task_gid, Body40 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20022|error {
        string  path = string `/tasks/${task_gid}/removeDependents`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20022 response = check self.clientEp->post(path, request, targetType=InlineResponse20022);
        return response;
    }
    # Remove followers from a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The followers to remove from the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully removed the specified followers from the task.
    remote isolated function removeFollowerForTask(string task_gid, Body41 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/tasks/${task_gid}/removeFollowers`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Remove a project from a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The project to remove the task from.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully removed the specified project from the task.
    remote isolated function removeProjectForTask(string task_gid, Body42 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/tasks/${task_gid}/removeProject`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Remove a tag from a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The tag to remove from the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully removed the specified tag from the task.
    remote isolated function removeTagForTask(string task_gid, Body43 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/tasks/${task_gid}/removeTag`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Set the parent of a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The new parent of the subtask.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully changed the parent of the specified subtask.
    remote isolated function setParentForTask(string task_gid, Body44 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2017|error {
        string  path = string `/tasks/${task_gid}/setParent`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2017 response = check self.clientEp->post(path, request, targetType=InlineResponse2017);
        return response;
    }
    # Get stories from a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the specified task's stories.
    remote isolated function getStoriesForTask(string task_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20023|error {
        string  path = string `/tasks/${task_gid}/stories`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20023 response = check self.clientEp-> get(path, targetType = InlineResponse20023);
        return response;
    }
    # Create a story on a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The story to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created a new story.
    remote isolated function createStoryForTask(string task_gid, Body45 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20019|error {
        string  path = string `/tasks/${task_gid}/stories`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20019 response = check self.clientEp->post(path, request, targetType=InlineResponse20019);
        return response;
    }
    # Get subtasks from a task
    #
    # + task_gid - Globally unique identifier for the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the specified task's subtasks.
    remote isolated function getSubtasksForTask(string task_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20018|error {
        string  path = string `/tasks/${task_gid}/subtasks`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20018 response = check self.clientEp-> get(path, targetType = InlineResponse20018);
        return response;
    }
    # Create a subtask
    #
    # + task_gid - Globally unique identifier for the task.
    # + payload - The new subtask to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created the specified subtask.
    remote isolated function createSubtaskForTask(string task_gid, Body46 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2017|error {
        string  path = string `/tasks/${task_gid}/subtasks`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2017 response = check self.clientEp->post(path, request, targetType=InlineResponse2017);
        return response;
    }
    # Get a task's tags
    #
    # + task_gid - Globally unique identifier for the task.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the tags for the given task.
    remote isolated function getTagsForTask(string task_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20020|error {
        string  path = string `/tasks/${task_gid}/tags`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20020 response = check self.clientEp-> get(path, targetType = InlineResponse20020);
        return response;
    }
    # Get team memberships
    #
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + team - Globally unique identifier for the team.
    # + user - A string identifying a user. This can either be the string "me", an email, or the gid of a user. This parameter must be used with the workspace parameter.
    # + workspace - Globally unique identifier for the workspace. This parameter must be used with the user parameter.
    # + return - Successfully retrieved the requested team memberships.
    remote isolated function getTeamMemberships(boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = (), string? team = (), string? user = (), string? workspace = ()) returns InlineResponse20024|error {
        string  path = string `/team_memberships`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "team": team, "user": user, "workspace": workspace};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20024 response = check self.clientEp-> get(path, targetType = InlineResponse20024);
        return response;
    }
    # Get a team membership
    #
    # + team_membership_gid - Globally unique identifier for the team membership.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the requested team membership.
    remote isolated function getTeamMembership(string team_membership_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20025|error {
        string  path = string `/team_memberships/${team_membership_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20025 response = check self.clientEp-> get(path, targetType = InlineResponse20025);
        return response;
    }
    # Create a team
    #
    # + payload - The team to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully created a new team.
    remote isolated function createTeam(Body47 payload, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2018|error {
        string  path = string `/teams`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2018 response = check self.clientEp->post(path, request, targetType=InlineResponse2018);
        return response;
    }
    # Get a team
    #
    # + team_gid - Globally unique identifier for the team.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successsfully retrieved the record for a single team.
    remote isolated function getTeam(string team_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2018|error {
        string  path = string `/teams/${team_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2018 response = check self.clientEp-> get(path, targetType = InlineResponse2018);
        return response;
    }
    # Add a user to a team
    #
    # + team_gid - Globally unique identifier for the team.
    # + payload - The user to add to the team.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Returns the full user record for the added user.
    remote isolated function addUserForTeam(string team_gid, Body48 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20026|error {
        string  path = string `/teams/${team_gid}/addUser`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20026 response = check self.clientEp->post(path, request, targetType=InlineResponse20026);
        return response;
    }
    # Get a team's projects
    #
    # + team_gid - Globally unique identifier for the team.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + archived - Only return projects whose `archived` field takes on the value of this parameter.
    # + return - Successfully retrieved the requested team's projects.
    remote isolated function getProjectsForTeam(string team_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = (), boolean? archived = ()) returns InlineResponse20010|error {
        string  path = string `/teams/${team_gid}/projects`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "archived": archived};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20010 response = check self.clientEp-> get(path, targetType = InlineResponse20010);
        return response;
    }
    # Create a project in a team
    #
    # + team_gid - Globally unique identifier for the team.
    # + payload - The new project to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created the specified project.
    remote isolated function createProjectForTeam(string team_gid, Body49 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2014|error {
        string  path = string `/teams/${team_gid}/projects`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2014 response = check self.clientEp->post(path, request, targetType=InlineResponse2014);
        return response;
    }
    # Remove a user from a team
    #
    # + team_gid - Globally unique identifier for the team.
    # + payload - The user to remove from the team.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Returns an empty data record
    remote isolated function removeUserForTeam(string team_gid, Body50 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/teams/${team_gid}/removeUser`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Get memberships from a team
    #
    # + team_gid - Globally unique identifier for the team.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested team's memberships.
    remote isolated function getTeamMembershipsForTeam(string team_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20024|error {
        string  path = string `/teams/${team_gid}/team_memberships`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20024 response = check self.clientEp-> get(path, targetType = InlineResponse20024);
        return response;
    }
    # Get users in a team
    #
    # + team_gid - Globally unique identifier for the team.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + offset - Offset token.
    # + return - Returns the user records for all the members of the team, including guests and limited access users
    remote isolated function getUsersForTeam(string team_gid, boolean? optPretty = (), string[]? optFields = (), string? offset = ()) returns InlineResponse20027|error {
        string  path = string `/teams/${team_gid}/users`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20027 response = check self.clientEp-> get(path, targetType = InlineResponse20027);
        return response;
    }
    # Get a user task list
    #
    # + user_task_list_gid - Globally unique identifier for the user task list.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the user task list.
    remote isolated function getUserTaskList(string user_task_list_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20028|error {
        string  path = string `/user_task_lists/${user_task_list_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20028 response = check self.clientEp-> get(path, targetType = InlineResponse20028);
        return response;
    }
    # Get tasks from a user task list
    #
    # + user_task_list_gid - Globally unique identifier for the user task list.
    # + completedSince - Only return tasks that are either incomplete or that have been completed since this time. Accepts a date-time string or the keyword *now*.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the user task list's tasks.
    remote isolated function getTasksForUserTaskList(string user_task_list_gid, string? completedSince = (), boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20018|error {
        string  path = string `/user_task_lists/${user_task_list_gid}/tasks`;
        map<anydata> queryParam = {"completed_since": completedSince, "opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20018 response = check self.clientEp-> get(path, targetType = InlineResponse20018);
        return response;
    }
    # Get multiple users
    #
    # + workspace - The workspace or organization ID to filter users on.
    # + team - The team ID to filter users on.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested user records.
    remote isolated function getUsers(string? workspace = (), string? team = (), boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20027|error {
        string  path = string `/users`;
        map<anydata> queryParam = {"workspace": workspace, "team": team, "opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20027 response = check self.clientEp-> get(path, targetType = InlineResponse20027);
        return response;
    }
    # Get a user
    #
    # + user_gid - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Returns the user specified.
    remote isolated function getUser(string user_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20026|error {
        string  path = string `/users/${user_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20026 response = check self.clientEp-> get(path, targetType = InlineResponse20026);
        return response;
    }
    # Get a user's favorites
    #
    # + user_gid - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + resourceType - The resource type of favorites to be returned.
    # + workspace - The workspace in which to get favorites.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Returns the specified user's favorites.
    remote isolated function getFavoritesForUser(string user_gid, string resourceType, string workspace, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20029|error {
        string  path = string `/users/${user_gid}/favorites`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "resource_type": resourceType, "workspace": workspace};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20029 response = check self.clientEp-> get(path, targetType = InlineResponse20029);
        return response;
    }
    # Get memberships from a user
    #
    # + user_gid - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + workspace - Globally unique identifier for the workspace.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested users's memberships.
    remote isolated function getTeamMembershipsForUser(string user_gid, string workspace, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20024|error {
        string  path = string `/users/${user_gid}/team_memberships`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "workspace": workspace};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20024 response = check self.clientEp-> get(path, targetType = InlineResponse20024);
        return response;
    }
    # Get teams for a user
    #
    # + user_gid - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + organization - The workspace or organization to filter teams on.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Returns the team records for all teams in the organization or workspace to which the given user is assigned.
    remote isolated function getTeamsForUser(string user_gid, string organization, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse2005|error {
        string  path = string `/users/${user_gid}/teams`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "organization": organization};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2005 response = check self.clientEp-> get(path, targetType = InlineResponse2005);
        return response;
    }
    # Get a user's task list
    #
    # + user_gid - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + workspace - The workspace in which to get the user task list.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the user's task list.
    remote isolated function getUserTaskListForUser(string user_gid, string workspace, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20028|error {
        string  path = string `/users/${user_gid}/user_task_list`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "workspace": workspace};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20028 response = check self.clientEp-> get(path, targetType = InlineResponse20028);
        return response;
    }
    # Get workspace memberships for a user
    #
    # + user_gid - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested user's workspace memberships.
    remote isolated function getWorkspaceMembershipsForUser(string user_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20030|error {
        string  path = string `/users/${user_gid}/workspace_memberships`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20030 response = check self.clientEp-> get(path, targetType = InlineResponse20030);
        return response;
    }
    # Get multiple webhooks
    #
    # + workspace - The workspace to query for webhooks in.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + 'resource - Only return webhooks for the given resource.
    # + return - Successfully retrieved the requested webhooks.
    remote isolated function getWebhooks(string workspace, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = (), string? 'resource = ()) returns InlineResponse20031|error {
        string  path = string `/webhooks`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "workspace": workspace, "resource": 'resource};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20031 response = check self.clientEp-> get(path, targetType = InlineResponse20031);
        return response;
    }
    # Establish a webhook
    #
    # + payload - The webhook workspace and target.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created the requested webhook.
    remote isolated function createWebhook(Body51 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2019|error {
        string  path = string `/webhooks`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2019 response = check self.clientEp->post(path, request, targetType=InlineResponse2019);
        return response;
    }
    # Get a webhook
    #
    # + webhook_gid - Globally unique identifier for the webhook.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the requested webhook.
    remote isolated function getWebhook(string webhook_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2019|error {
        string  path = string `/webhooks/${webhook_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse2019 response = check self.clientEp-> get(path, targetType = InlineResponse2019);
        return response;
    }
    # Delete a webhook
    #
    # + webhook_gid - Globally unique identifier for the webhook.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the requested webhook.
    remote isolated function deleteWebhook(string webhook_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/webhooks/${webhook_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        InlineResponse2001 response = check self.clientEp-> delete(path, request, targetType = InlineResponse2001);
        return response;
    }
    # Get a workspace membership
    #
    # + workspace_membership_gid - Globally unique identifier for the workspace membership
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved the requested workspace membership.
    remote isolated function getWorkspaceMembership(string workspace_membership_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20032|error {
        string  path = string `/workspace_memberships/${workspace_membership_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20032 response = check self.clientEp-> get(path, targetType = InlineResponse20032);
        return response;
    }
    # Get multiple workspaces
    #
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Return all workspaces visible to the authorized user.
    remote isolated function getWorkspaces(boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20033|error {
        string  path = string `/workspaces`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20033 response = check self.clientEp-> get(path, targetType = InlineResponse20033);
        return response;
    }
    # Get a workspace
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Return the full workspace record.
    remote isolated function getWorkspace(string workspace_gid, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20034|error {
        string  path = string `/workspaces/${workspace_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20034 response = check self.clientEp-> get(path, targetType = InlineResponse20034);
        return response;
    }
    # Update a workspace
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + payload - The workspace object with all updated properties.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Update for the workspace was successful.
    remote isolated function updateWorkspace(string workspace_gid, Body52 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20034|error {
        string  path = string `/workspaces/${workspace_gid}`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20034 response = check self.clientEp->put(path, request, targetType=InlineResponse20034);
        return response;
    }
    # Add a user to a workspace or organization
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + payload - The user to add to the workspace.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - The user was added successfully to the workspace or organization.
    remote isolated function addUserForWorkspace(string workspace_gid, Body53 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20026|error {
        string  path = string `/workspaces/${workspace_gid}/addUser`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse20026 response = check self.clientEp->post(path, request, targetType=InlineResponse20026);
        return response;
    }
    # Get a workspace's custom fields
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved all custom fields for the given workspace.
    remote isolated function getCustomFieldsForWorkspace(string workspace_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20035|error {
        string  path = string `/workspaces/${workspace_gid}/custom_fields`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20035 response = check self.clientEp-> get(path, targetType = InlineResponse20035);
        return response;
    }
    # Get all projects in a workspace
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + archived - Only return projects whose `archived` field takes on the value of this parameter.
    # + return - Successfully retrieved the requested workspace's projects.
    remote isolated function getProjectsForWorkspace(string workspace_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = (), boolean? archived = ()) returns InlineResponse20010|error {
        string  path = string `/workspaces/${workspace_gid}/projects`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset, "archived": archived};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20010 response = check self.clientEp-> get(path, targetType = InlineResponse20010);
        return response;
    }
    # Create a project in a workspace
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + payload - The new project to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created a new project in the specified workspace.
    remote isolated function createProjectForWorkspace(string workspace_gid, Body54 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2014|error {
        string  path = string `/workspaces/${workspace_gid}/projects`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2014 response = check self.clientEp->post(path, request, targetType=InlineResponse2014);
        return response;
    }
    # Remove a user from a workspace or organization
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + payload - The user to remove from the workspace.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - The user was removed successfully to the workspace or organization.
    remote isolated function removeUserForWorkspace(string workspace_gid, Body55 payload, boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse2001|error {
        string  path = string `/workspaces/${workspace_gid}/removeUser`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        InlineResponse2001 response = check self.clientEp->post(path, request, targetType=InlineResponse2001);
        return response;
    }
    # Get tags in a workspace
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the specified set of tags.
    remote isolated function getTagsForWorkspace(string workspace_gid, boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20020|error {
        string  path = string `/workspaces/${workspace_gid}/tags`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20020 response = check self.clientEp-> get(path, targetType = InlineResponse20020);
        return response;
    }
    # Create a tag in a workspace
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + payload - The tag to create.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully created the newly specified tag.
    remote isolated function createTagForWorkspace(string workspace_gid, Body56 payload, boolean? optPretty = (), string[]? optFields = ()) returns Body56|error {
        string  path = string `/workspaces/${workspace_gid}/tags`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        Body56 response = check self.clientEp->post(path, request, targetType=Body56);
        return response;
    }
    # Search tasks in a workspace
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + text - Performs full-text search on both task name and description
    # + resourceSubtype - Filters results by the task's resource_subtype
    # + assigneeAny - Comma-separated list of user identifiers
    # + assigneeNot - Comma-separated list of user identifiers
    # + portfoliosAny - Comma-separated list of portfolio IDs
    # + projectsAny - Comma-separated list of project IDs
    # + projectsNot - Comma-separated list of project IDs
    # + projectsAll - Comma-separated list of project IDs
    # + sectionsAny - Comma-separated list of section or column IDs
    # + sectionsNot - Comma-separated list of section or column IDs
    # + sectionsAll - Comma-separated list of section or column IDs
    # + tagsAny - Comma-separated list of tag IDs
    # + tagsNot - Comma-separated list of tag IDs
    # + tagsAll - Comma-separated list of tag IDs
    # + teamsAny - Comma-separated list of team IDs
    # + followersAny - Comma-separated list of user identifiers
    # + followersNot - Comma-separated list of user identifiers
    # + createdByAny - Comma-separated list of user identifiers
    # + createdByNot - Comma-separated list of user identifiers
    # + assignedByAny - Comma-separated list of user identifiers
    # + assignedByNot - Comma-separated list of user identifiers
    # + likedByAny - Comma-separated list of user identifiers
    # + likedByNot - Comma-separated list of user identifiers
    # + commentedOnByAny - Comma-separated list of user identifiers
    # + commentedOnByNot - Comma-separated list of user identifiers
    # + dueOnBefore - ISO 8601 date string
    # + dueOnAfter - ISO 8601 date string
    # + dueOn - ISO 8601 date string or `null`
    # + dueAtBefore - ISO 8601 datetime string
    # + dueAtAfter - ISO 8601 datetime string
    # + startOnBefore - ISO 8601 date string
    # + startOnAfter - ISO 8601 date string
    # + startOn - ISO 8601 date string or `null`
    # + createdOnBefore - ISO 8601 date string
    # + createdOnAfter - ISO 8601 date string
    # + createdOn - ISO 8601 date string or `null`
    # + createdAtBefore - ISO 8601 datetime string
    # + createdAtAfter - ISO 8601 datetime string
    # + completedOnBefore - ISO 8601 date string
    # + completedOnAfter - ISO 8601 date string
    # + completedOn - ISO 8601 date string or `null`
    # + completedAtBefore - ISO 8601 datetime string
    # + completedAtAfter - ISO 8601 datetime string
    # + modifiedOnBefore - ISO 8601 date string
    # + modifiedOnAfter - ISO 8601 date string
    # + modifiedOn - ISO 8601 date string or `null`
    # + modifiedAtBefore - ISO 8601 datetime string
    # + modifiedAtAfter - ISO 8601 datetime string
    # + isBlocking - Filter to incomplete tasks with dependents
    # + isBlocked - Filter to tasks with incomplete dependencies
    # + hasAttachment - Filter to tasks with attachments
    # + completed - Filter to completed tasks
    # + isSubtask - Filter to subtasks
    # + sortBy - One of `due_date`, `created_at`, `completed_at`, `likes`, or `modified_at`, defaults to `modified_at`
    # + sortAscending - Default `false`
    # + return - Successfully retrieved the section's tasks.
    remote isolated function searchTasksForWorkspace(string workspace_gid, boolean? optPretty = (), string[]? optFields = (), string? text = (), string resourceSubtype = "milestone", string? assigneeAny = (), string? assigneeNot = (), string? portfoliosAny = (), string? projectsAny = (), string? projectsNot = (), string? projectsAll = (), string? sectionsAny = (), string? sectionsNot = (), string? sectionsAll = (), string? tagsAny = (), string? tagsNot = (), string? tagsAll = (), string? teamsAny = (), string? followersAny = (), string? followersNot = (), string? createdByAny = (), string? createdByNot = (), string? assignedByAny = (), string? assignedByNot = (), string? likedByAny = (), string? likedByNot = (), string? commentedOnByAny = (), string? commentedOnByNot = (), string? dueOnBefore = (), string? dueOnAfter = (), string? dueOn = (), string? dueAtBefore = (), string? dueAtAfter = (), string? startOnBefore = (), string? startOnAfter = (), string? startOn = (), string? createdOnBefore = (), string? createdOnAfter = (), string? createdOn = (), string? createdAtBefore = (), string? createdAtAfter = (), string? completedOnBefore = (), string? completedOnAfter = (), string? completedOn = (), string? completedAtBefore = (), string? completedAtAfter = (), string? modifiedOnBefore = (), string? modifiedOnAfter = (), string? modifiedOn = (), string? modifiedAtBefore = (), string? modifiedAtAfter = (), boolean? isBlocking = (), boolean? isBlocked = (), boolean? hasAttachment = (), boolean? completed = (), boolean? isSubtask = (), string sortBy = "modified_at", boolean sortAscending = false) returns InlineResponse20018|error {
        string  path = string `/workspaces/${workspace_gid}/tasks/search`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "text": text, "resource_subtype": resourceSubtype, "assignee.any": assigneeAny, "assignee.not": assigneeNot, "portfolios.any": portfoliosAny, "projects.any": projectsAny, "projects.not": projectsNot, "projects.all": projectsAll, "sections.any": sectionsAny, "sections.not": sectionsNot, "sections.all": sectionsAll, "tags.any": tagsAny, "tags.not": tagsNot, "tags.all": tagsAll, "teams.any": teamsAny, "followers.any": followersAny, "followers.not": followersNot, "created_by.any": createdByAny, "created_by.not": createdByNot, "assigned_by.any": assignedByAny, "assigned_by.not": assignedByNot, "liked_by.any": likedByAny, "liked_by.not": likedByNot, "commented_on_by.any": commentedOnByAny, "commented_on_by.not": commentedOnByNot, "due_on.before": dueOnBefore, "due_on.after": dueOnAfter, "due_on": dueOn, "due_at.before": dueAtBefore, "due_at.after": dueAtAfter, "start_on.before": startOnBefore, "start_on.after": startOnAfter, "start_on": startOn, "created_on.before": createdOnBefore, "created_on.after": createdOnAfter, "created_on": createdOn, "created_at.before": createdAtBefore, "created_at.after": createdAtAfter, "completed_on.before": completedOnBefore, "completed_on.after": completedOnAfter, "completed_on": completedOn, "completed_at.before": completedAtBefore, "completed_at.after": completedAtAfter, "modified_on.before": modifiedOnBefore, "modified_on.after": modifiedOnAfter, "modified_on": modifiedOn, "modified_at.before": modifiedAtBefore, "modified_at.after": modifiedAtAfter, "is_blocking": isBlocking, "is_blocked": isBlocked, "has_attachment": hasAttachment, "completed": completed, "is_subtask": isSubtask, "sort_by": sortBy, "sort_ascending": sortAscending};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20018 response = check self.clientEp-> get(path, targetType = InlineResponse20018);
        return response;
    }
    # Get objects via typeahead
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + resourceType - The type of values the typeahead should return. You can choose from one of the following: `custom_field`, `project`, `portfolio`, `tag`, `task`, and `user`. Note that unlike in the names of endpoints, the types listed here are in singular form (e.g. `task`). Using multiple types is not yet supported.
    # + 'type - *Deprecated: new integrations should prefer the resource_type field.*
    # + query - The string that will be used to search for relevant objects. If an empty string is passed in, the API will currently return an empty result set.
    # + count - The number of results to return. The default is 20 if this parameter is omitted, with a minimum of 1 and a maximum of 100. If there are fewer results found than requested, all will be returned.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + return - Successfully retrieved objects via a typeahead search algorithm.
    remote isolated function typeaheadForWorkspace(string workspace_gid, string resourceType, string 'type = "user", string? query = (), int? count = (), boolean? optPretty = (), string[]? optFields = ()) returns InlineResponse20036|error {
        string  path = string `/workspaces/${workspace_gid}/typeahead`;
        map<anydata> queryParam = {"resource_type": resourceType, "type": 'type, "query": query, "count": count, "opt_pretty": optPretty, "opt_fields": optFields};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20036 response = check self.clientEp-> get(path, targetType = InlineResponse20036);
        return response;
    }
    # Get users in a workspace or organization
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + offset - Offset token.
    # + return - Return the users in the specified workspace or org.
    remote isolated function getUsersForWorkspace(string workspace_gid, boolean? optPretty = (), string[]? optFields = (), string? offset = ()) returns InlineResponse20027|error {
        string  path = string `/workspaces/${workspace_gid}/users`;
        map<anydata> queryParam = {"opt_pretty": optPretty, "opt_fields": optFields, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20027 response = check self.clientEp-> get(path, targetType = InlineResponse20027);
        return response;
    }
    # Get the workspace memberships for a workspace
    #
    # + workspace_gid - Globally unique identifier for the workspace or organization.
    # + user - A string identifying a user. This can either be the string "me", an email, or the gid of a user.
    # + optPretty - Provides the response in a “pretty” format. In the case of JSON this means doing proper line breaking and indentation to make it readable. This will take extra time and increase the response size so it is advisable only to use this during debugging.
    # + optFields - Defines fields to return.
    # + 'limit - Results per page.
    # + offset - Offset token.
    # + return - Successfully retrieved the requested workspace's memberships.
    remote isolated function getWorkspaceMembershipsForWorkspace(string workspace_gid, string? user = (), boolean? optPretty = (), string[]? optFields = (), int? 'limit = (), string? offset = ()) returns InlineResponse20030|error {
        string  path = string `/workspaces/${workspace_gid}/workspace_memberships`;
        map<anydata> queryParam = {"user": user, "opt_pretty": optPretty, "opt_fields": optFields, "limit": 'limit, "offset": offset};
        path = path + check getPathForQueryParam(queryParam);
        InlineResponse20030 response = check self.clientEp-> get(path, targetType = InlineResponse20030);
        return response;
    }
}

# Generate query path with query parameter.
#
# + queryParam - Query parameter map
# + return - Returns generated Path or error at failure of client initialization
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
