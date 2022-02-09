## Overview
This is a generated connector for [MFT REST API v1.0](https://aayutechnologies.com/docs/product/mft-gateway/) OpenAPI specification. 
The [MFT REST API](https://aayutechnologies.com/docs/product/mft-gateway/) provides a secure AS2 secured channel for such communications, and offers your company, multiple ways to upload/download files, or automate the exchange through integration mechanisms.
 
## Prerequisites

Before using this connector in your Ballerina application, complete the following:

* Create [MFT](https://console.mftgateway.com/auth/register) account
* Obtain tokens following [this guide](https://aayutechnologies.com/docs/product/mft-gateway/user-guide/).
 
## Quickstart

To use the MFT connector in your Ballerina application, update the .bal file as follows

### Step 1: Import connector
First, import the `ballerinax/mft` module into the Ballerina project.
```ballerina
import ballerinax/mft;
```

### Step 2: Create a new connector instance
Create a `mft:Client` instance without an authorization key first. Then you can get the auth tokens using the `authorize` call. Then you can create a new client with auth token obtained as follows.

```ballerina
    mft:Client mftClientWOauth = check new ();

    mft:SuccessfulAuthorizationResponse authTokenResponse = check mftClientWOauth->authorize({username: "<USERNAME>", password: "<PASSWORD>"});

    mft:Client mftClient = check new ({authorization: authTokenResponse.api_token});
```

### Step 3: Invoke connector operation
1. Now you can use the operations available within the connector. Note that they are in the form of remote operations.

    Following is an example on listing received messages.

    List Received Messages

    ```ballerina
    public function main() {
        SuccessfulMessageListRetrievalResponse messageResponse = check mftClient->listReceivedMessages();
        if messageResponse.messages == [] {
            io:println("No messages received!!");
            return;
        }
        foreach var message in messageResponse.messages {
            io:println("MESSAGE ID >>>" +message.toString());
        }
    }
    ``` 

    Following is an example on single message retrieval.

    Retrieve an Inbox (Received) Message

    ```ballerina
    public function main() {
        AS2Message messageResponse2 = check mftClient->retrieveInboxMessage(messageResponse1.messages[0]);
        io:println(">>>", messageResponse2);
    }

    Following is an example on listing certificates available.

    List Certificates

     ```ballerina
    public function main() {
        SuccessfulCertListRetrievalResponse listCertificates = check mftClient->listCertificates();
        io:println(listCertificates);
    }


2. Use `bal run` command to compile and run the Ballerina program.