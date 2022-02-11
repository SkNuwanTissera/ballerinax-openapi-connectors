## Overview
This is a generated connector for [Azure Analysis Services Web API](https://docs.microsoft.com/en-us/rest/api/analysisservices/) OpenAPI specification.

The Azure Analysis Services Web API provides a RESTful set of web services that enables users to create, retrieve, update, and delete Analysis Services servers.
 
## Prerequisites
- Create an [Azure](https://azure.microsoft.com/en-us/features/azure-portal/) account
- Create an [Azure Analysis Services Web API](https://docs.microsoft.com/en-us/rest/api/analysisservices/) account
- Obtain tokens by using [this](https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app)  guide.

## Quickstart
To use the Azure Analysis Services Web API connector in your Ballerina application, update the .bal file as follows:

### Step 1 - Import connector
First, import the ballerinax/azure.analysisservices module into the Ballerina project.
```ballerina
import ballerinax/azure.analysisservices;
```

### Step 2 - Create a new connector instance
You can now make the connection configuration using the access token.
```ballerina
analysisservices:ClientConfig clientConfig = {
    auth : {
        token: token
    }
};

analysisservices:Client baseClient = check new (clientConfig);
```
### Step 3 - Invoke connector operation

1. List operations

```ballerina
public function main() returns error? {
    analysisservices:OperationListResult|error operationList = baseClient->operationsList("2017-08-01");
    if (operationList is analysisservices:OperationListResult) {
        log:printInfo("Operation List " + operationList.toString());
    } else {
        log:printInfo("Error occured while retrieving the operation list");
    }
}
``` 
2. Use `bal run` command to compile and run the Ballerina program
