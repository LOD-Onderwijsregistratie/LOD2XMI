<!--
    NAME     rdf2xmi_basic-v05.xslt
    VERSION  0.5
    DATE     2020-04-24
    Copyright 2020-2025
	Author    Gerald Groot Roessink
	Company   Dienst Uitvoering Onderwijs (DUO), The Netherlands.
    This file is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    It is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details: <http://www.gnu.org/licenses/>.
-->
<!--
    DESCRIPTION
    Transformation of RDF document with logical datamodel into basic XMI
-->

<xsl:stylesheet xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/terms/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:sh="http://www.w3.org/ns/shacl#" xmlns:schema="http://schema.org/" xmlns:UML="http://schema.omg.org/spec/UML/2.5.1"  xmlns:xmi="http://schema.omg.org/spec/XMI/2.1" xmlns:type="http://whatever" version="2.1" exclude-result-prefixes="type">

	<xsl:output method="xml" indent="yes"/>
	<!-- Index to find RDF-subjects with URI -->
	<xsl:key name="subject" match="*" use="@rdf:about"/>
	<!-- Index to find RDF-subjects with object-URI -->
	<xsl:key name="object" match="*" use="@rdf:resource"/>
	
	<!-- cast XSD-datatypes tot GAB/MIM-datatypes -->
    <xsl:function name="type:cast">    
      <xsl:param name="input"/>
		<xsl:choose>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#string'"><xsl:sequence select="'http://bp4mc2.org/def/mim#Characterstring'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#token'"><xsl:sequence select="'http://bp4mc2.org/def/mim#Characterstring'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#integer'"><xsl:sequence select="'http://bp4mc2.org/def/mim#Integer'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#float'"><xsl:sequence select="'http://bp4mc2.org/def/mim#real'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#decimal'"><xsl:sequence select="'http://bp4mc2.org/def/mim#Decimal'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#boolean'"><xsl:sequence select="'http://bp4mc2.org/def/mim#Boolean'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#date'"><xsl:sequence select="'http://bp4mc2.org/def/mim#Date'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#dateTime'"><xsl:sequence select="'http://bp4mc2.org/def/mim#DateTime'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#gYear'"><xsl:sequence select="'http://bp4mc2.org/def/mim#Year'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#gDay'"><xsl:sequence select="'http://bp4mc2.org/def/mim#Day'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#gMonth'"><xsl:sequence select="'http://bp4mc2.org/def/mim#Month'"/></xsl:when>
			<xsl:when test="$input='http://www.w3.org/2001/XMLSchema#anyURI'"><xsl:sequence select="'http://bp4mc2.org/def/mim#URI'"/></xsl:when>		
		</xsl:choose>     
    </xsl:function>	

	<!-- Main template -->
	<xsl:template match="/">
		<xsl:message>Start transformation: <xsl:value-of select="current-dateTime()"/></xsl:message>
		<xsl:comment>Generated with rdf2xmi-mim.xslt <xsl:value-of select="current-dateTime()"/></xsl:comment>
	
		<XMI xmi.version="1.3">
		<!-- nota bene: xmi-versie 1.3 is getest met Enterprise Architect -->
			 <XMI.header>
			  <XMI.documentation>
			   <XMI.exporter>Onderwijscatalogus</XMI.exporter>
			   <XMI.exporterVersion>0.1</XMI.exporterVersion>
			   </XMI.documentation>
			 </XMI.header>				
			 <XMI.content>
							
			<UML:Model xmi.type="UML:Model" xmi.id="http://lod.onderwijsregistratie.nl" name="Onderwijsdatamodel">
			<UML:Namespace.ownedElement>
				<xsl:comment> ## CORE DATATYPES ##</xsl:comment>

				<!-- header info variant 1 & 2-->
				<xsl:apply-templates select="//owl:Ontology" mode="core" />
				<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#Ontology']" mode="core"/>

				<xsl:comment> ## CANONICAL DATATYPES/ENUMERATION ##</xsl:comment>
				<UML:Package xmi.type="UML:Package" xmi.id="http://lod.onderwijsregistratie.nl/cdm" name="CDM">		
				<UML:Namespace.ownedElement>
				
					<!-- rich datatypes variant 1 & 2  -->
					<xsl:message>Rich datatypes:</xsl:message>
					<xsl:apply-templates select="//owl:DatatypeProperty" mode="datatype"/>
					<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#DatatypeProperty']" mode="datatype"/>

					<!-- enumerations variant 1 & 2-->
					<xsl:message>Enumerations:</xsl:message>
					<xsl:apply-templates select="//owl:ObjectProperty" mode="enumeration"/>
					<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#ObjectProperty']" mode="enumeration"/>


				</UML:Namespace.ownedElement>
				</UML:Package>

				<xsl:comment> ## LOGICAL DATAMODEL  ## </xsl:comment>
				<UML:Package xmi.type="UML:Package" xmi.id="http://lod.onderwijsregistratie.nl/LDM" name="LDM">		
				<UML:Namespace.ownedElement>

					<!-- classes/objecttypes variant 1 & 2 -->
					<xsl:message>Classes/objecttypes:</xsl:message>
					<xsl:apply-templates select="//sh:NodeShape[exists(sh:property)]" mode="class"/>
					<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/ns/shacl#NodeShape'][exists(sh:property)]" mode="class"/>


				</UML:Namespace.ownedElement>
				</UML:Package>

			</UML:Namespace.ownedElement>
			</UML:Model>

		
			<xsl:message>End transformation</xsl:message>	
		</XMI.content>
		</XMI>	

	</xsl:template>


	<!-- Templates for modelelements-->

	<!-- header info variant 1 -->	
	<xsl:template match="owl:Ontology" mode="core">
		<xsl:call-template name="core"/>
	</xsl:template>

	<!-- header info variant 1 -->	
	<xsl:template match="rdf:Description" mode="core">
		<xsl:call-template name="core"/>
	</xsl:template>

	<xsl:template name="core">

			<!-- core datatypes-->	
			<UML:Package xmi.type="UML:Package" xmi.id="http://lod.onderwijsregistratie.nl/gab" name="GAB">		
		    <UML:Namespace.ownedElement>
						<UML:DataType name="Characterstring" xmi.id="http://bp4mc2.org/def/mim#Characterstring"/>
						<UML:DataType name="Integer" xmi.id="http://bp4mc2.org/def/mim#Integer"/>					
						<UML:DataType name="Real" xmi.id="http://bp4mc2.org/def/mim#Real"/>					
						<UML:DataType name="Decimal" xmi.id="http://bp4mc2.org/def/mim#Decimal"/>					
						<UML:DataType name="Boolean" xmi.id="http://bp4mc2.org/def/mim#Boolean"/>					
						<UML:DataType name="Date" xmi.id="http://bp4mc2.org/def/mim#Date"/>					
						<UML:DataType name="DateTime" xmi.id="http://bp4mc2.org/def/mim#DateTime"/>					
						<UML:DataType name="Year" xmi.id="http://bp4mc2.org/def/mim#Year"/>					
						<UML:DataType name="Day" xmi.id="http://bp4mc2.org/def/mim#Day"/>					
						<UML:DataType name="Month" xmi.id="http://bp4mc2.org/def/mim#Month"/>					
						<UML:DataType name="URI" xmi.id="http://bp4mc2.org/def/mim#URI"/>										
			</UML:Namespace.ownedElement>
			</UML:Package>		

	</xsl:template>

	<!-- rich datatypes variant 1 -->
	<xsl:template match="owl:DatatypeProperty" mode="datatype">
		<xsl:call-template name="datatype"/>
	</xsl:template>

	<!-- rich datatypes variant 2-->
	<xsl:template match="rdf:Description" mode="datatype">
		<xsl:call-template name="datatype"/>	
	</xsl:template>

	<!-- rich datatypes -->
	<xsl:template name="datatype">

		<xsl:variable name="dt-name" select= "rdfs:label"/>
		<xsl:variable name="dt-uri" select= "@rdf:about"/>
		
		<xsl:message>	-  <xsl:value-of select="$dt-name"/></xsl:message>
		<xsl:comment>rich datatype <xsl:value-of select="$dt-name"/></xsl:comment>

		<!-- fetch with object-key canoniek propertyShape in CDM -->		
		<xsl:for-each select="key('object', @rdf:about)/..[rdfs:isDefinedBy/@rdf:resource='http://lod.onderwijsregistratie.nl/doc/ontology/CDM']">
			<!-- focus = PropertyShape -->
			<!-- filter = canoniek CDM -->
			
			<xsl:variable name="ps-name" select= "tokenize(@rdf:about,'/')[last()]"/>
			<xsl:variable name="ps-uri" select= "@rdf:about"/>
			<xsl:variable name="ps-version" select= "tokenize(@rdf:about,'-')[last()]"/>
				
			<UML:DataType name="{$ps-name}" xmi.id="{$ps-uri}">
				<!-- Tagged values -->
				<UML:ModelElement.taggedValue>

				<UML:TaggedValue tag="rdfType" xmi.id="{concat($ps-uri,'-tp')}" value="{$dt-uri}"/>
				<xsl:if test="exists(dc:replacedBy)">
					<UML:TaggedValue tag="replacedBy" value="{tokenize(dc:replacedBy/@rdf:resource,'/')[last()]}"/>							
				</xsl:if>				
				<xsl:if test="exists(schema:endDate)">
					<UML:TaggedValue tag="endDate" value="{schema:endDate}"/>							
				</xsl:if>				

