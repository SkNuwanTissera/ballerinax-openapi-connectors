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
  
public type UnsubscribeAddress record {
    boolean ok;
    string ethereumaddress;
    string contractaddress;
    string url;
    boolean deleted;
};

public type GetExchangeRate record {
    boolean ok;
    string currency;
    decimal rate;
};

public type GetTokenRequest record {
    string contractaddress;
};

public type GetTokenBalanceRequest record {
    string contractaddress;
    string ethereumaddress;
};

public type Address record {
    string ethereumaddress;
};

public type SubscribeAddressRequest record {
    string ethereumaddress;
    string contractaddress;
    string url;
};

public type Ipn record {
    string ethereumaddress;
    string contractaddress;
    string url;
};

public type NewAddress record {
    boolean ok;
    string ethereumaddress;
    string password;
};

public type GetTransactionsRequest record {
    string txid;
};

public type ResendFailedIPNRequest record {
    int id;
};

public type ClearAddressRequest record {
    string ethereumaddress;
    string newaddress;
    string password;
};

public type ImportAddressRequest record {
    string filename;
    Content content;
    string password;
};

public type ExportAddress record {
    boolean ok;
    string filename;
    string content;
};

public type GetTransactions record {
    boolean ok;
    Transaction[] transactions;
};

public type ImportAddress record {
    boolean ok;
    string ethaddress;
    string filename;
};

public type ExportAddressRequest record {
    string ethaddress;
    string password;
};

public type GetTokenBalance record {
    boolean ok;
    string contractaddress;
    string ethereumaddress;
    int balance;
};

public type SendTokenRequest record {
    string contractaddress;
    string 'from;
    string to;
    string password;
    int amount;
    string identifier;
};

public type ListAddresses record {
    boolean ok;
    Address[] addresses;
};

public type SendToken record {
    boolean ok;
    string identifier;
    string txid;
    string contractaddress;
    string 'from;
    string to;
    int amount;
};

public type ResendFailedIPN record {
    boolean ok;
    int id;
};

public type SendEthereum record {
    boolean ok;
    string txid;
    string 'from;
    string to;
    string amount;
};

public type UnsubscribeAddressRequest record {
    string ethereumaddress;
    string contractaddress;
    string url;
};

public type ListFailedIPNs record {
    boolean ok;
    FailedIpn[] failed_ipns;
};

public type SendEthereumRequest record {
    string 'from;
    string to;
    string password;
    decimal amount;
};

public type DeleteAddress record {
    boolean ok;
    string ethereumaddress;
    boolean deleted;
};

public type GetToken record {
    boolean ok;
    string contractaddress;
    string name;
    string symbol;
    int decimals;
    int supply;
};

public type GetBlockRequest record {
    string block;
};

public type GetLastBlockNumber record {
    boolean ok;
    int blocknumber;
};

public type GetExchangeRateRequest record {
    string currency;
};

public type GetEthereumBalance record {
    boolean ok;
    string ethereumaddress;
    decimal balance;
};

public type ClearAddress record {
    boolean ok;
    string txid;
    string ethereumaddress;
    string newaddress;
    decimal amount;
    decimal gas;
    string total;
};

public type GetEthereumBalanceRequest record {
    string ethereumaddress;
};

public type Crypto record {
    string ciphertext;
    Cipherparams cipherparams;
    string cipher;
    string kdf;
    Kdfparams kdfparams;
    string mac;
};

public type SubscribeAddress record {
    boolean ok;
    string ethereumaddress;
    string contractaddress;
    string url;
};

public type Cipherparams record {
    string iv;
};

public type Transaction record {
    string txid;
    string block_number;
    string contract_address;
    string 'type;
    string token_name;
    string token_symbol;
    string token_decimals;
    string token_supply;
    string gas;
    string gas_price;
    string 'from;
    string to;
    string amount;
};

public type GetGasPrice record {
    boolean ok;
    int gasprice;
};

public type FailedIpn record {
    string id;
    string timestamp;
    string ethereumaddress;
    string contractaddress;
    string amount;
    string url;
    string action;
};

public type NewAddressRequest record {
    string password;
};

public type DeleteAddressRequest record {
    string ethereumaddress;
    string password;
};

public type Content record {
    int 'version;
    string id;
    string address;
    Crypto crypto;
};

public type GetBlock record {
    boolean ok;
    string hash;
    string block_number;
    string parent_hash;
    string miner;
    string difficulty;
    string size_in_bytes;
    string gas_limit;
    string gas_used;
    string time_stamp;
    string transactions_count;
};

public type ListSubscribedAddresses record {
    boolean ok;
    Ipn[] ipns;
};

public type Kdfparams record {
    int dklen;
    string salt;
    int n;
    int r;
    int p;
};
