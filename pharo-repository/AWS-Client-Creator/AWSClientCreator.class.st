Class {
	#name : #AWSClientCreator,
	#superclass : #Object,
	#instVars : [
		'removePreviouslyDefinedClasses'
	],
	#category : #'AWS-Client-Creator'
}

{ #category : #creation }
AWSClientCreator >> createFromJson: aDictionary [
	"Create an AWS client from a template JSON object provided by AWS.
	
	 The input dictionary must contain 5 top-level keys: operations, version, shapes, 
	 metadata, documentation.
	"
	| newService |
	
	newService := Object subclass: ('AWS' , ((aDictionary at: 'metadata') at: 'serviceId'), 'Client') asSymbol
	       instanceVariableNames: ''
			 classVariableNames: (' ' join: (aDictionary at: 'metadata') keys)
			 package: 'AWS-Service'.
	
	newService comment: (aDictionary at: 'documentation') escapeComment .
	
	(aDictionary at: 'operations') valuesDo: [ :i |
		self createMessage: i For: newService.	
	]
			
	
]

{ #category : #creation }
AWSClientCreator >> createMessage: messageData For: service [
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

{ #category : #formatting }
AWSClientCreator >> toCamelCase: aName [
	"Convert a string to have the first character be lower case."
	
			
	^((aName at:1) lowercase asString), (aName allButFirst)
]
