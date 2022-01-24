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

# Azure Data Catalog.
public type ADCCatalog record {
    *Resource;
};

# The response from the List Azure Data Catalog operation.
public type ADCCatalogsListResult record {
    # the list of Azure Data Catalogs.
    ADCCatalog[] value?;
};

# Properties of the data catalog.
public type ADCCatalogProperties record {
    # Azure data catalog admin list.
    Principals[] admins?;
    # Automatic unit adjustment enabled or not.
    boolean enableAutomaticUnitAdjustment?;
    # Azure data catalog SKU.
    string sku?;
    # Azure data catalog provision status.
    boolean successfullyProvisioned?;
    # Azure data catalog units.
    int units?;
    # Azure data catalog user list.
    Principals[] users?;
};

# The operation supported by Azure Data Catalog Service.
public type OperationEntity record {
    # The operation supported by Azure Data Catalog Service.
    OperationDisplayInfo display?;
    # Operation name: {provider}/{resource}/{operation}.
    string name?;
};

# User principals.
public type Principals record {
    # Object Id for the user
    string objectId?;
    # UPN of the user.
    string upn?;
};

# The Resource model definition.
public type Resource record {
    # Resource etag
    string etag?;
    # Resource Id
    string id?;
    # Resource location
    string location?;
    # Resource name
    string name?;
    # Resource tags
    record {} tags?;
    # Resource type
    string 'type?;
};

# The operation supported by Azure Data Catalog Service.
public type OperationDisplayInfo record {
    # The description of the operation.
    string description?;
    # The action that users can perform, based on their permission level.
    string operation?;
    # Service provider: Azure Data Catalog Service.
    string provider?;
    # Resource on which the operation is performed.
    string 'resource?;
};

# The list of Azure data catalog service operation response.
public type OperationEntityListResult record {
    # The list of operations.
    OperationEntity[] value?;
};
