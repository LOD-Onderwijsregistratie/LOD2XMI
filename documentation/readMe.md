#  Documentation

Like the MIM model (see: https://github.com/Geonovum/MIM-Werkomgeving) a modeldriven approach is followed.

![](https://github.com/LOD-Onderwijsregistratie/RDF2XMI2UML/blob/master/documentation/figuur04.JPG "datamodelling")

It consists of the three classical kinds of models:

1. Conceptual model

A conceptual model is to make people understand the data in the business and talk about it. It's elements are concepts, their textual descriptions and relationships. 

2.  Logical model

A logical model is to descibe "the logic" of the data in store or when shared. It determines if the data is valid or not. It should be independent of implementation. A (rich) datatype is a reusable piece of datalogic. Usually at this level the graphical Uniform Modelling Language (UML) is used. This is the kind of model this github is concerned with.

3. Technical model

The technical model is used to generate a database or a schema to automatically validate the data. It will be implementation dependent, but different implementations can stay in sync because substantial parts, at least the fields, can be generated from the logical model.

_model in Linked Data_

To express a logical model in Linked Data  OWL and SHACL play an important part. OWL defines datatyping with classes and properties and possibly Description Logic although we haven't ventured there yet. SHACL is a  language that expresses the same constraints as UML can. It is crucial to explain that OWL-elements cannot have versions because the a modelchange would also mean replacing datatriples. When modelelements change the this will be expressend using SHACL-elements.


_canonical or specific?_

Modelelements are made re-usable by submitting them into a canonical datamodel (cdm) and using them as (rich) datatypes in specific datamodels (sdm).

![](https://github.com/LOD-Onderwijsregistratie/RDF2XMI2UML/blob/master/documentation/figuur05.JPG "canonical or specific")

ohfg






