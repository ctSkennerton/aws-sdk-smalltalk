Extension { #name : #String }

{ #category : #'*AWS-Client-Creator' }
String >> escapeComment [
	^ self copyReplaceAll: '"' with: '""'
]
