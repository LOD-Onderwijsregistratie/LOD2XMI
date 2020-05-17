# Data-examples

This directory contains  a small imaginary model example (M1 in terms of the 4 -layers by OMG). It is spiked with rich datatypes including a bit of versioning.

The original is a Turtle-file (see subdirectory).  This is transformed into rdf/xml because that is what XSLT acts upon. However, 
there seem to be major differences to express linked datacontent with rdf/xml:

      > format 1
      - <owl:Class rdf:about="http://lod.onderwijsregistratie.nl/cat/rio/def/Opleiding">
      -	<rdfs:label xml:lang="nl">Opleiding</rdfs:label>
      -	<rdfs:comment xml:lang="nl">Is het geheel van bekwaamheden voor</rdfs:comment>
      - </owl:Class>
      >
      or..

      > format 2
      - <rdf:Description rdf:about="http://lod.onderwijsregistratie.nl/cat/rio/def/Opleiding">
      -    <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Class"/>
      -    <rdfs:label xml:lang="nl">Opleiding</rdfs:label>
      -    <rdfs:comment xml:lang="nl">Is het geheel van bekwaamheden voor</rdfs:comment>
      -  </rdf:Description>
      >

These formats are both valid and express the same content. This difference is important for a XSLT transformation.  We cannot simply choose one, so we have to check different platforms:

* RIO-versioned-easyrdf.rdf

  The original Turtle is transformed into  rdf/xml  with an open conversion tool: http://www.easyrdf.org/converter. 

* RIO-versioned-virtuoso.rdf

  In this case the Turtle was loaded into the Open Link triple store Virtuoso (open source 07.20.3229) and exported again through the sparql endpoint with a CONSTRUCT-query with the result serialized as rdf/xml.

* RIO-versioned-marklogic.rdf

  In this case the Turtle was loaded into a MarkLogic Server 10.0-2.1 (free developer license) and exported through the qconsole with a CONSTRUCT-query and  serialized in rdf/xml form.

* RIO-versioned-rdf4j.rdf  (to do)

  In this case the Turtle was loaded into an implementation of  open source Eclips RDF4J (formerly OpenRDF Sesame) and exported through the sparql endpoint with a CONSTRUCT-query in rdf/xml form.

These files, although technically different, should lead to the same transformation result.


__notes:__
1.  The propertyshape for an enumeration has nodeKind IRI en still has a datatype en other constraints. This is because the enumerationlijst can not be used in every context. In those cases datatype and constraints are plan B.
2.   There must be clear way tot determine whether whether an element is canonical or specific. For now the presence of an 
rdfs:isDefinedBy is used to indicate that it is specific.






