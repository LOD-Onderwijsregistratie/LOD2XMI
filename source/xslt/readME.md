# XSLT transformation

These XSLT stylesheets  serve the transformation of rdf/xml-datamodels that conform to a common schema (XSD). They are first created  using XML-spy with a build-in XSLT-processor. Several other XSLT-processors exists, build-in, as API or CLI, open source and commercial. To start with te first and maybe the best: Saxon created by XSLT pioneer Michael Kay. 

* rdf2html-v01.xslt  
This picks-out the major modelelements in the input-file en transforms these into a basis HTML-page. This is meant as an intermediary development product. In the next stage the html-tags will be replaces by xmi-tags.

* rdf2xml-basic-v02.xslt
This is the first real transformation to XMI/UML that can actually be imported. It produces straight UML classes, datatypes, relationsshipts etc and is tested with: XML-spy 2020 v2 and (xslt-processor)  Enterprise Architect 12.0.1210 (uml-tool).
                
* rdf2xml-mim-v02.xslt
This transformation adds the stereotyoes and tagged values defined by MIM 1.1. This ensures compatibility within the realm of Dutch government. 


