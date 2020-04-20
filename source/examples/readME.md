# Data-examples

This directory contains  a small data example, not neccesarily real, from the RIO world (Register Instellingen en Opleiding = Registry for Schools and Education in the Netherlands). The original is Turtle:

* RIO-snipper

This is transformed into rdf/xml. There seem to be major differences tot express linked datacontent with rdf/xml. 

> ### format 1
- <owl:Class rdf:about="http://lod.onderwijsregistratie.nl/cat/rio/def/Opleiding">
-	<rdfs:label xml:lang="nl">Opleiding</rdfs:label>
-	<rdfs:comment xml:lang="nl">Is het geheel van bekwaamheden voor</rdfs:comment>
- </owl:Class>
>
or..

> ###  format 2
- <rdf:Description rdf:about="http://lod.onderwijsregistratie.nl/cat/rio/def/Opleiding">
-    <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Class"/>
-    <rdfs:label xml:lang="nl">Opleiding</rdfs:label>
-    <rdfs:comment xml:lang="nl">Is het geheel van bekwaamheden voor</rdfs:comment>
-  </rdf:Description>
>

These formats are both valid and express the same content. This difference is important for a XSLT transformation.  Not sure which one pops up when, so we have to check different platforms:

* RIO-snipper-easyrdf

This is originally serialized als Turtle and transformed into  rdf/xml  with an open convertor: 
http://www.easyrdf.org/converter. 

* RIO-snipper-virtuoso

In this case the Turtle was loaded into the Open Link triple store Virtuoso (open source 07.20.3229) and exported again through the sparql endpoint with a basic CONSTRUCT-query in rdf/xml form.

* RIO-snipper-marklogic

In this case the Turtle was loaded into a MarkLogic Server 10.0-2.1 (free developer license) and exported through the qconsole with a CONSTRUCT-query and  serizalized in rdf/xml form.








