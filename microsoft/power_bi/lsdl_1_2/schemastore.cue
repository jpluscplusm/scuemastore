package lsdl_1_2

import (
	"strings"
	"struct"
	"list"
)

_#Schema: {
	// LSDL Schema
	//
	// Linguistic Schema Definition Language schema
	@jsonschema(schema="http://json-schema.org/draft-04/schema#")

	// Version of LSDL
	Version: "1.2.0"

	// Target language for the linguistic schema
	Language: =~"^[A-Za-z][A-Za-z]+(-[A-Za-z0-9][A-Za-z0-9]+)*$"

	// Indicates which heuristics should be run to automatically
	// improve the linguistic schema.
	DynamicImprovement?: "Default" | "Full" | "HighConfidence" | "None" | *"Default"

	// Indicates the confidence score required for an interpretation
	// of an utterance to be returned.
	MinResultConfidence?: "Default" | "VeryHigh" | "High" | "Medium" | "Low" | *"Default"

	// Additional linguistic schemas referenced by objects within this
	// linguistic schema
	Namespaces?: #namespaces

	// The entities in the linguistic schema.
	Entities?: #entities

	// The relationships in the linguistic schema.
	Relationships?: #relationships

	// The global text substitutions in the linguistic schema.
	GlobalSubstitutions?: #globalSubstitutions

	#identifier: =~"^.+$"

	#modelItemReference: string

	#nonEmptyString: strings.MinRunes(1)

	#state: "Authored" | "Generated" | "Suggested" | "Deleted" | *"Authored"

	#weight: >=0 & <=1 | *1

	#templateSchema: string

	#dateTime: string

	#namespaces: {
		{[=~"^.+$" & !~"^()$"]: #lsdlReference}
	}

	#lsdlReference: {
		...
	}

	#entities: {
		{[=~"^.+$" & !~"^()$"]: #entity}
	}

	#entity: {
		// The conceptual model object which represents the entity
		Binding: #conceptualEntityBinding | #conceptualPropertyBinding | #hierarchyBinding | #hierarchyLevelBinding

		// The state of the entity
		State?: #state

		// Indicates the entity is hidden. Hidden entities are ignored for
		// all purposes other than being available nodes along paths
		// between other related entities.
		Hidden?: bool

		// The weight to apply to this entity
		Weight?: #weight

		// Identifies the shared template schema from which this entity is
		// derived
		TemplateSchema?: #templateSchema

		// Terms which can be used to refer to this entity
		Terms?: #terms

		// The overall semantic category of the entity
		SemanticType?: "Person" | "Animate" | "Inanimate" | "Location" | "Time" | "Duration"

		// Nouns which indicate the units represented in this numeric
		// property entity.
		Units?: #terms

		// Defines how instance values from the model are recognized
		Instances?: #instances
	}

	#conceptualEntityBinding: {
		// The name of the table.
		Table: #modelItemReference
	} | {
		// The name of the conceptual entity (e.g. table or pod)
		ConceptualEntity: #modelItemReference
	}

	#conceptualPropertyBinding: {
		// The name of the table containing the column or measure
		Table: #modelItemReference

		// The name of the property containing the variation set that
		// contains the column or measure
		VariationSource?: #modelItemReference

		// The name of the variation set that contains the column or
		// measure
		VariationSet?: #modelItemReference

		// The name of the column
		Column: #modelItemReference
	} | {
		// The name of the table containing the column or measure
		Table: #modelItemReference

		// The name of the property containing the variation set that
		// contains the column or measure
		VariationSource?: #modelItemReference

		// The name of the variation set that contains the column or
		// measure
		VariationSet?: #modelItemReference

		// The name of the measure
		Measure: #modelItemReference
	} | {
		// The name of the conceptual entity containing the property
		ConceptualEntity: #modelItemReference

		// The name of the property containing the variation set that
		// contains the property
		VariationSource?: #modelItemReference

		// The name of the variation set that contains the property
		VariationSet?: #modelItemReference

		// The name of the property
		ConceptualProperty: #modelItemReference
	}

	#hierarchyBinding: {
		// The name of the table containing the hierarchy
		Table: #modelItemReference

		// The name of the property containing the variation set that
		// contains the hierarchy
		VariationSource?: #modelItemReference

		// The name of the variation set that contains the hierarchy
		VariationSet?: #modelItemReference

		// The name of the hierarchy
		Hierarchy: #modelItemReference
	} | {
		// The name of the conceptual entity containing the hierarchy
		ConceptualEntity: #modelItemReference

		// The name of the property containing the variation set that
		// contains the hierarchy
		VariationSource?: #modelItemReference

		// The name of the variation set that contains the hierarchy
		VariationSet?: #modelItemReference

		// The name of the hierarchy
		Hierarchy: #modelItemReference
	}

	#hierarchyLevelBinding: {
		// The name of the table containing the hierarchy
		Table: #modelItemReference

		// The name of the property containing the variation set that
		// contains the hierarchy
		VariationSource?: #modelItemReference

		// The name of the variation set that contains the hierarchy
		VariationSet?: #modelItemReference

		// The name of the hierarchy
		Hierarchy: #modelItemReference

		// The name of the hierarchy level
		HierarchyLevel: #modelItemReference
	} | {
		// The name of the conceptual entity containing the hierarchy
		ConceptualEntity: #modelItemReference

		// The name of the property containing the variation set that
		// contains the hierarchy
		VariationSource?: #modelItemReference

		// The name of the variation set that contains the hierarchy
		VariationSet?: #modelItemReference

		// The name of the hierarchy
		Hierarchy: #modelItemReference

		// The name of the hierarchy level
		HierarchyLevel: #modelItemReference
	}

	#terms: [...#term] & [_, ...]

	#term: #nonEmptyString | #fullTerm

	#fullTerm: struct.MaxFields(1) & {
		{[=~"^.+$" & !~"^()$"]: #termProperties}
	}

	#termProperties: {
		// The part of speech of the term
		Type?: "Noun" | "Verb" | "Adjective" | "Preposition"

		// The state of the term
		State?: #state

		// The weight to apply to the term
		Weight?: #weight

		// Identifies the shared template schema from which the term is
		// derived
		TemplateSchema?: #templateSchema

		// Indicates the last date and time (in UTC) that this term was
		// modified.
		LastModified?: #dateTime
	}

	#instances: {
		// Indicates whether the values of this entity should be available
		// in the term index, enabling recognition, completion, and
		// suggestions.
		Index?: "Default" | "None" | *"Default"

		// Indicates whether values that appear to be plural should match
		// singular words in the utterance.
		PluralNormalization?: "Default" | "Normalized" | "None" | *"Default"

		// Defines a set of values which are synonyms of instances of this
		// entity.
		Synonyms?: #instanceSynonyms

		// Reference to property in the model which contains the weight to
		// apply to instances of this entity.
		Weights?: #instanceWeights
	}

	#instanceSynonyms: {
		// The conceptual model object which contains terms that can be
		// used to refer to values of the entity
		SynonymBinding: #conceptualPropertyBinding

		// The conceptual model object which contains the corresponding
		// values of the entity
		ValueBinding: #conceptualPropertyBinding

		// The state of the instance synonyms
		State?: #state
	}

	#instanceWeights: {
		// The conceptual model object which contains the instance weights
		// corresponding to instances of the entity
		Binding: #conceptualPropertyBinding
	}

	#relationships: {
		{[=~"^.+$" & !~"^()$"]: #relationship}
	}

	#relationship: {
		// The conceptual model object which embodies the relationship
		Binding?: #conceptualEntityBinding

		// The state of the relationship
		State?: #state

		// The weight to apply to this relationship
		Weight?: #weight

		// Identifies the shared template schema from which this
		// relationship is derived
		TemplateSchema?: #templateSchema

		// References to linguistic entities which participate in the
		// relationship
		Roles?: #roles

		// Defines how roles fill common semantic slots in the
		// relationship
		SemanticSlots?: #semanticSlots

		// A set of conditions which are required to be true for instances
		// of the relationship represented in the semantic model
		Conditions?: #conditions

		// A set of syntactic frames which define the types of language
		// used to describe the relationship
		Phrasings?: #phrasings
	}

	#roles: {
		{[=~"^.+$" & !~"^()$"]: #role}
	}

	#role: #identifier | #fullRole

	#fullRole: {
		// The linguistic entity which is the target of the role
		Target: #entityReference

		// Nouns which can be used to refer to the entity which is the
		// target of the role, when used in the context of the
		// relationship
		Nouns?: #terms

		// A role which indicates the quantity of this role's entity which
		// participates in the relationship
		Quantity?: #roleReference

		// A role which indicates the amount of this role's entity which
		// participates in the relationship
		Amount?: #roleReference
	}

	#entityReference: #identifier | #fullEntityReference

	#fullEntityReference: {
		// The name of the entity
		Entity: #identifier

		// The name of the namespace of the linguistic schema that
		// contains the entity
		Namespace?: #identifier
	}

	#semanticSlots: {
		// A role which indicates where the relationship takes place
		Where?: #roleReference

		// A role which indicates when the relationship takes place
		When?: #roleReference

		// A role which indicates how long the relationship occurred
		Duration?: #roleReference

		// A role which indicates the number of times the relationship
		// occurred
		Occurrences?: #roleReference
	}

	#conditions: list.MaxItems(1) & [...#condition] & [_, ...]

	#condition: {
		// A role in the relationship to compare to the value
		Target: #roleReference

		// The operator with which to compare the value and the role
		Operator: "Equals" | "NotEquals" | "GreaterThan" | "LessThan" | "GreaterThanOrEquals" | "LessThanOrEquals" | "Contains" | "NotContains" | "StartsWith" | "NotStartsWith"

		// The value to which the role is compared
		Value: #value
	}

	#value: ({
		// A text value to use in a condition
		Text: #textValues
	} | {
		// A number value to use in a condition
		Number: #numberValues
	} | {
		// A Boolean value to use in a condition
		Boolean: #booleanValues
	} | #textValues | #numberValues | #booleanValues | null) & _

	#textValues: #nullableTextValue | list.MaxItems(1) & [...#nullableTextValue] & [_, ...]

	#nullableTextValue: null | string

	#numberValues: #nullableNumberValue | list.MaxItems(1) & [...#nullableNumberValue] & [_, ...]

	#nullableNumberValue: null | number

	#booleanValues: #nullableBooleanValue | list.MaxItems(1) & [...#nullableBooleanValue] & [_, ...]

	#nullableBooleanValue: null | bool

	#phrasings: [...#phrasing] & [_, ...]

	#phrasing: #attributePhrasing | #namePhrasing | #adjectivePhrasing | #dynamicAdjectivePhrasing | #nounPhrasing | #dynamicNounPhrasing | #prepositionPhrasing | #verbPhrasing

	#phrasingProperties: {
		// The state of the phrasing
		State?: #state

		// The weight to apply to the phrasing
		Weight?: #weight

		// Identifies the shared template schema from which the phrasing
		// is derived
		TemplateSchema?: #templateSchema
		...
	}

	#attributePhrasing: {
		Attribute:       #attributePhrasingProperties
		State?:          _
		Weight?:         _
		TemplateSchema?: _
	} & #phrasingProperties

	#attributePhrasingProperties: {
		// The entity which is the subject of the phrasing
		Subject: #roleReference

		// The entity which is the object of the phrasing
		Object: #roleReference

		// Additional prepositional phrases which apply to the phrasing
		PrepositionalPhrases?: #prepPhrases
	}

	#namePhrasing: {
		Name:            #namePhrasingProperties
		State?:          _
		Weight?:         _
		TemplateSchema?: _
	} & #phrasingProperties

	#namePhrasingProperties: {
		// The entity which is the subject of the phrasing
		Subject: #roleReference

		// The entity which is the name of the Subject
		Name: #roleReference
	}

	#adjectivePhrasing: {
		Adjective:       #adjectivePhrasingProperties
		State?:          _
		Weight?:         _
		TemplateSchema?: _
	} & #phrasingProperties

	#adjectivePhrasingProperties: {
		// The entity which is described via an adjective
		Subject: #roleReference

		// Adjectives used to describe the Subject (with a high
		// measurement)
		Adjectives: #terms

		// Adjectives used to describe the Subject (with a low
		// measurement)
		Antonyms?: #terms

		// The entity which measures the extent to which the Adjectives
		// apply
		Measurement?: #roleReference

		// Additional prepositional phrases which apply to the phrasing
		PrepositionalPhrases?: #prepPhrases
	} | {
		// The entity which is described via an adjective
		Subject: #roleReference

		// Adjectives used to describe the Subject (with a low
		// measurement)
		Antonyms: #terms

		// The entity which measures the extent to which the Adjectives
		// apply
		Measurement?: #roleReference

		// Additional prepositional phrases which apply to the phrasing
		PrepositionalPhrases?: #prepPhrases
	}

	#dynamicAdjectivePhrasing: {
		DynamicAdjective: #dynamicAdjectivePhrasingProperties
		State?:           _
		Weight?:          _
		TemplateSchema?:  _
	} & #phrasingProperties

	#dynamicAdjectivePhrasingProperties: {
		// The entity which is described via an adjective
		Subject: #roleReference

		// The column entity (or table entity with a name phrasing) which
		// is used to describe the Subject
		Adjective: #roleReference

		// Additional prepositional phrases which apply to the phrasing
		PrepositionalPhrases?: #prepPhrases
	}

	#nounPhrasing: {
		Noun:            #nounPhrasingProperties
		State?:          _
		Weight?:         _
		TemplateSchema?: _
	} & #phrasingProperties

	#nounPhrasingProperties: {
		// The entity which is described via a noun
		Subject: #roleReference

		// Nouns used to describe the Subject
		Nouns: #terms

		// Additional prepositional phrases which apply to the phrasing
		PrepositionalPhrases?: #prepPhrases
	}

	#dynamicNounPhrasing: {
		DynamicNoun:     #dynamicNounPhrasingProperties
		State?:          _
		Weight?:         _
		TemplateSchema?: _
	} & #phrasingProperties

	#dynamicNounPhrasingProperties: {
		// The entity which is described via a noun
		Subject: #roleReference

		// The column entity (or table entity with a name phrasing) which
		// is the used to describe the Subject
		Noun: #roleReference

		// Additional prepositional phrases which apply to the phrasing
		PrepositionalPhrases?: #prepPhrases
	}

	#prepositionPhrasing: {
		Preposition:     #prepositionPhrasingProperties
		State?:          _
		Weight?:         _
		TemplateSchema?: _
	} & #phrasingProperties

	#prepositionPhrasingProperties: {
		// The entity which is the subject of the prepositional phrase
		Subject: #roleReference

		// Prepositions used in the prepositional phrase
		Prepositions: #terms

		// The entity which is the object of the prepositional phrase
		Object: #roleReference

		// Additional prepositional phrases which apply to the phrasing
		PrepositionalPhrases?: #prepPhrases
	}

	#verbPhrasing: {
		Verb:            #verbPhrasingProperties
		State?:          _
		Weight?:         _
		TemplateSchema?: _
	} & #phrasingProperties

	#verbPhrasingProperties: {
		// The entity which is the subject of the verb
		Subject?: #roleReference

		// Verbs used to describe the relationship
		Verbs: #terms

		// The entity which is the indirect object of the verb
		IndirectObject?: #roleReference

		// The entity which is the direct object of the verb
		Object?: #roleReference

		// Additional prepositional phrases which apply to the phrasing
		PrepositionalPhrases?: #prepPhrases
	}

	#prepPhrases: [...#prepPhrase] & [_, ...]

	#prepPhrase: {
		// Prepositions used in the prepositional phrase
		Prepositions: #terms

		// The entity which is the object of the prepositional phrase
		Object: #roleReference
	}

	#roleReference: #identifier | #fullRoleReference

	#fullRoleReference: Role: #identifier

	#globalSubstitutions: [...#globalSubstitution] & [_, ...]

	#globalSubstitution: struct.MaxFields(1) & {
		{[=~"^.+$" & !~"^()$"]: #globalSubstitutionProperties}
	}

	#globalSubstitutionProperties: string | #fullGlobalSubstitutionProperties

	#fullGlobalSubstitutionProperties: {
		// The sequence of words to substitute into the utterance.
		Substitute: string

		// The state of the global substitution
		State?: #state

		// Identifies the shared template schema from which this global
		// substitution is derived
		TemplateSchema?: #templateSchema
	}
}
