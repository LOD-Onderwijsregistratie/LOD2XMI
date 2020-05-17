## Model of model of model


Object Management Group (OMG) defines four layers relevant voor modeldrive engineering. Next figure is copied from the Metamodel Informationmodelling (MIM).

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur06.JPG "figure 6.  OMG Layers")

This directory contains  a small example of a datamodel in turtle serialization (M1 in the 4-layer model). This
file can be imported in tools that do rdf. It works as as shacl-graph. This means that it can be used to validate a data-graph with 
instances from reality (M0 in the 4-layer model). A small M0-example is also added to experiment with, maybe using https://shacl.org/playground.

What follows is a description of the rdf constructions used to descibe a M1-model. This is the M2-layer in de 4 layer model. It is created with the requirement that its constructions also can be expressed in the metamodel for MIM (M2-layer). 

1.  Coretypes (national)

  Specification languages as a rule have have some list of coretypes. They are alike but not equal. In MIM then next list is adopted:

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur07.JPG "figure 7.  Coretypes")

  A linked data model is expressed in the shacl-languages that uses a subset of the xsd-types. 

2.  Rich datatypes (canonical)

  A rich datatype is a datatype at a national level that is made available for re-use without the need to copy it or define it again. 

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur08.JPG "figure 8.  Rich datatype")

  This represents a MIM-Datatype defined for a concept. It is derived from a coretype by restriction i.e. limiting the possible values. 

3.  Enumeration (canonical)

  An enumeration is also a datatype at a national level that is made available for re-use without the need to copy it or define it again. 

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur09.JPG "figure 9.  Enumeration" )

  This represents a MIM-enumeration. It is defined as a limited list of possible values. 


4.  Class en class-relations (specific)

  A MIM-Class, MIM-Associations and MIM-Generalizations are constructed as follows:

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/metamodel/figuur10.JPG "figure 10.  Classes")

  A class has attributes which are classified by a canonical rich datatype or an enumeration.
























