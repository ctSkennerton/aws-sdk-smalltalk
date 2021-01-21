"
<p>Amazon Athena is an interactive query service that lets you use standard SQL to analyze data directly in Amazon S3. You can point Athena at your data in Amazon S3 and run ad-hoc queries and get results in seconds. Athena is serverless, so there is no infrastructure to set up or manage. You pay only for the queries you run. Athena scales automatically—executing queries in parallel—so results are fast, even with large datasets and complex queries. For more information, see <a href=""""http://docs.aws.amazon.com/athena/latest/ug/what-is.html"""">What is Amazon Athena</a> in the <i>Amazon Athena User Guide</i>.</p> <p>If you connect to Athena using the JDBC driver, use version 1.1.0 of the driver or later with the Amazon Athena API. Earlier version drivers do not support the API. For more information and to download the driver, see <a href=""""https://docs.aws.amazon.com/athena/latest/ug/connect-with-jdbc.html"""">Accessing Amazon Athena with JDBC</a>.</p> <p>For code samples using the AWS SDK for Java, see <a href=""""https://docs.aws.amazon.com/athena/latest/ug/code-samples.html"""">Examples and Code Samples</a> in the <i>Amazon Athena User Guide</i>.</p>
"
Class {
	#name : #AWSAthenaClient,
	#superclass : #Object,
	#classVars : [
		'apiVersion',
		'endpointPrefix',
		'jsonVersion',
		'protocol',
		'serviceFullName',
		'serviceId',
		'signatureVersion',
		'targetPrefix',
		'uid'
	],
	#category : #'AWS-Service'
}

