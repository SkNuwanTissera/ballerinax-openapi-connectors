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

public type AssistValuesResponseAttributeJson record {
    boolean 'allow\-user\-values?;
    AssistValuesResponseValueJson[] values?;
};

public type XmlTypeBase record {
    *TypeBase;
    TypePropertyXml[] properties?;
    TypeLifecycleXml[] lifecycles?;
};

public type TypePropertyVaFixedListXml record {
    *TypePropertyVaCondition;
    string[] value?;
};

public type SearchResultsFeed record {
    *FeedBase;
    SearchResultEntry[] entries?;
    *AtomLinks;
};

public type Server record {
    string name?;
    string host?;
    string 'version?;
    string docbroker?;
};

public type BatchResponse record {
    *BatchRequestBase;
    string state?;
    string substate?;
    string submitted?;
    string started?;
    string finished?;
    string owner?;
    BatchResponseOperation[] operations?;
};

public type HalWorkQueue record {
    *HalObject;
};

public type Document record {
    *Object;
};

public type WorkItem record {
    *Object;
};

public type FederatedSearchResultEntry record {
    *FederatedSearchResultEntryBase;
    EntryContent content?;
    *AtomLinks;
};

public type SavedSearchBase record {
    record {} properties?;
    string 'query\-document?;
};

public type HalArchivedContents record {
    *ArchivedContents;
};

public type AuditPolicy record {
    *Object;
};

public type NetworkLocation record {
    *Object;
};

public type FederatedSearchResultsFeed record {
    *FeedBase;
    FederatedSearchResultEntry[] entries?;
    *AtomLinks;
};

public type InboxItem record {
    *Object;
};

public type HalSubscribers record {
    *Subscribers;
};

public type Permission record {
    string accessor?;
    int 'basic\-permission?;
    string 'extend\-permissions?;
    string 'application\-permission?;
};

public type LifecycleProcedure record {
    string id?;
    string name?;
    string 'version?;
};

public type SearchFulltextVariable record {
    string id?;
    string 'expression\-type?;
    string 'data\-type?;
    string 'variable\-value?;
};

public type AuditTrail record {
    *Object;
};

public type LifecycleEntryCriteria record {
    string id?;
    string expression?;
};

public type BatchOperationRequest record {
    *BatchOperationBase;
    string method?;
    string uri?;
};

public type BatchRequest record {
    *BatchRequestBase;
    BatchRequestOperation[] operations?;
};

public type TypeLifecyclesJson record {
    TypeLifecycleJson 'lifecycle\-id?;
};

public type AuditEventList record {
    *AuditEventListBase;
    *Links;
};

public type Lifecycle record {
    *LifecycleBase;
    *Links;
};

public type Workflow record {
    *Object;
};

public type CabinetBase record {
    *ObjectBase;
};

public type FederatedSearchResultEntryBase record {
    *SearchResultEntryBase;
    string 'source?;
};

public type Author record {
    string name?;
    string uri?;
    string email?;
};

public type HalLinks record {
    HalLinksMap _links?;
};

public type SearchPropertyListVariable record {
    string id?;
    string 'expression\-type?;
    string 'property\-name?;
    string 'data\-type?;
    string operator?;
    string[] 'variable\-values?;
};

public type HalFormat record {
    *HalObject;
};

public type Link record {
    string rel?;
    string hreftemplate?;
    string href?;
    string title?;
    string 'type?;
};

public type SearchResultEntry record {
    *SearchResultEntryBase;
    EntryContent content?;
    *AtomLinks;
};

public type WorkflowActivity record {
    *Object;
};

public type JsonType record {
    *JsonTypeBase;
    *Links;
};

public type Group record {
    *Object;
};

public type SavedSearch record {
    *SavedSearchBase;
    *Links;
};

public type WorkflowAttachmentsRequestBase record {
    string 'component\-id?;
    string 'component\-type?;
};

public type ObjectParentBase record {
    *ObjectBase;
};

public type HalsupportedfacetsEmbedded record {
    HalFacetEntry[] collection?;
};

public type Entry record {
    *EntryBase;
    EntryContent content?;
    *AtomLinks;
};

public type SearchPropertyExpression record {
    string value?;
    string name;
    boolean 'case\-sensitive?;
    boolean 'exact\-match?;
    boolean fuzzy?;
    boolean template?;
    boolean repeating?;
    string operator;
};

public type SearchPathLocation record {
    string path?;
    boolean repository?;
    boolean descendent?;
};

