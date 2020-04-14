# Data-examples

Unfortunately there seem to be two different ways to express the seem linked datacontent  with rdf/xml. A major difference is this:

> ### example 1
<owl:Class rdf:about="http://lod.onderwijsregistratie.nl/cat/rio/def/Opleiding">
	<rdfs:label xml:lang="nl">Opleiding</rdfs:label>
	<rdfs:comment xml:lang="nl">Is het geheel van bekwaamheden voor</rdfs:comment>
 </owl:Class>
>
or..

> ### example 2
<rdf:Description rdf:about="http://lod.onderwijsregistratie.nl/cat/rio/def/Opleiding">
    <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Class" />
    <rdfs:label xml:lang="nl">Opleiding</rdfs:label>
    <rdfs:comment xml:lang="nl">Is het geheel van bekwaamheden voor</rdfs:comment>
  </rdf:Description>
>
They are both valid and express the same content. Not sure which one pops up when, so we have to deal with both. Next some data-exampels encountered:

* RIO-snipper-easyrdf

This is a small data example, not neccesarily real, from the RIO world (Register Instellingen en Opleiding = Registry for Schools and Education in the Netherlands) originally serialized als Turtle and transformed into  rdf/xml  with an open convertor: 
http://www.easyrdf.org/converter. Some worries with this rdf/xml file:

   1. xs:choices must be distinguisable, by alternating element order in the original file XSD not as severe as could be
   2. enumerations in rdf-collections are constructed with rdf:Description, it's not the only alternative
   3. arbitrary choises regarding  a sub-element or attribute rdf:resource (rdfs:subClassOf and sh:path)

* RIO-snipper-virtuoso (next)

The same dataset as above, but this time retrieved from the sparql endpoint from Virtuoso and directly serialized as rdf/XML.










