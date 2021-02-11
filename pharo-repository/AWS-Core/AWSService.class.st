Class {
	#name : #AWSService,
	#superclass : #Object,
	#instVars : [
		'client',
		'endpoint'
	],
	#category : #'AWS-Core'
}

{ #category : #accessing }
AWSService class >> endpointPrefix [

	self subclassResponsibility .
]

{ #category : #accessing }
AWSService >> amzDatePrintString [
	^ DateAndTime amzDatePrintString
	
]

{ #category : #accessing }
AWSService >> awsConfig [
	^ self defaultConfigClass 
]

{ #category : #accessing }
AWSService >> client [
	^ client ifNil:[ client := self defaultClient ]
]

{ #category : #private }
AWSService >> createRequest: aRequestBody url: url method: method [
	| datetimeString request |
	datetimeString := DateAndTime amzDatePrintString.
	
	
	request := ZnRequest empty.
	request method: method.
	request url: url.

	request entity:(ZnEntity with: aRequestBody type: (ZnMimeType textPlain)). 
	request headers at:'host' put: self hostUrl.
	"request headers at:'x-amz-content-sha256' put: (SHA256 new hashMessage: aRequestBody) hex."
	request headers at:'x-amz-date' put: datetimeString.
	"request headers at: 'X-Amz-Target' put: 'AmazonAthena.ListWorkGroups'."
	request headers at: 'content-type' put: 'application/x-amz-json-1.1'.
	request setAuthorization: ( SignatureV4 creatAuthorization: request andConfig: self client awsConfig andDateTime: datetimeString andOption: nil ) .
	^ request 
]

{ #category : #private }
AWSService >> createRequest: aRequestBody url: url method: method target: target [
	| datetimeString request |
	datetimeString := DateAndTime amzDatePrintString.
	
	
	request := ZnRequest empty.
	request method: method.
	request url: url.

	request entity:(ZnEntity with: aRequestBody type: (ZnMimeType textPlain)). 
	request headers at:'host' put: self hostUrl.
	"request headers at:'x-amz-content-sha256' put: (SHA256 new hashMessage: aRequestBody) hex."
	request headers at:'x-amz-date' put: datetimeString.
	request headers at: 'X-Amz-Target' put: target.
	request headers at: 'content-type' put: self class contentType.
	request setAuthorization: ( SignatureV4 creatAuthorization: request andConfig: self client awsConfig andDateTime: datetimeString andOption: nil ) .
	^ request 
]

{ #category : #defaults }
AWSService >> defaultClient [
	^ self defaultClientClass awsConfig: self awsConfig
]

{ #category : #defaults }
AWSService >> defaultClientClass [
	^ AWSClient
]

{ #category : #defaults }
AWSService >> defaultConfigClass [
	^ AWSConfig 
]

{ #category : #defaults }
AWSService >> defaultResponseClass [
	^ AWSResponse 
]

{ #category : #accessing }
AWSService >> hostUrl [
	^self class endpointPrefix,'.', self client awsConfig regionName, '.amazonaws.com'.
]

{ #category : #private }
AWSService >> readJsonFromResponse: response [

	^ (self defaultResponseClass on: response) value.
]