<!--					<UML:TaggedValue tag="ea_stype" value="PrimitiveType"/>
				<UML:TaggedValue tag="stereotype" value="Primitief datatype"/>
-->

				<xsl:if test="exists(sh:minLength)">
					<xsl:variable name="minLength" select= "sh:minLength"/>	
					<UML:TaggedValue tag="minLength" xmi.id="{concat($ps-uri,'-mn')}"  value="{$minLength}"/>
				</xsl:if>
				<xsl:if test="exists(sh:maxLength)">
					<xsl:variable name="maxLength" select= "sh:maxLength"/>	
					<UML:TaggedValue tag="maxLength" xmi.id="{concat($ps-uri,'-mx')}"  value="{$maxLength}"/>
				</xsl:if>
				<xsl:for-each select="sh:pattern">
					<xsl:variable name="pattern" select= "."/>	
					<xsl:variable name="nr" select= "position()"/>	
					<UML:TaggedValue tag="pattern" xmi.id="{concat($ps-uri,'-pt',$nr)}"  value="{$pattern}"/>
				</xsl:for-each>
					
				</UML:ModelElement.taggedValue> 
			</UML:DataType>

			<xsl:variable name="ps-core" select="type:cast(sh:datatype/@rdf:resource)"/>
			<UML:Generalization subtype="{$ps-uri}" supertype="{$ps-core}" xmi.id="{concat($ps-uri,'-gn')}">		
