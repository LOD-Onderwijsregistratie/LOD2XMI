# Data-examples

* RIO-snipper-easyrdf

This is a small data example, not neccesarily real, from the RIO world (Register Instellingen en Opleiding = Registry for Schools and Education in the Netherlands) originally serialized als Turtle and transformed into  rdf/xml  with an open convertor: 
http://www.easyrdf.org/converter. Some worries with this rdf/xml file:

   1. xs:choices must be distinguisable, by alternating element order in the original file XSD not as severe as could be
   2. enumerations in rdf-collections are constructed with rdf:Description, it's not the only alternative
   3. arbitrary choises regarding  a sub-element or attribute rdf:resource (rdfs:subClassOf and sh:path)

* RIO-snipper-virtuoso (next)

The same dataset as above, but this time retrieved from the sparql endpoint from Virtuoso and directly serialized as rdf/XML.










