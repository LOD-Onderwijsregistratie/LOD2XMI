# Data-examples

Unfortunately there seem to be  different ways to express the linked datacontent with rdf/xml. A major difference is this:

> ### example 1
- <owl:Class rdf:about="http://lod.onderwijsregistratie.nl/cat/rio/def/Opleiding">
-	<rdfs:label xml:lang="nl">Opleiding</rdfs:label>
-	<rdfs:comment xml:lang="nl">Is het geheel van bekwaamheden voor</rdfs:comment>
- </owl:Class>
>
or..

> ### example 2
- <rdf:Description rdf:about="http://lod.onderwijsregistratie.nl/cat/rio/def/Opleiding">
-    <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Class"/>
-    <rdfs:label xml:lang="nl">Opleiding</rdfs:label>
-    <rdfs:comment xml:lang="nl">Is het geheel van bekwaamheden voor</rdfs:comment>
-  </rdf:Description>
>
They are both valid and express the same content. This difference is important for a XSLT transformation.  Not sure which one pops up when, so we have to deal with both. Next, some data-examples encountered:

* RIO-snipper-easyrdf (example 1)

This is a small data example, not neccesarily real, from the RIO world (Register Instellingen en Opleiding = Registry for Schools and Education in the Netherlands) originally serialized als Turtle and transformed into  rdf/xml  with an open convertor: 
http://www.easyrdf.org/converter. 

* RIO-snipper-virtuoso (example 2)

This is the same example as the first, but this time constructed with the sparql endpoint from Virtuoso and there serialized as rdf/xml. 