public type LifecycleTypeInclusion record {
    string 'type?;
    boolean 'include\-subtype?;
};

public type TypePropertyOfLifecycleBase record {
    int label?;
    boolean hidden?;
    boolean required?;
    boolean notnull?;
    boolean 'notnull\-enforce?;
    boolean 'notnull\-message?;
    boolean 'readonly?;
    boolean searchable?;
    boolean 'ignore\-immutable?;
    boolean 'ignore\-parent\-constraints?;
    TypeConstraint[] constraints?;
    string[] dependencies?;
};

public type HalRelation record {
    *HalObject;
};

public type SearchPropertyVariable record {
    string id?;
    string 'expression\-type?;
    string 'property\-name?;
    string 'data\-type?;
    string operator?;
    string 'variable\-value?;
};

public type BatchCapabilitiesBase record {
    string transactions?;
    string sequence?;
    string 'on\-error?;
    string[] 'batchable\-resources?;
    string[] 'non\-batchable\-resources?;
};

public type AuditEventListBase record {
    string[] events?;
};

public type TypeLifecycleStateXml record {
    string name?;
    TypeOfLifecycle 'type\-of\-lifecycle?;
};

public type SearchTemplate record {
    *SearchTemplateBase;
    *Links;
};

public type Acl record {
    *Object;
};

public type HalLinksMap record {};

public type WorkflowTaskPackageResponse record {
    string 'task\-id?;
    int index?;
    string 'package\-name?;
    string status?;
    boolean optional?;
    boolean visible?;
    string operation?;
    string 'required\-type?;
    string[] 'required\-labels?;
    int 'note\-count?;
    TaskPackageNote[] notes?;
    int 'document\-count?;
    string[] 'document\-ids?;
    int 'skill\-level?;
    boolean 'form\-template\-defined?;
    string 'form\-template\-name?;
    boolean 'form\-for\-properties?;
    *Links;
};

public type Repository record {
    *RepositoryBase;
    *Links;
};

public type RepositoryBase record {
    string id?;
    string name?;
    string description?;
    string 'auth\-protocol?;
    Server[] servers?;
    string[] domains?;
};

public type TypePropertyLifecycleStateXml record {
    string name?;
    // TypePropertyOfLifecycleXml 'property\-of\-lifecycle?;
};

public type HalVdSnapshot record {
    *VdSnapshotBase;
    *HalLinks;
};

public type HalObject record {
    *ObjectBase;
    *HalLinks;
};

public type WorkflowsrequestbaseNote record {
    string text?;
    boolean persistent?;
};

public type JsonTypeBase record {
    *TypeBase;
    TypePropertyJson[] properties?;
    TypeLifecyclesJson lifecycles?;
};

public type TypeScopeConfig record {
    string id?;
    string[] scope?;
    string[] catetory?;
    TypeDisplayConfig[] 'display\-configs?;
};

public type VdSnapshot record {
    *VdSnapshotBase;
    *Links;
};

public type HalDocument record {
    *HalObject;
};

public type EntryBase record {
    string id?;
    string title?;
    string summary?;
    string updated?;
    string published?;
};

public type HalCabinet record {
    *HalObject;
};

public type SearchRelativeDateVariable record {
    string id?;
    string 'expression\-type?;
    string 'property\-name?;
    string 'data\-type?;
    string 'variable\-value?;
};

public type TypePropertyDefaultValue record {
    string 'default\-literal?;
    string 'default\-expression?;
};

public type TypePropertyOfLifecycleXml record {
    *TypePropertyOfLifecycleBase;
    // TypePropertyVaXml 'value\-assist?;
};

public type ObjectAspectsBase record {
    string[] aspects?;
};

public type HalRepository record {
    *HalObject;
};

public type VersioningObject record {
    *ObjectBase;
};

public type HalSearchResultEntry record {
    *SearchResultEntryBase;
    *HalLinks;
};

public type ObjectBase record {
    record {} properties?;
};

public type UserBase record {
    *ObjectBase;
};

public type HalFolder record {
    *HalObject;
};

public type FolderLinkBase record {
    *ObjectBase;
};

public type TypeMapping record {
    string value?;
    string display?;
    string description?;
};

public type AuditPolicyBase record {
    *ObjectBase;
};

public type AssistValuesResponseAttributeXml record {
    boolean 'allow\-user\-values?;
    record {} value?;
};

