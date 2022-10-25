// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
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

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint..
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
#
# + keepAlive - Specifies whether to reuse a connection for multiple requests
# + chunking - The chunking behaviour of the request
# + proxy - Proxy server related options
public type ClientHttp1Settings record {|
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    http:Chunking chunking = http:CHUNKING_AUTO;
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
#
# + host - Host name of the proxy server
# + port - Proxy server port
# + userName - Proxy server username
# + password - Proxy server password
public type ProxyConfig record {|
    string host = "";
    int port = 0;
    string userName = "";
    @display {
        label: "",
        kind: "password"
    }
    string password = "";
|};

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
# 
# + authorization - Represents API Key `Authorization`
# + apikey - Represents API Key `apikey`
public type ApiKeysConfig record {|
    @display {
        label: "",
        kind: "password"
    }
    string authorization;
    @display {
        label: "",
        kind: "password"
    }
    string apikey;
|};

public type WkHtmlToPdfAdvancedOptions record {
    string orientation?;
    string pageSize?;
};

public type WkHtmlToPdfUrlToPdfRequest record {
    string fileName?;
    boolean inlinePdf?;
    WkHtmlToPdfAdvancedOptions options?;
    string url;
};

public type ApiResponseFailure record {
    # The reason for the PDF generation failure
    string reason?;
    # Will be false if the operation failed
    boolean success?;
};

public type ChromeUrlToPdfRequest record {
    string fileName?;
    boolean inlinePdf?;
    ChromeAdvancedOptions options?;
    string url;
};

public type MergeRequest record {
    string fileName?;
    boolean inlinePdf?;
    string[] urls;
};

public type LibreOfficeConvertRequest record {
    string fileName?;
    boolean inlinePdf?;
    string url;
};

public type ChromeAdvancedOptions record {
    string landscape?;
    boolean printBackground?;
};

public type ChromeHtmlToPdfRequest record {
    string fileName?;
    string html;
    boolean inlinePdf?;
    ChromeAdvancedOptions options?;
};

public type ApiResponseSuccess record {
    # Cost of the operation (mbIn + mbOut) * $.001
    decimal cost?;
    # The amount of megabytes of bandwidth used to process the pdf
    decimal mbIn?;
    # The amount of megabytes of bandwidth generated from the resulting pdf
    decimal mbOut?;
    # A url to the PDF that will exist only for 24 hours
    string pdf?;
    # Will be true if the operation suceeded
    boolean success?;
};

public type WkHtmlToPdfHtmlToPdfRequest record {
    string fileName?;
    string html;
    boolean inlinePdf?;
    WkHtmlToPdfAdvancedOptions options?;
};
