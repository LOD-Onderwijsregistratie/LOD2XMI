# XSD for validating the input

This is a place to share XML Schema Diagrams (XSD) to validate the RDF/XML-input for XSLT transformation. The reason for doing this is that several RDF/XML serializations of a  datamodel can be obtained in multiple ways. There is as we start  no way to know if the output in every case will be similar.  Providing  an XSD will help solving issues when changing tools.

This schema (actually five for every target namespace one) in raw form can directly be used from github by adding

https://raw.githubusercontent.com/LOD-Onderwijsregistratie/LOD2XMI/master/source/input-xsd/XSLT%20Inputvalidatie%20v01.xsd

to the  xsi:schemaLocation attribute of your datafile.

It is created using XML-spy and it has been tested with:

* conversion from original turtle file with easyrdf.org
* constructed on sparql endpoint of Virtuoso
* 