public type TypePropertyOfLifecycleJson record {
    *TypePropertyOfLifecycleBase;
    // type-property-va-query-json|type-property-va-fixed-list-json[] 'value\-assist?;
};

public type WorkflowsRequestBase record {
    string href?;
    string 'workflow\-name?;
    string activity?;
    WorkflowsrequestbaseNote note?;
    string[] users?;
    string[] groups?;
    string[] 'object\-ids?;
    string instruction?;
    string priority?;
    int flags?;
};

public type HalUser record {
    *HalObject;
};

public type WorkflowTemplateBase record {
    *ObjectBase;
};

public type BatchOperationBase record {
    BatchOperationHeader[] headers?;
    string entity?;
};

public type TypeBase record {
    string name?;
    string label?;
    string parent?;
    string 'shared\-parent?;
    string category?;
    string 'default\-lifecycle?;
    string 'default\-lifecycle\-version?;
    boolean 'ignore\-parent\-constraints?;
    string 'help\-text?;
    string 'comment\-text?;
    string[] 'auditable\-system\-events?;
    string[] 'auditable\-app\-events?;
    TypeMapping[] 'mapping\-table?;
    TypeConstraint[] constraints?;
    TypeScopeConfig[] 'scope\-configs?;
};

public type LifecycleState record {
    string name?;
    string 'type?;
    string description?;
    boolean exceptional?;
    string 'exception\-state?;
    boolean 'allow\-attach?;
    boolean 'allow\-schedule?;
    boolean 'allow\-return\-to\-base?;
    boolean 'allow\-demote?;
    int no?;
    int index?;
    string[] 'return\-conditions?;
    LifecycleEntryCriteria 'entry\-criteria?;
    LifecycleProcedure 'user\-criteria?;
    LifecycleProcedure action?;
    LifecycleProcedure 'user\-action?;
    LifecycleProcedure 'user\-post\-action?;
    LifecycleModule 'user\-criteria\-service?;
    LifecycleModule 'user\-action\-service?;
    LifecycleModule 'user\-post\-service?;
    LifecycleModule 'system\-action?;
    string 'type\-override\-id?;
};

public type TaskPackageNote record {
    string text?;
    boolean persistent?;
    string 'creation\-date?;
    int flag?;
    string id?;
    string writer?;
    boolean 'is\-new?;
};

public type VdNodeBase record {
    record {} properties?;
    string 'book\-id?;
    string 'selected\-object\-name?;
    string 'selected\-object\-id?;
    string 'parent\-id?;
    string 'chronicle\-id?;
    string 'relation\-id?;
    int 'order\-number?;
    string binding?;
    boolean 'override\-late\-binding?;
    string 'copy\-behavior?;
    boolean 'follow\-assembly?;
    string 'node\-id?;
    string 'vdm\-number?;
    boolean 'is\-virtual\-document?;
    string 'late\-binding\-value?;
    boolean 'is\-binding\-broken?;
    boolean 'are\-children\-compound?;
    string[] 'available\-versions?;
    boolean 'can\-be\-removed?;
    boolean 'can\-be\-restructured?;
    int 'child\-count?;
    boolean 'is\-compound?;
    boolean 'is\-from\-assembly?;
    boolean 'is\-structurally\-modified?;
    string 'type?;
};

public type BatchResponseOperation record {
    *BatchRequestOperation;
    string state?;
    string started?;
    string finished?;
    BatchOperationResponse response?;
};

public type Relation record {
    *Object;
};

public type GroupBase record {
    *ObjectBase;
};

public type XmlAssistValuesResponse record {
    *XmlAssistValuesResponseBase;
    *Links;
};

public type TypeLifecycleXml record {
    string id?;
    TypeLifecycleStateXml[] state?;
};

public type TypePropertyXml record {
    *TypePropertyBase;
    // type-property-va-query-xml|type-property-va-fixed-list-xml[] 'value\-assist?;
    TypePropertyLifecycleXml[] lifecycles?;
};

public type FolderLink record {
    *Object;
};

public type HalPreference record {
    *HalObject;
};

public type WorkQueueTask record {
    *Object;
};

public type PreferenceBase record {
    *ObjectBase;
};

public type SupportedFacets record {
    *FeedBase;
    FacetEntry[] entries?;
    *AtomLinks;
};

public type ContentBase record {
    *ObjectBase;
};

public type HalBatchCapabilities record {
    *BatchCapabilitiesBase;
    *HalLinks;
};

