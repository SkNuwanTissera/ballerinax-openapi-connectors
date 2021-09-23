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

public type Account record {
    # Remaining API calls quota
    int remaining_api_calls?;
    # Next billing cycle start time (UNIX timestamp)
    int resets_at?;
    # Remaining concurrent requests
    int remaining_concurrency?;
};

# Array of elements matched by selectors
#
# + string - Array of elements matched by selectors
public type SelectedAreas string[];

public type PageError record {
    # Response HTTP status code (403, 500, etc)
    int status_code?;
    # Response HTTP status message
    string status_message?;
};

public type Error record {
    # Error description
    string message?;
};

public enum GetHTMLProxy {
    GETHTMLPROXY_DATACENTER = "datacenter",
    GETHTMLPROXY_RESIDENTIAL = "residential"
}

public enum GetSelectedProxy {
    GETSELECTEDPROXY_DATACENTER = "datacenter",
    GETSELECTEDPROXY_RESIDENTIAL = "residential"
}

public enum GetSelectedMultipleProxy {
    GETSELECTEDMULTIPLEPROXY_DATACENTER = "datacenter",
    GETSELECTEDMULTIPLEPROXY_RESIDENTIAL = "residential"
}
