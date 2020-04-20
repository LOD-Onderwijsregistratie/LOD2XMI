#  Documentation

A modeldriven approach is followed.

![](https://github.com/LOD-Onderwijsregistratie/RDF2XMI2UML/blob/master/documentation/figuur04.JPG "datamodelling")

Classically three kinds of models are considered:

1. Conceptual model

A conceptual model is to make people understand the data in the business and talk about it. It's elements are concepts, their textual descriptions and relationships. 

2.  Logical model

A logical model is to descibe "the logic" of the data in store or when shared. It determines if the data is valid or not. It should be independent of implementation. A (rich) datatype is a reusable piece of datalogic. Usually at this level the Uniform Modelling Language (UML) is used.

3. Technical model

The technical model is used to generate a database or a schema to automatically validate the data. It will be implementation dependent, but different implementations can stay in sync because substantial parts, at least the fields, can be generated from the logical model. 

This modeldriven approach is also adopted in Metamodel Informatiemodellering (proposed for the Dutch government). See the repository: https://github.com/Geonovum/MIM-Werkomgeving
