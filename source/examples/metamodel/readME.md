## Model of a model of a model


Object Management Group (OMG) defines four layers for modeldrive engineering. Next figure is copied from the Metamodel Informationmodelling (MIM).

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur06.JPG "figure 6.  OMG Layers")

This directory contains  a small sample of a datamodel in turtle serialization (M1 in the 4-layer model). This
file can be imported in tools that do rdf. It works as as __shacl-graph__. This means that it can be used to validate a data-graph with 
instances from reality (M0 in the 4-layer model). A tiny data-graph (M0) is also added to experiment with, maybe using https://shacl.org/playground.

Expressed in UML the datamodel sample looks like this:

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur03.JPG "figure 3.  UML sample")

What follows is a description of the rdf constructions used to descibe a M1-model in general. This is the M2-layer in de 4 layer model. It is created with the requirement that its constructions follows MIM (also M2-layer). 

1  Coretypes (standard)

   Specification languages have as a rule some coretypes like string or integer. Often they are alike but not equal. In MIM the next list (called GAB) is adopted 

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur07.JPG "figure 7.  Coretypes")

   A linked data model is expressed in the shacl-languages that uses a subset of the xsd-types. This figure provides a mapping.

2  Rich datatypes (canonical)

  A rich datatype is a datatype at a national level that is made available for re-use without the need to define it again in an other environment.. 

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur08.JPG "figure 8.  Rich datatype")

  This represents a MIM-Datatype. It is derived from a coretype by restriction i.e. limiting the possible values and referring to a concept. 

3  Enumeration (canonical)

  An enumeration is also a datatype at a national level that is made available for re-use without the need to copy it. 

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur09.JPG "figure 9.  Enumeration" )

  This represents a MIM-enumeration. It is defined as a limited list of possible values. 


4  Class en class-relations (specific)

  A MIM-Class, MIM-Associations and MIM-Generalizations are constructed as follows:

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur10.JPG "figure 10.  Classes")

  A class has attributes which are classified by a canonical rich datatype or an enumeration. 
