public type TypeOfLifecycle record {
    string 'default\-lifecycle?;
    string 'default\-lifecycle\-version?;
    boolean 'ignore\-parent\-constraints?;
    TypeConstraint[] constraints?;
};

public type HalFeed record {
    *FeedBase;
    HalfeedEmbedded _embedded?;
    *HalLinks;
};

public type SubscribersBase record {
    *ObjectBase;
};

public type HalSupportedFacets record {
    *FeedBase;
    HalsupportedfacetsEmbedded _embedded?;
    *HalLinks;
};

public type XmlType record {
    *XmlTypeBase;
    *Links;
};

public type AssistValuesResponsePropertiesJson record {
    AssistValuesResponseAttributeJson 'attribute\-name?;
};

public type HalWorkflowAttachmentResponse record {
    *HalObject;
};

public type HalWorkflowTemplate record {
    *HalObject;
};

public type TypeConstraint record {
    string expression?;
    string enforce?;
    string dependency?;
    string message?;
};

public type LifecycleBase record {
    string id?;
    string name?;
    string title?;
    string subject?;
    string[] keywords?;
    string owner?;
    string created?;
    string modified?;
    string 'implementation\-type?;
    string[] 'version\-labels?;
    string[] 'alias\-sets?;
    LifecycleTypeInclusion[] 'type\-inclusions?;
    LifecycleModule 'user\-validation\-service?;
    LifecycleProcedure 'app\-validation?;
    string status?;
    string 'status\-message?;
    LifecycleState[] states?;
};

public type TypePropertyLifecycleJson record {
    TypePropertyOfLifecycleJson 'state\-name?;
};

public type AssistValuesResponseValueJson record {
    string value?;
    string label?;
};

public type HalAuditTrail record {
    *HalObject;
};

public type HalContent record {
    *HalObject;
};

public type FolderBase record {
    *ObjectBase;
};

public type RelationBase record {
    *ObjectBase;
};

public type XmlAssistValuesResponseBase record {
    AssistValuesResponseAttributeXml[] properties?;
};

public type ObjectAspects record {
    *ObjectAspectsBase;
    *Links;
};

public type HalComment record {
    *HalObject;
};

public type JsonAssistValuesResponseBase record {
    AssistValuesResponsePropertiesJson properties?;
};

public type AclBase record {
    *ObjectBase;
};

public type HalLifecycle record {
    *LifecycleBase;
    *HalLinks;
};

public type SearchFacetDefinition record {
    string[] attributes?;
    record {} properties?;
    string sort?;
    string 'group\-by?;
    string id?;
    int 'max\-values?;
};

public type HalSearchTemplate record {
    *SearchTemplateBase;
    *HalLinks;
};

public type Preference record {
    string 'client?;
    string 'owner\-name?;
    string title?;
    string subject?;
    string[] keywords?;
    string 'creation\-date?;
    string 'modify\-date?;
    string 'preference\-content?;
};

public type HalGroup record {
    *HalObject;
};

public type TypeDisplayConfig record {
    string name?;
    string id?;
    string 'attribute\-source?;
    string 'fixed\-display?;
    TypeAttributeHint[] 'attribute\-hints?;
};

public type HalVdNode record {
    *VdNodeBase;
    *HalLinks;
};

public type Object record {
    *ObjectBase;
    *Links;
};

public type HalSavedSearch record {
    *SavedSearchBase;
    *HalLinks;
};

public type HalPermission record {
    *HalObject;
};

public type SearchPropertyListExpression record {
    string[] values?;
    string name;
    boolean template?;
    boolean repeating?;
    string operator;
};

public type ArchivedContentsBase record {
    *ObjectBase;
};

public type HalFolderLink record {
    *HalObject;
};

public type WorkflowTemplate record {
    *Object;
};

public type HalFederatedSearchResultsFeed record {
    *FeedBase;
    HalfederatedsearchresultsfeedEmbedded _embedded?;
    *HalLinks;
};

public type TypePropertyBase record {
    string name?;
    boolean repeating?;
    string 'type?;
    int length?;
    int label?;
    boolean hidden?;
    boolean required?;
    boolean notnull?;
    boolean 'notnull\-enforce?;
    boolean 'notnull\-message?;
    boolean 'readonly?;
    boolean searchable?;
    string 'default\-literal?;
    string 'default\-expression?;
    int 'display\-hint?;
    string 'help\-text?;
    string 'comment\-text?;
    string category?;
    boolean 'ignore\-immutable?;
    boolean 'ignore\-parent\-constraints?;
    TypePropertyDefaultValue[] defaults?;
    TypeMapping[] 'mapping\-table?;
    TypeConstraint[] constraints?;
    string[] dependencies?;
};

