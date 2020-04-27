#  Documentation


__Datamodelling__

Like the MIM model (see: https://github.com/Geonovum/MIM-Werkomgeving) a modeldriven approach is followed.

![](https://github.com/LOD-Onderwijsregistratie/RDF2XMI2UML/blob/master/documentation/figuur04.JPG "datamodelling")

It consists of the three classical kinds of models:

1. Conceptual model

   A conceptual model is to make people understand the data in the business and talk about it. It's elements are concepts, their textual descriptions and relationships. 

2.  Logical model

    A logical model is to descibe "the logic" of the data in store or when shared. It determines if the data is valid or not. It should be independent of implementation. A (rich) datatype is a reusable piece of datalogic. Usually at this level the graphical Uniform Modelling Language (UML) is used. This is the kind of model this github is concerned with.

3. Technical model

   The technical model is used to generate a database or a schema to automatically validate the data. It will be implementation dependent, but different implementations can stay in sync because substantial parts, at least the fields, can be generated from the logical model.

__Datamodel in Linked Data__

To express a logical model the Linked Data languages  __OWL and SHACL__ (prefix owl: and sh: respectively) play an important part. OWL defines basic datatyping with classes and properties and possibly Description Logic, although we haven't ventured there yet. SHACL is a  language that expresses the same constraints as UML with so called shapes. It is crucial to explain that OWL-elements cannot have different versions. That would be an antipattern because then a modelchange can only be realized by migrating the linked data. So, when modelelements change this will be expressed in a different version of a SHACL-shape. Together, OWL and SHACL provide a full description of the logical model.

__Canonical and specific datamodels__

Modelelements are made re-usable by submitting them into a canonical datamodel (cdm) and using them as (rich) datatypes in specific datamodels (sdm).

![](https://github.com/LOD-Onderwijsregistratie/RDF2XMI2UML/blob/master/documentation/figuur05.JPG "canonical or specific")

Constraints or integrityrules defined in the shapes. Nodeshapes define the properties that a class can have and the propertyshapes defines more sofisticated constraints like core datatypes, minimum and maximum length, regular expresssions, enumerationlists and cardinality. This is similar to the XML Schema Definition (XSD) language for datatraffic.

The propertyshaps in a specific datamodel are derived from (a specialisation of) a canonical propertyshape.  In this picture denoted by an atrow with a hollow point. This is a way to express a rich datatype that can be re-used in many contexts. Only the cardinality, the minimum and/or maximum number of occurences, is locally defined.





