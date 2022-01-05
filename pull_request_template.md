# Description

Please include a summary of the change and which issue is fixed. Please also include relevant motivation and context. List any dependencies that are required for this change.

Fixes # (issue)

Related Pull Requests (remove if not relevant)
- Pull request 1
- Pull request 2

One line release note: 
- One line describing the feature/improvement/fix made by this PR 

## Type of change

Please delete options that are not relevant.

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] This change requires a documentation update

# How Has This Been Tested?

Please describe the tests that you ran to verify your changes. Provide instructions so we can reproduce. Please also list any relevant details for your test configuration

- [ ] Test A
- [ ] Test B

**Test Configuration**:
* Ballerina Version:
* Operating System:
* Java SDK: 

# Checklist:

### Changes to OpenAPI definition

- [ ] Modified `info` section of the OpenAPI definition file - [Example](https://github.com/ballerina-platform/ballerina-extended-library/discussions/74)

    - `description` - what the connector is about 
    - `x-ballerina-init-description` OpenAPI extension - connector initialization details 
    - `x-ballerina-display` OpenAPI extension - connector name and path to the connector icon 

- [ ] Added proper description each API Key, if API Key authentication is defined in OpenAPI definition file 

### Changes to connector module

- [ ] Added license header at the top of each .bal file. 
- [ ] Added Package.md as per the guide [here](https://github.com/ballerina-platform/ballerina-extended-library/discussions/77)
- [ ] Added Module.md for the module of the  connector as per the guide [here](https://github.com/ballerina-platform/ballerina-extended-library/discussions/78)
- [ ] Added connector icon to the root of the connector. Icon needs to be a `png` of 200x200 px size with name `icon.png`
- [ ] Added Ballerina.toml file with following information. For keywords refer to [guide](https://github.com/ballerina-platform/ballerina-extended-library/discussions/72)

### Verifying connector module

- [ ] Compiled the connector successfully with the targeted ballerina version. 
- [ ] Conducted smoke tests on the connector (Recommended when OpenAPI definition is obtain from an unofficial source)

### Security checks
 - [ ] Followed secure coding standards in http://wso2.com/technical-reports/wso2-secure-engineering-guidelines? 
 - [ ] Confirmed that this PR doesn't commit any keys, passwords, tokens, usernames, or other secrets? 