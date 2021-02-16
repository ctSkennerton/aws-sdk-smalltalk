Class {
	#name : #AWSConfig,
	#superclass : #Object,
	#instVars : [
		'settingsDict'
	],
	#category : #'AWS-Core'
}

{ #category : #'instance creation' }
AWSConfig class >> default [
	self subclassResponsibility
]

{ #category : #accessing }
AWSConfig >> accessKeyId [
	^self  at: #accessKeyId ifAbsent: []
]

{ #category : #accessing }
AWSConfig >> accessKeyId: anObject [
	^self  at: #accessKeyId put: anObject
]

{ #category : #accessing }
AWSConfig >> apiVersion [
	^self  at: #apiVersion ifAbsent: []
]

{ #category : #accessing }
AWSConfig >> apiVersion: anObject [
	^self at: #apiVersion put: anObject
]

{ #category : #accessing }
AWSConfig >> at: key [
	^self settingsDict at: key
]

{ #category : #accessing }
AWSConfig >> at: key ifAbsent: aBlock [
	^self settingsDict at: key ifAbsent: aBlock
]

{ #category : #accessing }
AWSConfig >> at: key ifAbsentPut: aBlock [
	^self settingsDict at: key ifAbsentPut: aBlock
]

{ #category : #accessing }
AWSConfig >> at: key put: value [
	^self settingsDict at: key put: value
]

{ #category : #defaults }
AWSConfig >> defaultProfileName [
	^ 'default'
]

{ #category : #defaults }
AWSConfig >> defaultRegionName [
	"AWS Regions Asia Pacific (Tokyo)"
	^ ''.
]

{ #category : #defaults }
AWSConfig >> defaultServiceName [
	^ ''
]

{ #category : #accessing }
AWSConfig >> endpoint [
	^self  at: #endpoint ifAbsent: [ self endpoint: self hostUrl ]
]

{ #category : #accessing }
AWSConfig >> endpoint: anObject [
	^self  at: #endpoint put: anObject
]

{ #category : #accessing }
AWSConfig >> hostUrl: anObject [
	self settingsDict removeKey: #endpoint ifAbsent: [  ].
	^ self at: #hostUrl put: anObject
]

{ #category : #initialization }
AWSConfig >> initialize [
	self populateFromConfig.
]

{ #category : #initialization }
AWSConfig >> populateFromConfig [
	"Read configuration values from ~/.aws/config and ~/.aws/credentials files"

	| configFile credentialFile configData |
	configFile := FileLocator home / '.aws' / 'config'.
	configFile exists
		ifTrue: [ configData := (IniReader on: configFile readStream) parse.
			self regionName: (configData at: self profileName at: 'region') ].
	
	credentialFile := FileLocator home / '.aws' / 'credentials'.
	credentialFile exists ifTrue: [ 
		configData := (IniReader on: credentialFile readStream) parse.
		self
		accessKeyId: (configData at: self profileName at: 'aws_access_key_id').
	self
		secretKey: (configData at: self profileName at: 'aws_secret_access_key')
		 ].
]

{ #category : #accessing }
AWSConfig >> profileName [
	^ self at: #profileName ifAbsentPut: [ self defaultProfileName ]
]

{ #category : #accessing }
AWSConfig >> profileName: anObject [
	^ self at: #profileName put: anObject
]

{ #category : #accessing }
AWSConfig >> regionName [
	^ self at: #regionName ifAbsentPut: [ self defaultRegionName ]
]

{ #category : #accessing }
AWSConfig >> regionName: anObject [
	self settingsDict removeKey: #hostUrl ifAbsent: [  ].
	self settingsDict removeKey: #endpoint ifAbsent: [  ].
	^ self at: #regionName put: anObject
]

{ #category : #accessing }
AWSConfig >> secretKey [
	^self  at: #secretKey ifAbsent: []
]

{ #category : #accessing }
AWSConfig >> secretKey: anObject [
	^self  at: #secretKey put: anObject
]

{ #category : #accessing }
AWSConfig >> serviceName [
	^self  at: #serviceName ifAbsent: [ self defaultServiceName ]
]

{ #category : #accessing }
AWSConfig >> serviceName: anObject [
	^self  at: #serviceName put: anObject
]

{ #category : #accessing }
AWSConfig >> sessionToken [
	^self  at: #sessionToken ifAbsent: []
]

{ #category : #accessing }
AWSConfig >> sessionToken: anObject [
	^self  at: #sessionToken put: anObject
]

{ #category : #accessing }
AWSConfig >> settingsDict [
	^ settingsDict ifNil: [settingsDict := IdentityDictionary new]
]

{ #category : #accessing }
AWSConfig >> useSSL [

	^self at: #useSSL ifAbsent: [ self useSSL: true ]
]

{ #category : #accessing }
AWSConfig >> useSSL: anObject [

	^self  at: #useSSL put: anObject
]
