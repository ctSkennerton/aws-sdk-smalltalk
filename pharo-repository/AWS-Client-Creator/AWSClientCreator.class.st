Class {
	#name : #AWSClientCreator,
	#superclass : #Object,
	#instVars : [
		'removePreviouslyDefinedClasses'
	],
	#category : #'AWS-Client-Creator'
}

{ #category : #creation }
AWSClientCreator >> createAccessor: name value: val service: service [
	| msgStream |
	msgStream := WriteStream with: String new.
	msgStream nextPutAll: name;
		crtab;
		nextPutAll: '^ ''',val, '''.'.
	msgStream crtab.
	service compile: msgStream contents
]

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
	newService := AWSService subclass: ('AWS' , serviceId) asSymbol
	       instanceVariableNames: ''
			 classVariableNames: (' ' join: (aDictionary at: 'metadata') keys)
			 package: 'AWS-', serviceId, '-core'.
	
	newService comment: (aDictionary at: 'documentation') escapeComment .
	
	"self initializeClassVariables: (aDictionary at: 'metadata') service: newService."
	
	self createAccessor: 'endpoint' value: ((aDictionary at: 'metadata') at: 'endpointPrefix') service: newService.
	
	(aDictionary at: 'operations') valuesDo: [ :i |
		self createOperation: i service: newService.	
	]
			
	
]

{ #category : #creation }
AWSClientCreator >> createOperation: messageData service: service [
	| msgStream msgName msgInputName |
	msgName := self toCamelCase: (messageData at: 'name').
	msgInputName := 'a', ((messageData at: 'input') at: 'shape').
	msgStream := WriteStream with: String new.
	msgStream nextPutAll: msgName .
	msgStream
		nextPutAll: ': ';
		nextPutAll: msgInputName;
		crtab;
	 	nextPut: $";
	 	nextPutAll: (messageData at: 'documentation') escapeComment ;
	 	nextPut: $";
	 	crtab;
		crtab;
		nextPutAll: '| request url |';
		crtab;
		crtab;
		nextPutAll: 'url := ''', ((messageData at: 'http') at: 'requestUri'), '''.';
		crtab;
	 	nextPutAll: 'request := self createRequest: ', msgInputName ,' url: url method: #', ((messageData at: 'http') at: 'method') ,' .';
	 	crtab;
		nextPutAll: '^ self client request: request andOption: nil.'.
		
	service compile: msgStream contents classified: 'operations'.
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
