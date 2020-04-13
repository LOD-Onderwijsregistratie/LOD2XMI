# Transformation steps 

![](https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/figuur02.JPG "figure 2. transformation steps")


The main step is the  transformation of a rdf/xml-file containing a data-model into a XMI-file that ca be imported by most major if not any UML-tool. The purpose is to re-use the modelelements in the specification of derived data-products like webservices, api-services and other data-deliveries. We are not concerned here about how the model got there on the semantic web using RDF, OWL and SHACL. However to make sure that things go properly the input is validated against a XSD schema.  After the main transformation there is annother run.

Portability should be an important considaration. There is variability in the creation of rdf/xml, in tools doing the validation and transformation and in the platform for UML modelling. To be generally usable we need to avoid tools-specific functions and constructions and basically try a lot of them.

