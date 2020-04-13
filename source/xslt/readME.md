# XSLT transformation

These XSLT stylesheets  serve the transformation of rdf/xml-datamodels that conform to a common schema (XSD). They are first created  using XML-spy with a build-in XSLT-processor. Several other XSLT-processors exists, build-in, as API or CLI, open source and commercial. To start with the first and maybe the best: Saxon created by XSLT pioneer Michael Kay. 

* rdf2html-v01.xslt  

This stylesheet picks-out the major modelelements in the input-file en transforms these into a basis HTML-page. This is meant as an prototype. In the next stage the html-tags will be replaces by xmi-tags.

* rdf2xml-basic-v02.xslt 

This is the first real transformation to XMI/UML that can actually be imported. It produces straight UML classes, datatypes, relationships etc from https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/examples/RIO-snipper-easyrdf.xml using 
XML-spy 2020 v2 (as xslt-processor) and Enterprise Architect 12.0.1210 (uml-tool). After dragging the elements to a UML-diagram it will look like this:

![]( https://github.com/LOD-Onderwijsregistratie/LOD2XMI/blob/master/source/xslt/figuur03.JPG "figure 3. result basic")

*Notes:* 
1. RDF doesn"t have bidirectional relationships. You need two inversed properties. That is not within the present scope. So the multiplicity for the target is undetermined.
2. Classes have attributes with a domain defined by a rich datatype. 
3. Rich datatypes (including enumerations) are a specialisation of a core datatype. Those are selected by the Dutch government based GAB-project. The MIM-project provided a translation between this and the XSD types.
4. Classes and datatypes have a special tagged value rdfType with a (resolvable) uri that referes to the original datatype. Links to skos:concept's are found there.
                
* rdf2xml-mim-v02.xslt 

This transformation adds the stereotypes and tagged values defined by MIM 1.1. This ensures compatibility within the realm of Dutch government. 


