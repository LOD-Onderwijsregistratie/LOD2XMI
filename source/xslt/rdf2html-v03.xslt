<!--    NAME     rdf2html-v02.xslt    VERSION  0.3    DATE     2020-04-20    Copyright 2020-2025	Author    Gerald Groot Roessink	Company   Dienst Uitvoering Onderwijs (DUO), The Netherlands.    This file is free software: you can redistribute it and/or modify    it under the terms of the GNU General Public License as published by    the Free Software Foundation, either version 3 of the License, or    (at your option) any later version.    It is distributed in the hope that it will be useful,    but WITHOUT ANY WARRANTY; without even the implied warranty of    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the    GNU General Public License for more details: <http://www.gnu.org/licenses/>.--><!--    DESCRIPTION    Transformation of RDF document with logical datamodel into html with key elements--><xsl:stylesheet xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/terms/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:sh="http://www.w3.org/ns/shacl#" version="2.0">	<!-- Index to find RDF-subjects with URI -->	<xsl:key name="subject" match="*" use="@rdf:about"/>	<!-- Index to find RDF-subjects with object-URI -->	<xsl:key name="object" match="*" use="@rdf:resource"/>		<!-- Root template -->	<xsl:template match="/">		<xsl:message>Start transformation: <xsl:value-of select="current-dateTime()"/> </xsl:message>		<xsl:comment>Gegenereerd met rdf2html.xslt <xsl:value-of select="current-dateTime()"/> </xsl:comment>		<html>			<body>			<!-- header info variant 1 & 2-->				<xsl:apply-templates select="//owl:Ontology" mode="ontology" />				<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#Ontology']" mode="ontology"/>			<!-- primitive datatypes variant 1 & 2-->				<xsl:message>Primitive datatypes:</xsl:message>				<xsl:apply-templates select="//owl:DatatypeProperty" mode="datatype"/>				<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#DatatypeProperty']" mode="datatype"/>			<!-- enumerations variant 1 & 2-->				<xsl:message>Enumerations:</xsl:message>				<xsl:apply-templates select="//owl:ObjectProperty" mode="enumeration"/>				<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#ObjectProperty']" mode="enumeration"/>			<!-- classes/objecttypes variant 1 & 2 -->				<xsl:message>Classes/objecttypes:</xsl:message>				<xsl:apply-templates select="//sh:NodeShape[exists(sh:property)]" mode="class"/>				<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/ns/shacl#NodeShape']" mode="class"/>			</body>			<footer>				<a href="https://lod.onderwijsregistratie.nl">lod.onderwijsregistratie.nl</a>			</footer>		</html>		<xsl:message>End transformation</xsl:message>	</xsl:template>	<!-- Templates for modelelements-->		<!-- header info variant 1 -->		<xsl:template match="owl:Ontology" mode="ontology">		<div align="center">			<h1>				<xsl:value-of select="dc:title"/>			</h1>		</div>	</xsl:template>	<!-- header info variant 1 -->		<xsl:template match="rdf:Description" mode="ontology">		<div align="center">			<h1>				<xsl:value-of select="dc:title"/>			</h1>		</div>	</xsl:template>	<!-- primitive datatypes variant 1 -->	<xsl:template match="owl:DatatypeProperty" mode="datatype">		<xsl:call-template name="datatype"/>	</xsl:template>	<!-- primitive datatypes variant 2-->	<xsl:template match="rdf:Description" mode="datatype">		<xsl:call-template name="datatype"/>		</xsl:template>	<!-- primitive datatypes  -->	<xsl:template name="datatype">		<p>			<xsl:message>	-  <xsl:value-of select="rdfs:label"/></xsl:message>			<u>datatype: <xsl:value-of select="rdfs:label"/></u> <br/>			<!-- fetch with object-key en make distinct sh:PropertyShape constraints with for-each-group -->			<xsl:for-each-group select="key('object', @rdf:about)/.." group-by="sh:path/@rdf:resource">			coretype: <xsl:value-of select="sh:datatype/@rdf:resource"/> <br/>			length: <xsl:value-of select="sh:minLength"/>..<xsl:value-of select="sh:maxLength"/>				<!-- todo: not exists -->				<br/>				<xsl:for-each select="sh:pattern">					pattern: <xsl:value-of select="."/><br/>				</xsl:for-each>					</xsl:for-each-group>		</p>	</xsl:template>	<!-- enumerations and enumeration literals variant 1-->	<xsl:template match="owl:ObjectProperty" mode="enumeration">		<!-- just select enumeration, not associations-->		<xsl:if test="exists(rdfs:range)">			<xsl:call-template name="enumeration"/>			</xsl:if>	</xsl:template>	<!-- enumerations and enumeration literals variant 2-->	<xsl:template match="rdf:Description" mode="enumeration">		<!-- just select enumeration, not associations-->		<xsl:if test="exists(rdfs:range)">			<xsl:call-template name="enumeration"/>			</xsl:if>	</xsl:template>	<!-- enumerations and enumeration literals -->	<xsl:template name="enumeration">		<!-- focus = ObjectProperty -->		<p>					<!-- shift focus to enumeration (just one)-->			<xsl:for-each select="key('subject', rdfs:range/@rdf:resource)">				<xsl:message>	-  <xsl:value-of select="rdfs:label"/> </xsl:message>				<u>enumeration: <xsl:value-of select="rdfs:label"/>	</u> <br/>								<!-- fetch enumeration literals with object key-->				<xsl:for-each select="key('object', @rdf:about)/..[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#NamedIndividual']">					enumeration literals: <xsl:value-of select="rdfs:label"/> = 					<xsl:value-of select="rdfs:comment"/>					<br/>				</xsl:for-each>							</xsl:for-each>				+<br/>				<!-- fetch  sh:PropertyShape with object-key en make distinct with for-each-group -->			<xsl:for-each-group select="key('object', @rdf:about)/.." group-by="sh:path">			<!-- focus = ProperyShape -->			coretype: <xsl:value-of select="sh:datatype/@rdf:resource"/>					<br/>			length: <xsl:value-of select="sh:minLength"/>..<xsl:value-of select="sh:maxLength"/>					<!-- todo: not exists -->					<br/>				<xsl:for-each select="sh:pattern">					pattern: <xsl:value-of select="."/><br/>				</xsl:for-each>					</xsl:for-each-group>		</p>	</xsl:template>	<!-- classes variant 1 -->	<xsl:template match="sh:NodeShape" mode="class">		<xsl:if test="exists(sh:property)">			<xsl:call-template name="class"/>			</xsl:if>		<xsl:call-template name="class"/>	</xsl:template>	<!-- classes variant 2-->	<xsl:template match="rdf:Description" mode="class">		<xsl:if test="exists(sh:property)">			<xsl:call-template name="class"/>			</xsl:if>		</xsl:template>		<!-- classes -->	<xsl:template name ="class">		<!-- focus = nodeshape -->		<p>			<xsl:message>	- <xsl:value-of select="sh:name"/>			</xsl:message>			<u>objecttype: <xsl:value-of select="sh:name"/>			</u>			<br/>						<!-- fetch attributes (not associations) variant 1 -->			<xsl:for-each select=".//sh:PropertyShape[exists(sh:datatype)]">				<xsl:call-template name="attributes"/>			</xsl:for-each>					<!-- fetch attributes (not associations) variant 2 -->			<xsl:for-each select="key('subject', sh:property/@rdf:resource)[exists(sh:datatype)]">				<xsl:call-template name="attributes"/>			</xsl:for-each>				</p>	</xsl:template>			<!-- attributes -->	<xsl:template name ="attributes">			<!-- focus = propertyshape -->			attribute: 			<!-- shift focus to datatype/objectproperty -->					<xsl:for-each select="key('subject', sh:path/@rdf:resource)">				<xsl:choose>					<!-- attributes with domain rich datatype -->					<xsl:when test="not(exists(rdfs:range))">						{<xsl:value-of select="rdfs:label"/>} = 											<xsl:value-of select="rdfs:comment"/>					</xsl:when>					<!-- attributes with domain enumeration -->					<xsl:otherwise>						<xsl:value-of select="rdfs:label"/> -> 						{<xsl:value-of select="key('subject', rdfs:range/@rdf:resource)/rdfs:label"/>} = 											<xsl:value-of select="key('subject', rdfs:range/@rdf:resource)/rdfs:comment"/>					</xsl:otherwise>				</xsl:choose>				<br/>			</xsl:for-each>	</xsl:template>	</xsl:stylesheet>