<!--				<UML:ModelElement.taggedValue>
					<UML:TaggedValue tag="ea_type" value="Generalization"/>
					<UML:TaggedValue tag="stereotype" value="Generalisatie"/>
					<UML:TaggedValue tag="Datum opname" xmi.id="EAID_FB3F1EDB_45C3_1445_8DCF_74AA807615B8">
					</UML:TaggedValue>
				</UML:ModelElement.taggedValue>
-->			</UML:Generalization>
		</xsl:for-each>
				
	</xsl:template>


	<!-- enumerations and enumeration literals variant 1-->
	<xsl:template match="owl:ObjectProperty" mode="enumeration">
		<!-- just select enumeration, not associations-->
		<xsl:if test="exists(rdfs:range)">
			<xsl:call-template name="enumeration"/>	
		</xsl:if>
	</xsl:template>

	<!-- enumerations and enumeration literals variant 2-->
	<xsl:template match="rdf:Description" mode="enumeration">
		<!-- just select enumeration, not associations-->
		<xsl:if test="exists(rdfs:range)">
			<xsl:call-template name="enumeration"/>	
		</xsl:if>
	</xsl:template>

	<xsl:template name="enumeration">
		<!-- focus = ObjectProperty -->
		<!-- precondition: only with range meaning enumeration-->

		<xsl:variable name="en-name" select= "rdfs:label"/>
		<xsl:variable name="en-uri" select= "rdfs:range/@rdf:resource"/>
		
		<xsl:message>	-  <xsl:value-of select="$en-name"/></xsl:message>
		<xsl:comment>enumeration  <xsl:value-of select="$en-name"/></xsl:comment>

		<!-- fetch with object-key canoniek propertyShape in CDM -->		
		<xsl:for-each select="key('object', @rdf:about)/..[rdfs:isDefinedBy/@rdf:resource='http://lod.onderwijsregistratie.nl/doc/ontology/CDM']">
			<!-- focus = PropertyShape -->
			<!-- filter = canoniek = CDM -->

			<xsl:for-each select="key('subject', sh:node/@rdf:resource)">
			<!-- focus = NodeShape (belonging to an enumeration class) -->

				<xsl:variable name="ns-name" select= "tokenize(@rdf:about,'/')[last()]"/>
				<xsl:variable name="ns-uri" select= "@rdf:about"/>
				<xsl:variable name="ns-version" select= "tokenize(@rdf:about,'-')[last()]"/>
		
			
				<UML:Enumeration name="{$ns-name}" xmi.id="{$ns-uri}">

				<!-- TAGGED VALUES  -->
				<UML:ModelElement.taggedValue>

				<UML:TaggedValue tag="rdfType" xmi.id="{concat($ns-uri,'-tp')}" value="{$en-uri}"/>
				<xsl:if test="exists(dc:replacedBy)">
					<UML:TaggedValue tag="replacedBy" value="{tokenize(dc:replacedBy/@rdf:resource,'/')[last()]}"/>							
				</xsl:if>				
				<xsl:if test="exists(schema:endDate)">
					<UML:TaggedValue tag="endDate" value="{schema:endDate}"/>							
				</xsl:if>				

