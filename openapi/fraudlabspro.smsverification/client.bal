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

# This is a generated connector for [FraudLabsPro SMS Verification API v1.0](https://www.fraudlabspro.com/developer/api/send-verification) OpenAPI specification.
# 'Send an SMS with verification code and a custom message for authentication purpose. 
# It helps merchants to minimize chargebacks and fraud for various kinds of payment method, such as credit card, paypal, cod and so on. 
# Please visit https://www.fraudlabspro.com to learn more.'
@display {label: "FraudLabs Pro SMS Verification", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization doesn't require setting the API credentials. 
    # Create a [FraudLabsPro account](https://www.fraudlabspro.com/checkout) and obtain tokens following [this guide](https://www.fraudlabspro.com/developer/api/send-verification).
    # Some operations may require passing the token as a parameter.
    #
    # + clientConfig - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(http:ClientConfiguration clientConfig =  {}, string serviceUrl = "https://api.fraudlabspro.com") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Send an SMS with verification code and a custom message for authentication purpose.
    #
    # + countryCode - ISO 3166 country code for the recipient mobile phone number. If parameter is supplied, then some basic telephone number validation is done. 
    # + format - Returns the API response in json (default) or xml format. 
    # + tel - The recipient mobile phone number in E164 format which is a plus followed by just numbers with no spaces or parentheses. 
    # + 'key - FraudLabs Pro API key. 
    # + mesg - The message template for the SMS. Add <otp> as placeholder for the actual OTP to be generated. Max length is 140 characters. 
    # + return - send verification response 
    remote isolated function sendSMSVerification(string tel, string 'key, string? countryCode = (), string? format = (), string? mesg = ()) returns string|error {
        string resourcePath = string `/v1/verification/send`;
        map<anydata> queryParam = {"country_code": countryCode, "format": format, "tel": tel, "key": 'key, "mesg": mesg};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        string response = check self.clientEp-> post(resourcePath, request);
        return response;
    }
    # Verify that an OTP sent by the Send SMS Verification API is valid.
    #
    # + tranId - The unique ID that was returned by the Send Verification SMS API that triggered the OTP sms. 
    # + 'key - FraudLabs Pro API key. 
    # + format - Returns the API response in json (default) or xml format. 
    # + otp - The OTP that was sent to the recipient’s phone. 
    # + return - Get verification response 
    remote isolated function verifyOTP(string tranId, string 'key, string otp, string? format = ()) returns string|error {
        string resourcePath = string `/v1/verification/result`;
        map<anydata> queryParam = {"tran_id": tranId, "key": 'key, "format": format, "otp": otp};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        string response = check self.clientEp->get(resourcePath);
        return response;
    }
}