public type HalObjectAspects record {
    *ObjectAspectsBase;
    *HalLinks;
};

public type Folder record {
    *Object;
};

public type HalFacetEntry record {
    string id?;
    string title?;
    string 'type?;
    string summary?;
    string updated?;
    string published?;
    *HalLinks;
};

public type VdSnapshotBase record {
    *ObjectBase;
};

public type HalRelationType record {
    *HalObject;
};

public type BatchOperationHeader record {
    string name?;
    string value?;
};

public type HalLink record {
    string href?;
    boolean templated?;
    string title?;
    string 'type?;
};

public type AtomLinks record {
    Link[] links?;
};

public type JsonAssistValuesResponse record {
    *JsonAssistValuesResponseBase;
    *Links;
};

public type HalAssistValuesRequest record {
    *ObjectBase;
};

public type WorkflowTaskPackageRequest record {
    string[] 'document\-ids?;
    TaskPackageNoteBase[] notes?;
};

public type HalfeedEmbedded record {
    HalEntry[] collection?;
};

public type RelationType record {
    *Object;
};

public type HalFederatedSearchResultEntry record {
    *FederatedSearchResultEntryBase;
    *HalLinks;
};

public type TypePropertyJson record {
    *TypePropertyBase;
    // type-property-va-query-json|type-property-va-fixed-list-json[] 'value\-assist?;
    TypepropertyjsonLifecycles lifecycles?;
};

public type HalAspectType record {
    *HalObject;
};

public type DocumentBase record {
    *ObjectBase;
};

public type SearchQuery record {
    string[] types?;
    string[] repositories?;
    string[] columns?;
    string[] collections?;
    SearchSort[] sorts?;
    search-id-location|search-path-location[] locations?;
    SearchFacetDefinition[] 'facet\-definitions?;
    SearchExpressionSet 'expression\-set?;
    boolean 'all\-versions?;
    boolean 'include\-hidden\-objects?;
    int 'max\-results\-for\-facets?;
};

public type TypeAttributeHint record {
    string attribute?;
    int 'display\-hint?;
};

public type HalPermissionSet record {
    *HalObject;
};

public type HalEntry record {
    *EntryBase;
    *HalLinks;
};

public type WorkflowAttachmentResponse record {
    string 'object\-id?;
    string 'component\-id?;
    string 'component\-name?;
    string 'component\-type?;
    string 'creator\-name?;
    string 'creation\-date?;
    string 'workflow\-id?;
    *Links;
};

public type Cabinet record {
    *Object;
};

public type SearchIdLocation record {
    string id?;
    boolean repository?;
    boolean descendent?;
};

public type BatchCapabilities record {
    *BatchCapabilitiesBase;
    *Links;
};

public type TypePropertyVaQueryJson record {
    *TypePropertyVaCondition;
    string 'type?;
    boolean 'allow\-caching?;
    string 'query\-attribute?;
    string 'query\-expression?;
};

public type HalAcl record {
    *HalObject;
};

public type CommentBase record {
    *ObjectBase;
};

public type TypePropertyLifecycleXml record {
    string id?;
    TypePropertyLifecycleStateXml[] state?;
};

public type Subscribers record {
    string[] subscribers?;
};

public type PermissionSetBase record {
    *ObjectBase;
};

public type EntryContent record {
    string 'type?;
    string src?;
};

public type BatchRequestBase record {
    string description?;
    boolean 'transactional?;
    boolean sequential?;
    string 'on\-error?;
    boolean 'return\-request?;
};

public type HalAuditEventList record {
    *AuditEventListBase;
    *HalLinks;
};

public type SearchResultEntryBase record {
    *EntryBase;
    string score?;
    string[] terms?;
};

public type BatchOperationResponse record {
    *BatchOperationBase;
    int status?;
};

public type SearchFacetProperty record {
    string name;
    string property?;
};

public type VdNode record {
    *VdNodeBase;
    *Links;
};

public type HalObjectParent record {
    string href?;
};

public type Feed record {
    *FeedBase;
    Entry[] entries?;
    *AtomLinks;
};

public type TypePropertyVaQueryXml record {
    *TypePropertyVaCondition;
    boolean 'allow\-caching?;
    string 'query\-attribute?;
    string 'query\-expression?;
};

public type JsonHalType record {
    *JsonTypeBase;
    *HalLinks;
};

