<!--
    NAME     rdf2html.xsl
    VERSION  0.1.0
    DATE     2020-04-09
    Copyright 2020-2025
    This file is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    It is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details: <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/terms/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:sh="http://www.w3.org/ns/shacl#" version="2.0">

	<!-- Index to find RDF-subjects with URI -->
	<xsl:key name="subject" match="*" use="@rdf:about"/>
	<!-- Index to find RDF-subjects with object-URI -->
	<xsl:key name="object" match="*" use="@rdf:resource"/>
	
	<!-- Root template -->
	<xsl:template match="/">
		<xsl:message>Start transformation: <xsl:value-of select="current-dateTime()"/>
		</xsl:message>
		<xsl:comment>Gegenereerd met rdf2html.xslt <xsl:value-of select="current-dateTime()"/>
		</xsl:comment>
		<html>
			<head>
				<title>wat moet hier?</title>
			</head>
			<body>
				<xsl:apply-templates select="//owl:Ontology"/>
				<!-- primitive datatypes -->
				<xsl:message>Primitive datatypes:</xsl:message>
				<xsl:apply-templates select="//owl:DatatypeProperty"/>
				<!-- enumerations -->
				<xsl:message>Enumerations:</xsl:message>
				<xsl:apply-templates select="//owl:ObjectProperty"/>
				<!-- classes/objecttypes -->
				<xsl:message>Classes/objecttypes:</xsl:message>
				<xsl:apply-templates select="//sh:NodeShape[not(exists(sh:in))]" mode="class"/>
			</body>
			<footer>
				<a href="https://lod.onderwijsregistratie.nl">lod.onderwijsregistratie.nl</a>
			</footer>
		</html>
		<xsl:message>End transformation</xsl:message>
	</xsl:template>

	<!-- Templates for modelelements-->
	<xsl:template match="owl:Ontology">
		<div align="center">
			<h1>
				<xsl:value-of select="dc:title"/>
			</h1>
		</div>
	</xsl:template>
	<!-- primitive datatypes -->
	<xsl:template match="owl:DatatypeProperty">
		<p>
			<xsl:message>	-  <xsl:value-of select="rdfs:label"/>
			</xsl:message>
			<u>datatype: <xsl:value-of select="rdfs:label"/>
			</u>
			<br/>
			<!-- fetch with object-key en make distinct sh:PropertyShape constraints with for-each-group -->
			<xsl:for-each-group select="key('object', @rdf:about)/.." group-by="sh:path/@rdf:resource">
			coretype: <xsl:value-of select="sh:datatype/@rdf:resource"/>
				<br/>
			length: <xsl:value-of select="sh:minLength"/>..<xsl:value-of select="sh:maxLength"/>
				<!-- todo: not exists -->
				<br/>
				<xsl:if test="exists(sh:pattern)">pattern: <xsl:value-of select="sh:pattern"/>
				</xsl:if>
			</xsl:for-each-group>
		</p>
	</xsl:template>

	<!-- enumerations and enumeration literals -->
	<xsl:template match="owl:ObjectProperty">
		<p>
			<!-- just select enumeration, not associations-->
			<xsl:if test="exists(rdfs:range)">
				<xsl:variable name="enum" select="key('subject', rdfs:range/@rdf:resource)/rdfs:label"/>
				<xsl:message>	-  <xsl:value-of select="$enum"/>
				</xsl:message>
				<u>enumeration: <xsl:value-of select="$enum"/>	
					</u>
				<br/>
				<!-- fetch enumeration literals at owl:Class -->
				<xsl:for-each select="key('subject', rdfs:range/@rdf:resource)//rdf:first">
					 enumeration literals: <xsl:value-of select="key('subject', @rdf:resource)/rdfs:label"/> = 
					 <xsl:value-of select="key('subject', @rdf:resource)/rdfs:comment"/>
					<br/>
				</xsl:for-each>		
			+<br/>
				<!-- fetch with object-key en make distinct sh:PropertyShape constraints with for-each-group -->
				<xsl:for-each-group select="key('object', @rdf:about)/.." group-by="sh:path/@rdf:resource">
			coretype: <xsl:value-of select="sh:datatype/@rdf:resource"/>
					<br/>
			length: <xsl:value-of select="sh:minLength"/>..<xsl:value-of select="sh:maxLength"/>
					<!-- todo: not exists -->
					<br/>
					<xsl:if test="exists(sh:pattern)">pattern: <xsl:value-of select="sh:pattern"/>
						<br/>
					</xsl:if>
				</xsl:for-each-group>
			</xsl:if>
		</p>
	</xsl:template>
	
	<!-- classes (excluding enumerations) and attributes   -->
	<xsl:template match="sh:NodeShape[not(exists(sh:in))]" mode="class">
		<p>
			<xsl:message>	-  <xsl:value-of select="sh:name"/>
			</xsl:message>
			<u>objecttype: <xsl:value-of select="sh:name"/>
			</u>
			<br/>
			<xsl:for-each select=".//sh:PropertyShape">
			attribute: 
			<xsl:choose>
					<!-- attributes with domain rich datatype -->
					<xsl:when test="not(exists(sh:class))">
						<xsl:value-of select="sh:name"/> -> 
					{<xsl:value-of select="key('subject', sh:path/@rdf:resource)/rdfs:label"/>} = 					
					<xsl:value-of select="key('subject', sh:path/@rdf:resource)/rdfs:comment"/>
					</xsl:when>
					<!-- attributes with domain enumeration -->
					<xsl:otherwise>
						<xsl:value-of select="sh:name"/> -> 
					{<xsl:value-of select="key('subject', sh:class/@rdf:resource)/rdfs:label"/>} = 					
					<xsl:value-of select="key('subject', sh:class/@rdf:resource)/rdfs:comment"/>
					</xsl:otherwise>
				</xsl:choose>
				<br/>
			</xsl:for-each>
		</p>
	</xsl:template>
</xsl:stylesheet>
