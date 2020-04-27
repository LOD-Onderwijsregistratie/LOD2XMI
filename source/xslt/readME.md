# XSLT transformation

These XSLT stylesheets  serve the transformation of datamodels published as rdf/xml. They are created  using XML-spy with a build-in XSLT-processor. Several other XSLT-processors exists, build-in, as API or CLI, open source and commercial. To mention the first and maybe the best: Saxon created by XSLT pioneer Michael Kay. 

These stylesheets are tested with the data-examples in https://github.com/LOD-Onderwijsregistratie/RDF2XMI2UML/tree/master/source/examples

* rdf2html-v04.xslt  

This stylesheet picks-out the major modelelements in the input-file en transforms these into a basis HTML-page. This is meant as a prototype for the following.

* rdf2xml-basic-v05.xslt

This is a transformation to XMI that can actually be imported as UML. It produces straight UML classes, datatypes, relationships etc.  using XML-spy 2020 v2 as xslt-processor that can be imported in Enterprise Architect 12.0.1210.

*Notes:* 
1. RDF doesn't have bidirectional relationships. One would need two inversed properties. That is not within the present scope. So the multiplicity for the target is undetermined.
2. Rich datatypes (including enumerations) are a specialisation of a core datatype. This XSLT casts the rdf/xml to the selection by the Dutch government based GAB-project.
3. Elements have a special tagged value called 'rdfType' with a (resolvable) uri that referes to the original datatype
                
* rdf2xml-mim-v01.xslt (next)

This transformation adds the stereotypes and tagged values defined by MIM 1.1. This ensures compatibility within the realm of Dutch government. 