public type HalWorkflow record {
    *HalObject;
};

public type TypepropertyjsonLifecycles record {
    TypePropertyLifecycleJson 'lifecycle\-id?;
};

public type SearchPropertyRangeExpression record {
    string 'from;
    string to;
    string name;
    boolean template?;
    boolean repeating?;
    string operator;
};

public type HalWorkflowActivity record {
    *HalObject;
};

public type HalAuditPolicy record {
    *HalObject;
};

public type JsonAssistValuesRequest record {
    *ObjectBase;
};

public type HalInboxItem record {
    *HalObject;
};

public type SearchRelativeDateExpression record {
    int value;
    string name;
    boolean template?;
    boolean repeating?;
    string operator;
    string 'time\-unit;
};

public type SearchTemplateBase record {
    record {} properties?;
    string 'query\-document\-template?;
    // search-fulltext-variable|search-property-variable|search-property-list-variable|search-relative-date-variable[] 'external\-variables?;
};

public type PermissionSet record {
    Permission[] permitted?;
    Permission[] restricted?;
    string[] 'required\-group?;
    string[] 'required\-group\-set?;
};

public type Content record {
    *Object;
};

public type SearchExpressionSet record {
    // search-fulltext-expression|search-property-expression|search-property-list-expression|search-property-range-expression|search-relative-date-expression|search-expression-set[] expressions?;
    string operator?;
};

public type HalAuditEvent record {
    *HalObject;
};

public type HalWorkItem record {
    *HalObject;
};

public type TypePropertyVaFixedListJson record {
    *TypePropertyVaCondition;
    string 'type?;
    string[] values?;
};

public type TypePropertyVaCondition record {
    string condition?;
    boolean 'allow\-user\-values?;
};

public type HalWorkflowTaskPackageResponse record {
    *HalObject;
};

public type User record {
    *Object;
};

public type FacetEntry record {
    string id?;
    string title?;
    string 'type?;
    string summary?;
    string updated?;
    string published?;
    *AtomLinks;
};

public type XmlAssistValuesRequest record {
    *ObjectBase;
};

public type BatchRequestOperation record {
    string id?;
    string description?;
    BatchOperationRequest request?;
};

public type TypeLifecycleJson record {
    TypeOfLifecycle 'state\-name?;
};

public type WorkQueue record {
    *Object;
};

public type FeedBase record {
    string id?;
    string title?;
    Author[] author?;
    string updated?;
    int page?;
    int 'items\-per\-page?;
    int total?;
};

public type HalNetworkLocation record {
    *HalObject;
};

public type HalBatchResponse record {
    *HalObject;
};

public type Format record {
    *Object;
};

public type JsonHalAssistValuesResponse record {
    *JsonAssistValuesResponseBase;
    *HalLinks;
};

// public type  HalLinkValue hal-link|hal-link-array;

public type ObjectParent record {
    string href?;
};

public type AuditEvent record {
    *Object;
};

public type TaskPackageNoteBase record {
    string text?;
    boolean persistent?;
};

public type HalfederatedsearchresultsfeedEmbedded record {
    HalFederatedSearchResultEntry[] collection?;
};

public type Body record {
    BatchRequest batch?;
    string[] attachments?;
};

public type HalSearchResultsFeed record {
    *FeedBase;
    HalsearchresultsfeedEmbedded _embedded?;
    *HalLinks;
};

public type HalLinkArray HalLink[];

public type JsonHalAssistValuesRequest record {
    *ObjectBase;
};

public type LifecycleModule record {
    string id?;
    string name?;
    string 'primary\-class?;
};

// public type TypePropertyVaXml type-property-va-query-xml|type-property-va-fixed-list-xml[];

public type Comment record {
    *Object;
};

public type HalWorkQueueTask record {
    *HalObject;
};

public type AuditEventBase record {
    *ObjectBase;
};

public type AspectType record {
    *Object;
};

public type Error record {
    int status?;
    string code?;
    string message?;
    string details?;
    string id?;
};

public type SearchFulltextExpression record {
    string value?;
    boolean fuzzy?;
    boolean template?;
};

public type ArchivedContents record {
    string[] hrefs?;
};

public type Links record {
    Link[] links?;
};

public type HalsearchresultsfeedEmbedded record {
    HalSearchResultEntry[] collection?;
};

public type SearchSort record {
    string property?;
    boolean 'ascending?;
    string locale?;
    boolean isAscii?;
};