{ #category : #'as yet unclassified' }
AWSAthenaClient >> batchGetNamedQuery: aBatchGetNamedQueryInput [
	"<p>Returns the details of a single named query or a list of up to 50 queries, which you provide as an array of query ID strings. Requires you to have access to the workgroup in which the queries were saved. Use <a>ListNamedQueriesInput</a> to get the list of named query IDs in the specified workgroup. If information could not be retrieved for a submitted query ID, information about the query ID submitted is listed under <a>UnprocessedNamedQueryId</a>. Named queries differ from executed queries. Use <a>BatchGetQueryExecutionInput</a> to get details about each unique query execution, and <a>ListQueryExecutionsInput</a> to get a list of query execution IDs.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> batchGetQueryExecution: aBatchGetQueryExecutionInput [
	"<p>Returns the details of a single query execution or a list of up to 50 query executions, which you provide as an array of query execution ID strings. Requires you to have access to the workgroup in which the queries ran. To get a list of query execution IDs, use <a>ListQueryExecutionsInput$WorkGroup</a>. Query executions differ from named (saved) queries. Use <a>BatchGetNamedQueryInput</a> to get details about named queries.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> createDataCatalog: aCreateDataCatalogInput [
	"<p>Creates (registers) a data catalog with the specified name and properties. Catalogs created are visible to all users of the same AWS account.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> createNamedQuery: aCreateNamedQueryInput [
	"<p>Creates a named query in the specified workgroup. Requires that you have access to the workgroup.</p> <p>For code samples using the AWS SDK for Java, see <a href=""http://docs.aws.amazon.com/athena/latest/ug/code-samples.html"">Examples and Code Samples</a> in the <i>Amazon Athena User Guide</i>.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> createWorkGroup: aCreateWorkGroupInput [
	"<p>Creates a workgroup with the specified name.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> deleteDataCatalog: aDeleteDataCatalogInput [
	"<p>Deletes a data catalog.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> deleteNamedQuery: aDeleteNamedQueryInput [
	"<p>Deletes the named query if you have access to the workgroup in which the query was saved.</p> <p>For code samples using the AWS SDK for Java, see <a href=""http://docs.aws.amazon.com/athena/latest/ug/code-samples.html"">Examples and Code Samples</a> in the <i>Amazon Athena User Guide</i>.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> deleteWorkGroup: aDeleteWorkGroupInput [
	"<p>Deletes the workgroup with the specified name. The primary workgroup cannot be deleted.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> getDataCatalog: aGetDataCatalogInput [
	"<p>Returns the specified data catalog.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> getDatabase: aGetDatabaseInput [
	"<p>Returns a database object for the specfied database and data catalog.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> getNamedQuery: aGetNamedQueryInput [
	"<p>Returns information about a single query. Requires that you have access to the workgroup in which the query was saved.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> getQueryExecution: aGetQueryExecutionInput [
	"<p>Returns information about a single execution of a query if you have access to the workgroup in which the query ran. Each time a query executes, information about the query execution is saved with a unique ID.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> getQueryResults: aGetQueryResultsInput [
	"<p>Streams the results of a single query execution specified by <code>QueryExecutionId</code> from the Athena query results location in Amazon S3. For more information, see <a href=""https://docs.aws.amazon.com/athena/latest/ug/querying.html"">Query Results</a> in the <i>Amazon Athena User Guide</i>. This request does not execute the query but returns results. Use <a>StartQueryExecution</a> to run a query.</p> <p>To stream query results successfully, the IAM principal with permission to call <code>GetQueryResults</code> also must have permissions to the Amazon S3 <code>GetObject</code> action for the Athena query results location.</p> <important> <p>IAM principals with permission to the Amazon S3 <code>GetObject</code> action for the query results location are able to retrieve query results from Amazon S3 even if permission to the <code>GetQueryResults</code> action is denied. To restrict user or role access, ensure that Amazon S3 permissions to the Athena query location are denied.</p> </important>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> getTableMetadata: aGetTableMetadataInput [
	"<p>Returns table metadata for the specified catalog, database, and table.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> getWorkGroup: aGetWorkGroupInput [
	"<p>Returns information about the workgroup with the specified name.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> listDataCatalogs: aListDataCatalogsInput [
	"<p>Lists the data catalogs in the current AWS account.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> listDatabases: aListDatabasesInput [
	"<p>Lists the databases in the specified data catalog.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> listNamedQueries: aListNamedQueriesInput [
	"<p>Provides a list of available query IDs only for queries saved in the specified workgroup. Requires that you have access to the specified workgroup. If a workgroup is not specified, lists the saved queries for the primary workgroup.</p> <p>For code samples using the AWS SDK for Java, see <a href=""http://docs.aws.amazon.com/athena/latest/ug/code-samples.html"">Examples and Code Samples</a> in the <i>Amazon Athena User Guide</i>.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> listQueryExecutions: aListQueryExecutionsInput [
	"<p>Provides a list of available query execution IDs for the queries in the specified workgroup. If a workgroup is not specified, returns a list of query execution IDs for the primary workgroup. Requires you to have access to the workgroup in which the queries ran.</p> <p>For code samples using the AWS SDK for Java, see <a href=""http://docs.aws.amazon.com/athena/latest/ug/code-samples.html"">Examples and Code Samples</a> in the <i>Amazon Athena User Guide</i>.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> listTableMetadata: aListTableMetadataInput [
	"<p>Lists the metadata for the tables in the specified data catalog database.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> listTagsForResource: aListTagsForResourceInput [
	"<p>Lists the tags associated with an Athena workgroup or data catalog resource.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> listWorkGroups: aListWorkGroupsInput [
	"<p>Lists available workgroups for the account.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> startQueryExecution: aStartQueryExecutionInput [
	"<p>Runs the SQL query statements contained in the <code>Query</code>. Requires you to have access to the workgroup in which the query ran. Running queries against an external catalog requires <a>GetDataCatalog</a> permission to the catalog. For code samples using the AWS SDK for Java, see <a href=""http://docs.aws.amazon.com/athena/latest/ug/code-samples.html"">Examples and Code Samples</a> in the <i>Amazon Athena User Guide</i>.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> stopQueryExecution: aStopQueryExecutionInput [
	"<p>Stops a query execution. Requires you to have access to the workgroup in which the query ran.</p> <p>For code samples using the AWS SDK for Java, see <a href=""http://docs.aws.amazon.com/athena/latest/ug/code-samples.html"">Examples and Code Samples</a> in the <i>Amazon Athena User Guide</i>.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> tagResource: aTagResourceInput [
	"<p>Adds one or more tags to an Athena resource. A tag is a label that you assign to a resource. In Athena, a resource can be a workgroup or data catalog. Each tag consists of a key and an optional value, both of which you define. For example, you can use tags to categorize Athena workgroups or data catalogs by purpose, owner, or environment. Use a consistent set of tag keys to make it easier to search and filter workgroups or data catalogs in your account. For best practices, see <a href=""https://aws.amazon.com/answers/account-management/aws-tagging-strategies/"">Tagging Best Practices</a>. Tag keys can be from 1 to 128 UTF-8 Unicode characters, and tag values can be from 0 to 256 UTF-8 Unicode characters. Tags can use letters and numbers representable in UTF-8, and the following characters: + - = . _ : / @. Tag keys and values are case-sensitive. Tag keys must be unique per resource. If you specify more than one tag, separate them by commas.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> untagResource: aUntagResourceInput [
	"<p>Removes one or more tags from a data catalog or workgroup resource.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> updateDataCatalog: aUpdateDataCatalogInput [
	"<p>Updates the data catalog that has the specified name.</p>"
	
]

{ #category : #'as yet unclassified' }
AWSAthenaClient >> updateWorkGroup: aUpdateWorkGroupInput [
	"<p>Updates the workgroup with the specified name. The workgroup's name cannot be changed.</p>"
	
]