<!--					<UML:TaggedValue tag="ea_stype" value="PrimitiveType"/>
				<UML:TaggedValue tag="stereotype" value="Primitief datatype"/>
-->

				<!-- look tags up at propertyshape-->
				<xsl:variable name="minLength" select= "key('object', @rdf:about)/../sh:minLength"/>	
				<xsl:if test="exists($minLength)">
					<UML:TaggedValue tag="minLength" xmi.id="{concat($ns-uri,'-mn')}"  value="{$minLength}"/>
				</xsl:if>

				<xsl:variable name="maxLength" select= "key('object', @rdf:about)/../sh:maxLength"/>	
				<xsl:if test="exists($maxLength)">
					<UML:TaggedValue tag="maxLength" xmi.id="{concat($ns-uri,'-mn')}"  value="{$maxLength}"/>
				</xsl:if>
				
				<xsl:for-each select="key('object', @rdf:about)/../sh:pattern">
					<xsl:variable name="pattern" select= "."/>	
					<xsl:variable name="nr" select= "position()"/>	
					<UML:TaggedValue tag="pattern" xmi.id="{concat($ns-uri,'-pt',$nr)}"  value="{$pattern}"/>
				</xsl:for-each>
					
				</UML:ModelElement.taggedValue> 
				
				<!-- ## ENUMERATION LITERALS -->
	
				<UML:Classifier.feature>

					<!-- fetch enumeration literals with object key-->
					<xsl:for-each select="key('object', $en-uri)/..[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#NamedIndividual']">
						<!-- focus is Named Individual -->

						<xsl:variable name="lt-name" select="rdfs:label"/>
						<xsl:variable name="lt-uri" select="@rdf:about"/>
	
						<UML:Attribute name="{$lt-name}" xmi.id="{$lt-uri}">
<!--							<UML:ModelElement.taggedValue>
								<UML:TaggedValue tag="stereotype" value="Enumeratiewaarde"/>
								<UML:TaggedValue tag="rdfType" value="{$lt-uri}" xmi.id="{$lt-uri)}"/>									
							</UML:ModelElement.taggedValue>												
-->						</UML:Attribute>

					</xsl:for-each>		
			
				</UML:Classifier.feature>
	

				</UML:Enumeration>
	
				<!-- GENERALIZATION  -->
				<!-- look generalization up at propertyshape-->
				<xsl:variable name="ns-core" select="type:cast(key('object', @rdf:about)/../sh:datatype/@rdf:resource)"/>
				<UML:Generalization subtype="{$ns-uri}" supertype="{$ns-core}" xmi.id="{concat($ns-uri,'-gn')}">		
	<!--				<UML:ModelElement.taggedValue>
						<UML:TaggedValue tag="ea_type" value="Generalization"/>
						<UML:TaggedValue tag="stereotype" value="Generalisatie"/>
						<UML:TaggedValue tag="Datum opname" xmi.id="EAID_FB3F1EDB_45C3_1445_8DCF_74AA807615B8">
						</UML:TaggedValue>
					</UML:ModelElement.taggedValue>
	-->			</UML:Generalization>

			</xsl:for-each>
		</xsl:for-each>
				
	</xsl:template>


	<!-- classes variant 1 -->
	<xsl:template match="sh:NodeShape" mode="class">
		<xsl:if test="rdfs:isDefinedBy/@rdf:resource!='http://lod.onderwijsregistratie.nl/doc/ontology/CDM'">
			<xsl:call-template name="class"/>	
		</xsl:if>
	</xsl:template>

	<!-- classes variant 2-->
	<xsl:template match="rdf:Description" mode="class">
		<xsl:if test="rdfs:isDefinedBy/@rdf:resource!='http://lod.onderwijsregistratie.nl/doc/ontology/CDM'">
			<xsl:call-template name="class"/>	
		</xsl:if>
	</xsl:template>
	
