## Transforming Linked Data Models (RDF/OWL/SHACL) to XMI to UML


![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/figuur01.JPG "virtual datacatalogue")

In the world of linked open data (LOD) instance data is closely related to the OWL (web ontology language) in the catalogue like this:

* Treehouse is a kind of School which is an owl:Class
* Treehouse has zipcode "8043AV" whereas zipcode is an owl:DatatypeProperty
* Treehouse has level "secundary" whereas level is an owl:ObjectProperty pointing to an owl:Class with a enumerationlist.

The OWL-elements point to skos:Concepts containing the explanation of there use to humans.  The Simple Knowlegde Organization System (SKOS) is "comply-or-explain"  for this kind of publication from the Dutch government.  These terms and there relationsips even higer level terms are expressed als skos:Concepts.

Also, in de figure above SHACL can be found. In de linked data world machines use this for validation of instance data like a XML-file can be validated with a XML Schema Diagram (XSD). For example, with SHACL it can be specified that a school published as Linked Open Data is only valid when a zipcode is present and that it has a certain format.

This GITHUB repository is dedicated to the consumption of modelinformation on the world wide web or semantic web. Models are mostly created using the  grafical modelling language UML in some modelling tool and more and more often published as linked open data. The goal is to reuse model information in another modelling tool. That must be possible when the OWL/SHACL publication is transformed into the XML Metadata Interchange (XMI). By consequently following this route the semantic web becomes what Tim Berners-Lee meant: a global dataspace.

One more thing:  the Dutch government developed Metamodel Informatie Modellering (MIM, currently 1.1)  a standard for expressing datamodels. This includes both an Dutch UML-profile and a RDF-profile and transformation between the two both ways. MIM will be the   main guideline. More than that, MIM does not consider intra-organizational and intra-tool semantic cooperation. It just presupposes one tool to do it all. This repository will fill the gap when it isn't so.
