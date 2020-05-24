#  Documentation


__Datamodelling__

Like the MIM metamodel (see: https://github.com/Geonovum/MIM-Werkomgeving) a modeldriven approach is followed.

![](https://github.com/LOD-Onderwijsregistratie/RDF2XMI2UML/blob/master/documentation/figuur04.JPG "datamodelling")

It consists of the three classical kinds of models:

1. Conceptual model

   A conceptual model is to make people understand the data in the business and talk about it. It's elements are concepts, their textual descriptions and relationships. 

2.  Logical model

    A logical model is to descibe "the logic" of the data in store or when shared. It determines if the data is valid or not. It should be independent of implementation. A (rich) datatype is a reusable piece of datalogic. Usually at this level the graphical Uniform Modelling Language (UML) is used. This is the kind of model this github is concerned with.

3. Technical model

   The technical model is used to generate a database or a schema to automatically validate the data. It will be implementation dependent, but different implementations can stay in sync because substantial parts, at least the fields, can be generated from the logical model.

__Datamodel in Linked Data__

The MIM-metamodel also describes how to express the modelelements in Linkd Data and even provides queries to produce it with the Linked Data languages  __OWL and SHACL__ (prefix owl: and sh: respectively). A strong feature of OWL is that is defines basic datatyping with classes and properties and possibly Description Logic, although we haven't ventured there yet. It is great for discovering new things. SHACL is a  language that expresses the modelelements we know from UML with so called shapes. Together, OWL and SHACL can provide a full description of the logical model. But no work is done yet to make it a round trip, creating the same UML- model out of a Linked Data model. 

__Canonical and specific datamodels__

Modelelements in a canonical datamodel (cdm) called rich datatypes can be re-used in specific datamodels (sdm):

![](https://github.com/LOD-Onderwijsregistratie/RDF2XMI2UML/blob/master/documentation/figuur05.JPG "canonical or specific")

Nodeshapes define the properties that a class can have and the propertyshapes defines more sofisticated constraints like core datatypes, minimum and maximum length, regular expresssions, enumerationlists and cardinality. This is similar to the XML Schema Definition (XSD) language for datatraffic.

The propertyshapes in a specific datamodel are derived from (a specialisation of) a canonical propertyshape.  In this picture denoted by an arrow with a hollow point. In this metamodel only the cardinality, the minimum and/or maximum number of occurences, is locally defined.

__Metamodel __

Object Management Group (OMG) defines four layers for modeldriven engineering. Next figure is copied from the Metamodel Informationmodelling (MIM).

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur06.JPG "figure 6.  OMG Layers")

This directory contains  a small sample of a datamodel in turtle serialization (M1 in the 4-layer model). This
file can be imported in tools that do rdf. It works as as __shacl-graph__. This means that it can be used to validate a data-graph with 
instances from reality (M0 in the 4-layer model). A tiny data-graph (M0) is also added to experiment with, maybe using https://shacl.org/playground.  To visualize the M1-model in UML, it looks like this:

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur03.JPG "figure 3.  UML sample")

What follows is a specification of the rdf patterns used to describe any M1-model in general. This is the M2-layer in de 4 layer model. Again, UML is used to visualize it.


1  Coretypes (standard)

   Specification languages have as a rule coretypes like string or integer. Often they are alike but not equal. In MIM the next list (called GAB) is adopted 

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur07.JPG "figure 7.  Coretypes")

   A linked data model is expressed in the shacl-languages that uses a subset of the xsd-types. This figure provides a mapping.

2  Rich datatypes (canonical)

  A rich datatype is a datatype at a national level that is made available for re-use without the need to define it again in an other environment.

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur08.JPG "figure 8.  Rich datatype")

  This represents a MIM-Datatype. It is derived from a coretype by restriction i.e. limiting the possible values and referring to a concept. 

3  Enumeration (canonical)

  An enumeration is also a datatype at a national level that is made available for re-use without the need to copy it. 

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur09.JPG "figure 9.  Enumeration" )

  This represents a MIM-enumeration. It is defined as a limited list of possible values. 


4  Class en class-relations (specific)

  A MIM-Class, MIM-Associations and MIM-Generalizations are constructed as follows:

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur10.JPG "figure 10.  Classes")

  A class has attributes that are classified by a canonical rich datatype or an enumeration. 