<!-- classes -->
	<xsl:template name ="class">
		<!-- focus is NodeShape -->
		<!-- precondition: exists(sh:property) to exclude NodeShape for EnumerationClass-->
		<!-- precondition: canonical nodeshapes (CDM) excluded -->

		<!-- easyrdf creates a subnode for a class being a superclass. strange. anyway, this makes next operation non distinct. Therefore distinct-values  -->
		<xsl:variable name="cl-name" select="distinct-values(key('subject', sh:targetClass/@rdf:resource)/rdfs:label)"/>
		<xsl:variable name="cl-uri" select="distinct-values(key('subject', sh:targetClass/@rdf:resource)/@rdf:about)"/>

			<xsl:message>	-  <xsl:value-of select="$cl-name"/></xsl:message>
			<xsl:comment>class  <xsl:value-of select="$cl-name"/></xsl:comment>		
				
			<UML:Class name="{$cl-name}" xmi.id="{$cl-uri}">	

				<!-- tagged values -->
				<UML:ModelElement.taggedValue>
<!--					<UML:TaggedValue tag="ea_stype" value="Class"/>
				<UML:TaggedValue tag="stereotype" value="Objecttype"/>
-->	

		<!--		<UML:TaggedValue tag="rdfType" xmi.id="EAID_EBF7A679_4E9D_974e_841F_D5129359AB05" value="http://lod.duo.nl/def/id/Onderwijsaanbieder" modelElement="http://lod.duo.nl/sh/id/Onderwijsaanbieder"/>
				--><!-- <UML:TaggedValue tag="Begrip" xmi.id="EAID_EBF7A679_4E9D_974e_841F_D5129359AB04" value="https://lod.duo.nl/term/Onderwijsaanbieder" modelElement="http://lod.duo.nl/sh/id/Onderwijsaanbieder"/> --><!--
				<UML:TaggedValue tag="Datum opname" xmi.id="EAID_FB3F1EDB_51FF_2d51_BA48_EB814B9FC35F" value="2020-04-01" modelElement="http://lod.duo.nl/sh/id/Onderwijsaanbieder"/>
				<UML:TaggedValue tag="Herkomst" xmi.id="EAID_6B33862D_C751_5dc7_94FA_0B8249344CAE" value="DBRON" modelElement="http://lod.duo.nl/sh/id/Onderwijsaanbieder"/>
				<UML:TaggedValue tag="Herkomst definitie" xmi.id="EAID_1FAA1D3E_1B62_631b_BEB6_5DB6F16BE336" value="DBRON" modelElement="http://lod.duo.nl/sh/id/Onderwijsaanbieder"/>
		-->
		
					<UML:TaggedValue tag="rdfType" xmi.id="{$cl-uri}" value="{$cl-uri}"/>
				</UML:ModelElement.taggedValue>		
				
				<!-- focus is nodeshape -->
				<UML:Classifier.feature>
		
					<!-- fetch attributes (not associations) variant 1 -->
					<xsl:for-each select=".//sh:PropertyShape[exists(sh:datatype)]">
						<xsl:call-template name="attributes"/>
					</xsl:for-each>		
		
					<!-- fetch attributes (not associations) variant 2 -->
					<xsl:for-each select="key('subject', sh:property/@rdf:resource)[exists(sh:datatype)]">		
						<xsl:call-template name="attributes"/>
					</xsl:for-each>		
		
				</UML:Classifier.feature>
			</UML:Class>
			<!-- focus is NodeShape -->
			
			<!-- find generalization(s) -->
			<xsl:for-each select="key('subject', sh:targetClass/@rdf:resource)/rdfs:subClassOf">
				<!-- focus is class/subclass -->
				<xsl:comment>generalization of <xsl:value-of select="$cl-name"/></xsl:comment>	
				<xsl:variable name="gn-nr" select="position()"/>

				<!-- fetch generalization variant 1 FOR EXAMPLE  EASYRDF -->
				<xsl:for-each select="owl:Class">
					<xsl:call-template name="generalizations">
						<xsl:with-param name="cl-name" select="$cl-name"/>
						<xsl:with-param name="cl-uri" select="$cl-uri"/>
						<xsl:with-param name="gn-nr" select="$gn-nr"/>
						
					</xsl:call-template>
				</xsl:for-each>		
	
				<!-- fetch generalization variant 2 FOR EXAMPLE VIRTUOSO -->
				<xsl:for-each select="key('subject',@rdf:resource)">		
					<xsl:call-template name="generalizations">
						<xsl:with-param name="cl-name" select="$cl-name"/>
						<xsl:with-param name="cl-uri" select="$cl-uri"/>					
						<xsl:with-param name="gn-nr" select="$gn-nr"/>
					</xsl:call-template>
				</xsl:for-each>		

			</xsl:for-each>
			<!-- focus is NodeShape again -->


			<!-- fetch associations variant 1 -->
			<xsl:for-each select="./sh:property/sh:PropertyShape[not(exists(sh:datatype))]">
				<xsl:comment>association starting at source <xsl:value-of select="$cl-name"/></xsl:comment>	
				<xsl:call-template name="associations">
					<xsl:with-param name="cl-name" select="$cl-name"/>
					<xsl:with-param name="cl-uri" select="$cl-uri"/>
				</xsl:call-template>
			</xsl:for-each>		

			<!-- fetch associations variant 2 -->
			<xsl:for-each select="key('subject', sh:property/@rdf:resource)[not(exists(sh:datatype))]">		
				<xsl:comment>association starting at source <xsl:value-of select="$cl-name"/></xsl:comment>	
				<xsl:call-template name="associations">
					<xsl:with-param name="cl-name" select="$cl-name"/>
					<xsl:with-param name="cl-uri" select="$cl-uri"/>
				</xsl:call-template>
			</xsl:for-each>		
	
	</xsl:template>

	<!-- attributes -->
	<xsl:template name ="attributes">
		<!-- focus = propertyshape -->									
		<!-- precondition: exclude propertyshapes without datatype because they represent associations -->
		<xsl:variable name="at-name" select="sh:name"/>
		<xsl:variable name="at-uri" select="@rdf:about"/>
		<xsl:variable name="at-lp" select="tokenize(@rdf:about,'/')[last()]"/>
		<xsl:variable name="at-min" select="sh:minCount"/>
		<xsl:variable name="at-max" select="sh:maxCount"/>
		
		<xsl:choose>	
			<!-- attributes with domain rich datatype -->
			<xsl:when test="sh:nodeKind/@rdf:resource='http://www.w3.org/ns/shacl#Literal'">
			
				<!--  find canonical propertyhape (cdm) with same path  -->
				<xsl:for-each select="key('object',sh:path/@rdf:resource)/..[rdfs:isDefinedBy/@rdf:resource= 'http://lod.onderwijsregistratie.nl/doc/ontology/CDM']">
					<!-- uri's must have same lastPart-->
					<xsl:if test="$at-lp=tokenize(@rdf:about,'/')[last()]">
						<xsl:variable name="at-type" select="@rdf:about"/>

						<UML:Attribute name="{$at-name}" xmi.id="{$at-uri}" type="{$at-type}">
							<UML:ModelElement.taggedValue>
		<!--										<UML:TaggedValue tag="type" value="{$at-type}"/>
		-->		<!--								<UML:TaggedValue tag="stereotype" value="Attribuutsoort"/>
		-->	
								<xsl:if test="exists($at-min)">
									<UML:TaggedValue tag="lowerBound" value="{$at-min}"/>									
								</xsl:if>	
								<xsl:if test="exists($at-max)">
									<UML:TaggedValue tag="upperBound" value="{$at-max}"/>									
								</xsl:if>	
		
							</UML:ModelElement.taggedValue>
						</UML:Attribute>

					</xsl:if>
				</xsl:for-each>

			</xsl:when>
			<!-- attributes with domain enumeration -->
			<xsl:otherwise>
			
				<!--  find canonical propertyhape (cdm) with same path  -->
				<xsl:for-each select="key('object',sh:path/@rdf:resource)/..[rdfs:isDefinedBy/@rdf:resource= 'http://lod.onderwijsregistratie.nl/doc/ontology/CDM']">
					<!-- uri's must have same lastPart-->
					<xsl:if test="$at-lp=tokenize(@rdf:about,'/')[last()]">
						<xsl:variable name="at-type" select="sh:node/@rdf:resource"/>
						<UML:Attribute name="{$at-name}" xmi.id="{$at-uri}" type="{$at-type}">
							<UML:ModelElement.taggedValue>
		<!--										<UML:TaggedValue tag="type" value="{$at-type}"/>
		-->		<!--								<UML:TaggedValue tag="stereotype" value="Attribuutsoort"/>
		-->	
								<xsl:if test="exists($at-min)">
									<UML:TaggedValue tag="lowerBound" value="{$at-min}"/>									
								</xsl:if>	
								<xsl:if test="exists($at-max)">
									<UML:TaggedValue tag="upperBound" value="{$at-max}"/>									
								</xsl:if>	
		
							</UML:ModelElement.taggedValue>
						</UML:Attribute>

					</xsl:if>
				</xsl:for-each>

			

			</xsl:otherwise>
		</xsl:choose>			
			
	</xsl:template>


	<!-- generalizations-->
	<xsl:template name ="generalizations">
		<xsl:param name="cl-name"/>
		<xsl:param name="cl-uri"/>
		<xsl:param name="gn-nr"/>
		<!-- focus = superclass -->									

			<xsl:variable name="gn-name" select="rdfs:label"/>
			<xsl:variable name="gn-uri" select="@rdf:about"/>
						
			<UML:Generalization subtype="{$cl-uri}" supertype="{$gn-uri}" xmi.id="{concat($cl-uri,'-gn',$gn-nr)}">		
	<!--				<UML:ModelElement.taggedValue>
					<UML:TaggedValue tag="ea_type" value="Generalization"/>
					<UML:TaggedValue tag="stereotype" value="Generalisatie"/>
					<UML:TaggedValue tag="Datum opname" xmi.id="EAID_FB3F1EDB_45C3_1445_8DCF_74AA807615B8">
					</UML:TaggedValue>
				</UML:ModelElement.taggedValue>
	-->			</UML:Generalization>


	</xsl:template>

	<!-- associations -->
	<xsl:template name ="associations">
		<xsl:param name="cl-name"/>
		<xsl:param name="cl-uri"/>
		<!-- focus = propertyshape -->									
		<!-- pre-condition: propertyshapes without datatype because they represent associations -->

		<xsl:variable name="as-name" select="sh:name"/>
		<xsl:variable name="as-uri" select="@rdf:about"/>

		<xsl:variable name="tg-uri" select="sh:class/@rdf:resource"/>
		<xsl:variable name="mult" select="concat(sh:minCount,'..' ,sh:maxCount)"/>
		<!-- todo indien min of max niet aanwezig -->							
		<UML:Association name="{$as-name}" xmi.id="{$as-uri}">
		
<!-- RDF doesn't have bidirectional relationships. You need two inversed properties. That is not within the present scope. So the multiplicity for the target is undetermined -->
	
					<UML:Association.connection>
				<UML:AssociationEnd multiplicity="{$mult}" type="{$cl-uri}">
<!--									<UML:ModelElement.taggedValue>
								<UML:TaggedValue tag="ea_end" value="source"/>
							</UML:ModelElement.taggedValue>
-->								</UML:AssociationEnd>
						<UML:AssociationEnd type="{$tg-uri}">
<!--								<UML:AssociationEnd multiplicity="*" type="{$tg-uri}">
							<UML:ModelElement.taggedValue>
								<UML:TaggedValue tag="ea_end" value="target"/>
							</UML:ModelElement.taggedValue>
-->								</UML:AssociationEnd>
					</UML:Association.connection>
		
		</UML:Association>

	</xsl:template>

	
</xsl:stylesheet>
