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

# Configuration record for Paylocity API.
#
# + authConfig - Client Credentials Grant Configuration
# + secureSocketConfig - Secure Socket Configuration 
public type ClientConfig record {
    http:OAuth2ClientCredentialsGrantConfig authConfig;
    http:ClientSecureSocket secureSocketConfig?;
};

# + clientEp - Connector http endpoint
public client class Client {
    http:Client clientEp;
    # Client initialization.
    #
    # + clientConfig - Client configuration details
    # + serviceUrl - Connector server URL
    # + return - Returns error at failure of client initialization
    public isolated function init(ClientConfig clientConfig, string serviceUrl = "https://api.paylocity.com/api") returns error? {
        http:ClientSecureSocket? secureSocketConfig = clientConfig?.secureSocketConfig;
        http:Client httpEp = check new (serviceUrl, { auth: clientConfig.authConfig, secureSocket: secureSocketConfig });
        self.clientEp = httpEp;
    }
    # Get All Company Codes
    #
    # + companyId - Company Id
    # + codeResource - Type of Company Code. Common values costcenter1, costcenter2, costcenter3, deductions, earnings, taxes, paygrade, positions.
    # + return - Successfully retrieved
    remote isolated function getAllCompanyCodesAndDescriptionsByResource(string companyId, string codeResource) returns CompanyCodes[]|error {
        string  path = string `/v2/companies/${companyId}/codes/${codeResource}`;
        CompanyCodes[] response = check self.clientEp-> get(path, targetType = CompanyCodesArr);
        return response;
    }
    # Get All Custom Fields
    #
    # + companyId - Company Id
    # + category - Custom Fields Category
    # + return - Successfully retrieved
    remote isolated function getAllCustomFieldsByCategory(string companyId, string category) returns CustomFieldDefinition[]|error {
        string  path = string `/v2/companies/${companyId}/customfields/${category}`;
        CustomFieldDefinition[] response = check self.clientEp-> get(path, targetType = CustomFieldDefinitionArr);
        return response;
    }
    # Add new employee
    #
    # + companyId - Company Id
    # + payload - Employee Model
    # + return - Successfully added
    remote isolated function addEmployee(string companyId, Employee payload) returns EmployeeIdResponse[]|error {
        string  path = string `/v2/companies/${companyId}/employees`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        EmployeeIdResponse[] response = check self.clientEp->post(path, request, targetType=EmployeeIdResponseArr);
        return response;
    }
    # Get all employees
    #
    # + companyId - Company Id
    # + pagesize - Number of records per page. Default value is 25.
    # + pagenumber - Page number to retrieve; page numbers are 0-based (so to get the first page of results, pass pagenumber=0). Default value is 0.
    # + includetotalcount - Whether to include the total record count in the header's X-Pcty-Total-Count property. Default value is true.
    # + return - Successfully Retrieved
    remote isolated function getAllEmployees(string companyId, int? pagesize = (), int? pagenumber = (), boolean? includetotalcount = ()) returns EmployeeInfo[]|error {
        string  path = string `/v2/companies/${companyId}/employees/`;
        map<anydata> queryParam = {"pagesize": pagesize, "pagenumber": pagenumber, "includetotalcount": includetotalcount};
        path = path + check getPathForQueryParam(queryParam);
        EmployeeInfo[] response = check self.clientEp-> get(path, targetType = EmployeeInfoArr);
        return response;
    }
    # Get employee
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + return - Successfully Retrieved
    remote isolated function getEmployee(string companyId, string employeeId) returns Employee[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}`;
        Employee[] response = check self.clientEp-> get(path, targetType = EmployeeArr);
        return response;
    }
    # Update employee
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + payload - Employee Model
    # + return - Successfully Updated
    remote isolated function updateEmployee(string companyId, string employeeId, Employee payload) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        http:Response response = check self.clientEp->patch(path, request, targetType=http:Response);
        return response;
    }
    # Add/update additional rates
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + payload - Additional Rate Model
    # + return - Successfully added or updated
    remote isolated function addOrUpdateAdditionalRates(string companyId, string employeeId, AdditionalRate payload) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/additionalRates`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        http:Response response = check self.clientEp->put(path, request, targetType=http:Response);
        return response;
    }
    # Add/update employee's benefit setup
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + payload - BenefitSetup Model
    # + return - Successfully added or updated
    remote isolated function updateOrAddEmployeeBenefitSetup(string companyId, string employeeId, BenefitSetup payload) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/benefitSetup`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        http:Response response = check self.clientEp->put(path, request, targetType=http:Response);
        return response;
    }
    # Get All Direct Deposit
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + return - Successfully Retrieved
    remote isolated function getAllDirectDeposit(string companyId, string employeeId) returns DirectDeposit[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/directDeposit`;
        DirectDeposit[] response = check self.clientEp-> get(path, targetType = DirectDepositArr);
        return response;
    }
    # Get All Earnings
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + return - Successfully retrieved
    remote isolated function getAllEarnings(string companyId, string employeeId) returns Earning[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/earnings`;
        Earning[] response = check self.clientEp-> get(path, targetType = EarningArr);
        return response;
    }
    # Add/Update Earning
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + payload - Earning Model
    # + return - Successfully added or updated
    remote isolated function addOrUpdateAnEmployeeEarning(string companyId, string employeeId, Earning payload) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/earnings`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        http:Response response = check self.clientEp->put(path, request, targetType=http:Response);
        return response;
    }
    # Get Earnings by Earning Code
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + earningCode - Earning Code
    # + return - Successfully retrieved
    remote isolated function getEarningsByEarningCode(string companyId, string employeeId, string earningCode) returns Earning[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/earnings/${earningCode}`;
        Earning[] response = check self.clientEp-> get(path, targetType = EarningArr);
        return response;
    }
    # Get Earning by Earning Code and Start Date
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + earningCode - Earning Code
    # + startDate - Start Date
    # + return - Successfully retrieved
    remote isolated function getEarningByEarningCodeAndStartDate(string companyId, string employeeId, string earningCode, string startDate) returns Earning|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/earnings/${earningCode}/${startDate}`;
        Earning response = check self.clientEp-> get(path, targetType = Earning);
        return response;
    }
    # Delete Earning by Earning Code and Start Date
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + earningCode - Earning Code
    # + startDate - Start Date
    # + return - Successfully deleted
    remote isolated function deleteEarningByEarningCodeAndStartDate(string companyId, string employeeId, string earningCode, string startDate) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/earnings/${earningCode}/${startDate}`;
        http:Request request = new;
        //TODO: Update the request as needed;
        http:Response response = check self.clientEp-> delete(path, request, targetType = http:Response);
        return response;
    }
    # Add/update emergency contacts
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + payload - Emergency Contact Model
    # + return - Successfully added or updated
    remote isolated function addOrUpdateEmergencyContacts(string companyId, string employeeId, EmergencyContact payload) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/emergencyContacts`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        http:Response response = check self.clientEp->put(path, request, targetType=http:Response);
        return response;
    }
    # Get all local taxes
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + return - Successfully retrieved
    remote isolated function getAllLocalTaxes(string companyId, string employeeId) returns LocalTax[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/localTaxes`;
        LocalTax[] response = check self.clientEp-> get(path, targetType = LocalTaxArr);
        return response;
    }
    # Add new local tax
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + payload - LocalTax Model
    # + return - Successfully added
    remote isolated function addLocalTax(string companyId, string employeeId, LocalTax payload) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/localTaxes`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        http:Response response = check self.clientEp->post(path, request, targetType=http:Response);
        return response;
    }
    # Get local taxes by tax code
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + taxCode - Tax Code
    # + return - Successfully retrieved
    remote isolated function getLocalTaxByTaxCode(string companyId, string employeeId, string taxCode) returns LocalTax[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/localTaxes/${taxCode}`;
        LocalTax[] response = check self.clientEp-> get(path, targetType = LocalTaxArr);
        return response;
    }
    # Delete local tax by tax code
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + taxCode - Tax Code
    # + return - Successfully deleted
    remote isolated function deleteLocalTaxByTaxCode(string companyId, string employeeId, string taxCode) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/localTaxes/${taxCode}`;
        http:Request request = new;
        //TODO: Update the request as needed;
        http:Response response = check self.clientEp-> delete(path, request, targetType = http:Response);
        return response;
    }
    # Add/update non-primary state tax
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + payload - Non-Primary State Tax Model
    # + return - Successfully added or updated
    remote isolated function addOrUpdateNonPrimaryStateTax(string companyId, string employeeId, NonPrimaryStateTax payload) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/nonprimaryStateTax`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        http:Response response = check self.clientEp->put(path, request, targetType=http:Response);
        return response;
    }
    # Get employee pay statement details data for the specified year.
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + year - The year for which to retrieve pay statement data
    # + pagesize - Number of records per page. Default value is 25.
    # + pagenumber - Page number to retrieve; page numbers are 0-based (so to get the first page of results, pass pagenumber=0). Default value is 0.
    # + includetotalcount - Whether to include the total record count in the header's X-Pcty-Total-Count property. Default value is true.
    # + dettypes - Retrieve pay statement details related to specific deduction, earning or tax types. Common values include 401k, Memo, Reg, OT, Cash Tips, FED and SITW.
    # + return - Successfully Retrieved
    remote isolated function getsEmployeePayStatementDetailDataBasedOnTheSpecifiedYear(string companyId, string employeeId, string year, int? pagesize = (), int? pagenumber = (), boolean? includetotalcount = (), string? dettypes = ()) returns PayStatementDetails[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/paystatement/details/${year}`;
        map<anydata> queryParam = {"pagesize": pagesize, "pagenumber": pagenumber, "includetotalcount": includetotalcount, "dettypes": dettypes};
        path = path + check getPathForQueryParam(queryParam);
        PayStatementDetails[] response = check self.clientEp-> get(path, targetType = PayStatementDetailsArr);
        return response;
    }
    # Get employee pay statement details data for the specified year and check date.
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + year - The year for which to retrieve pay statement data
    # + checkDate - The check date for which to retrieve pay statement data
    # + pagesize - Number of records per page. Default value is 25.
    # + pagenumber - Page number to retrieve; page numbers are 0-based (so to get the first page of results, pass pagenumber=0). Default value is 0.
    # + includetotalcount - Whether to include the total record count in the header's X-Pcty-Total-Count property. Default value is true.
    # + dettypes - Retrieve pay statement details related to specific deduction, earning or tax types. Common values include 401k, Memo, Reg, OT, Cash Tips, FED and SITW.
    # + return - Successfully Retrieved
    remote isolated function getsEmployeePayStatementDetailDataBasedOnTheSpecifiedYearAndCheckDate(string companyId, string employeeId, string year, string checkDate, int? pagesize = (), int? pagenumber = (), boolean? includetotalcount = (), string? dettypes = ()) returns PayStatementDetails[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/paystatement/details/${year}/${checkDate}`;
        map<anydata> queryParam = {"pagesize": pagesize, "pagenumber": pagenumber, "includetotalcount": includetotalcount, "dettypes": dettypes};
        path = path + check getPathForQueryParam(queryParam);
        PayStatementDetails[] response = check self.clientEp-> get(path, targetType = PayStatementDetailsArr);
        return response;
    }
    # Get employee pay statement summary data for the specified year.
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + year - The year for which to retrieve pay statement data
    # + pagesize - Number of records per page. Default value is 25.
    # + pagenumber - Page number to retrieve; page numbers are 0-based (so to get the first page of results, pass pagenumber=0). Default value is 0.
    # + includetotalcount - Whether to include the total record count in the header's X-Pcty-Total-Count property. Default value is true.
    # + dettypes - Retrieve pay statement details related to specific deduction, earning or tax types. Common values include 401k, Memo, Reg, OT, Cash Tips, FED and SITW.
    # + return - Successfully Retrieved
    remote isolated function getsEmployeePayStatementSummaryDataBasedOnTheSpecifiedYear(string companyId, string employeeId, string year, int? pagesize = (), int? pagenumber = (), boolean? includetotalcount = (), string? dettypes = ()) returns PayStatementSummary[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/paystatement/summary/${year}`;
        map<anydata> queryParam = {"pagesize": pagesize, "pagenumber": pagenumber, "includetotalcount": includetotalcount, "dettypes": dettypes};
        path = path + check getPathForQueryParam(queryParam);
        PayStatementSummary[] response = check self.clientEp-> get(path, targetType = PayStatementSummaryArr);
        return response;
    }
    # Get employee pay statement summary data for the specified year and check date.
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + year - The year for which to retrieve pay statement data
    # + checkDate - The check date for which to retrieve pay statement data
    # + pagesize - Number of records per page. Default value is 25.
    # + pagenumber - Page number to retrieve; page numbers are 0-based (so to get the first page of results, pass pagenumber=0). Default value is 0.
    # + includetotalcount - Whether to include the total record count in the header's X-Pcty-Total-Count property. Default value is true.
    # + dettypes - Retrieve pay statement details related to specific deduction, earning or tax types. Common values include 401k, Memo, Reg, OT, Cash Tips, FED and SITW.
    # + return - Successfully Retrieved
    remote isolated function getsEmployeePayStatementSummaryDataBasedOnTheSpecifiedYearAndCheckDate(string companyId, string employeeId, string year, string checkDate, int? pagesize = (), int? pagenumber = (), boolean? includetotalcount = (), string? dettypes = ()) returns PayStatementSummary[]|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/paystatement/summary/${year}/${checkDate}`;
        map<anydata> queryParam = {"pagesize": pagesize, "pagenumber": pagenumber, "includetotalcount": includetotalcount, "dettypes": dettypes};
        path = path + check getPathForQueryParam(queryParam);
        PayStatementSummary[] response = check self.clientEp-> get(path, targetType = PayStatementSummaryArr);
        return response;
    }
    # Add/update primary state tax
    #
    # + companyId - Company Id
    # + employeeId - Employee Id
    # + payload - Primary State Tax Model
    # + return - Successfully added or updated
    remote isolated function addOrUpdatePrimaryStateTax(string companyId, string employeeId, StateTax payload) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/employees/${employeeId}/primaryStateTax`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        http:Response response = check self.clientEp->put(path, request, targetType=http:Response);
        return response;
    }
    # Get Company-Specific Open API Documentation
    #
    # + authorization - Bearer + JWT
    # + companyId - Company Id
    # + return - Successfully retrieved
    remote isolated function getCompanySpecificOpenApiDocumentation(string authorization, string companyId) returns http:Response|error {
        string  path = string `/v2/companies/${companyId}/openapi`;
        map<any> headerValues = {"Authorization": authorization};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Response response = check self.clientEp-> get(path, accHeaders, targetType = http:Response);
        return response;
    }
    # Obtain new client secret.
    #
    # + payload - Add Client Secret Model
    # + return - Successfully added
    remote isolated function addClientSecret(AddClientSecret payload) returns ClientCredentialsResponse[]|error {
        string  path = string `/v2/credentials/secrets`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        ClientCredentialsResponse[] response = check self.clientEp->post(path, request, targetType=ClientCredentialsResponseArr);
        return response;
    }
    # Add new employee to Web Link
    #
    # + companyId - Company Id
    # + payload - StagedEmployee Model
    # + return - Successfully Added
    remote isolated function addNewEmployeeToWebLink(string companyId, StagedEmployee payload) returns TrackingNumberResponse[]|error {
        string  path = string `/v2/weblinkstaging/companies/${companyId}/employees/newemployees`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        TrackingNumberResponse[] response = check self.clientEp->post(path, request, targetType=TrackingNumberResponseArr);
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

# Generate header map for given header values.
#
# + headerParam - Headers  map
# + return - Returns generated map or error at failure of client initialization
isolated function  getMapForHeaders(map<any>   headerParam)  returns  map<string|string[]> {
    map<string|string[]> headerMap = {};
    foreach  var [key, value] in  headerParam.entries() {
        if  value  is  string ||  value  is  string[] {
            headerMap[key] = value;
        }
    }
    return headerMap;
}
