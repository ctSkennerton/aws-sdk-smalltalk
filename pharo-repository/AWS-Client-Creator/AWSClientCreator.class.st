Class {
	#name : #AWSClientCreator,
	#superclass : #Object,
	#instVars : [
		'removePreviouslyDefinedClasses'
	],
	#category : #'AWS-Client-Creator'
}

{ #category : #creation }
AWSClientCreator >> createClassMessage: messageData service: aService [
]

{ #category : #creation }
AWSClientCreator >> createFromJson: aDictionary [
	"Create an AWS client from a template JSON object provided by AWS.
	
	 The input dictionary must contain 5 top-level keys: operations, version, shapes, 
	 metadata, documentation.
	"
	| newService serviceId |
	
	serviceId := ((aDictionary at: 'metadata') at: 'serviceId').
	newService := AWSClient subclass: ('AWS' , serviceId, 'Client') asSymbol
	       instanceVariableNames: ''
			 classVariableNames: (' ' join: (aDictionary at: 'metadata') keys)
			 package: 'AWS-', serviceId, '-core'.
	
	newService comment: (aDictionary at: 'documentation') escapeComment .
	
	self initializeClassVariables: (aDictionary at: 'metadata') service: newService. 
	
	(aDictionary at: 'operations') valuesDo: [ :i |
		self createMessage: i service: newService.	
	]
			
	
]

{ #category : #creation }
AWSClientCreator >> createMessage: messageData service: service [
	| msgStream |
	msgStream := WriteStream with: String new.
	msgStream nextPutAll: (self toCamelCase: (messageData at: 'name')).
	msgStream
		nextPutAll: ': a';
		nextPutAll: ((messageData at: 'input') at: 'shape').
	msgStream crtab.
	msgStream nextPut: $".
	msgStream nextPutAll: (messageData at: 'documentation') escapeComment .
	msgStream nextPut: $".
	msgStream crtab.
	service compile: msgStream contents
]

{ #category : #formatting }
AWSClientCreator >> formatComment: aString [
	"I take the documentation in the AWS specification and convert it into Markdown to be added to class and selector comments."	
	
	"We make the assumption that there is a single <html> and single <body>"
	aString parseHTML firstElement firstElement 
]

{ #category : #initialization }
AWSClientCreator >> initialize [
	removePreviouslyDefinedClasses := true.
]

{ #category : #creation }
AWSClientCreator >> initializeClassVariables: metadataDictionary service: aService [
	"Create and initialize class method that takes the metadata associated with this service"
	| msgStream |
	msgStream := WriteStream with: String new.
	msgStream nextPutAll: 'initialize';
		crtab.
	
	metadataDictionary associationsDo: [ :pair | 
		msgStream nextPutAll: pair key;
			nextPutAll: ' := ''';
			nextPutAll: pair value;
			nextPutAll: '''.';
			crtab.
			
		].
	
	aService class compile: msgStream contents
	
]

{ #category : #formatting }
AWSClientCreator >> toCamelCase: aName [
	"Convert a string to have the first character be lower case."
	
			
	^((aName at:1) lowercase asString), (aName allButFirst)
]
