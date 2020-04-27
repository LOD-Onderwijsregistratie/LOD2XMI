<!--
    NAME     rdf2xmi_basic-v04.xslt
    VERSION  0.4
    DATE     2020-04-21
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

<xsl:stylesheet xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/terms/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:sh="http://www.w3.org/ns/shacl#" xmlns:UML="http://schema.omg.org/spec/UML/2.5.1"  xmlns:xmi="http://schema.omg.org/spec/XMI/2.1" xmlns:type="http://whatever" version="2.1" exclude-result-prefixes="type">

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
		<!-- nota bene: xmi-versie 1.3 is is de laatste neutrale versie die in Enterprise Architect gelezen kan worden -->
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
					<xsl:apply-templates select="//sh:NodeShape" mode="class"/>
					<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/ns/shacl#NodeShape']" mode="class"/>


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

		<UML:DataType name="{$dt-name}" xmi.id="{$dt-uri}">
			<!-- Tagged values -->
			<UML:ModelElement.taggedValue>
<!--					<UML:TaggedValue tag="ea_stype" value="PrimitiveType"/>
					<UML:TaggedValue tag="stereotype" value="Primitief datatype"/>
-->
					<UML:TaggedValue tag="rdfType" xmi.id="{concat($dt-uri,'-tp')}" value="{$dt-uri}"/>
					<!-- fetch with object-key and make distinct sh:PropertyShape constraints with for-each-group -->
					<xsl:for-each-group select="key('object', @rdf:about)/.." group-by="sh:path/@rdf:resource">
						<xsl:if test="exists(sh:minLength)">
							<xsl:variable name="minLength" select= "sh:minLength"/>	
							<UML:TaggedValue tag="minLength" xmi.id="{concat($dt-uri,'-mn')}"  value="{$minLength}"/>
						</xsl:if>
						<xsl:if test="exists(sh:maxLength)">
							<xsl:variable name="maxLength" select= "sh:maxLength"/>	
							<UML:TaggedValue tag="maxLength" xmi.id="{concat($dt-uri,'-mx')}"  value="{$maxLength}"/>
						</xsl:if>
						<xsl:for-each select="sh:pattern">
							<xsl:variable name="pattern" select= "."/>	
							<xsl:variable name="nr" select= "position()"/>	
							<UML:TaggedValue tag="pattern" xmi.id="{concat($dt-uri,'-pt',$nr)}"  value="{$pattern}"/>
						</xsl:for-each>
					</xsl:for-each-group>

			</UML:ModelElement.taggedValue> 

		</UML:DataType>

		<xsl:comment>generalization of <xsl:value-of select="$dt-name"/></xsl:comment>			
		<!-- fetch with object-key en make distinct sh:PropertyShape/sh:datatype with for-each-group -->
		<xsl:for-each-group select="key('object', @rdf:about)/.." group-by="sh:path/@rdf:resource">
			<xsl:variable name="dt-core" select="type:cast(sh:datatype/@rdf:resource)"/>
	
			<UML:Generalization subtype="{$dt-uri}" supertype="{$dt-core}" xmi.id="{concat($dt-uri,'-gn')}">		
<!--				<UML:ModelElement.taggedValue>
					<UML:TaggedValue tag="ea_type" value="Generalization"/>
					<UML:TaggedValue tag="stereotype" value="Generalisatie"/>
					<UML:TaggedValue tag="Datum opname" xmi.id="EAID_FB3F1EDB_45C3_1445_8DCF_74AA807615B8">
					</UML:TaggedValue>
				</UML:ModelElement.taggedValue>
-->			</UML:Generalization>
		</xsl:for-each-group>
				
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

	<!-- enumerations and enumeration literals -->
	<xsl:template name="enumeration">
		<!-- focus = ObjectProperty -->

			<xsl:variable name="en-name" select="key('subject', rdfs:range/@rdf:resource)/rdfs:label"/>
			<xsl:variable name="en-uri" select="key('subject', rdfs:range/@rdf:resource)/@rdf:about"/>
			<xsl:message>	-  <xsl:value-of select="$en-name"/></xsl:message>
			<xsl:comment>enumeration <xsl:value-of select="$en-name"/></xsl:comment>
	
			<UML:Enumeration name="{$en-name}" xmi.id="{$en-uri}">
				<!-- Tagged values -->
				<UML:ModelElement.taggedValue>
<!--							<UML:TaggedValue tag="ea_stype" value="PrimitiveType"/>
							<UML:TaggedValue tag="stereotype" value="Primitief datatype"/>
-->
					<UML:TaggedValue tag="rdfType" xmi.id="{concat($en-uri,'-tp')}" value="{$en-uri}"/>
					<!-- fetch with object-key and make distinct sh:PropertyShape constraints with for-each-group -->
					<xsl:for-each-group select="key('object', @rdf:about)/.." group-by="sh:path/@rdf:resource">
						<xsl:if test="exists(sh:minLength)">
							<xsl:variable name="minLength" select= "sh:minLength"/>	
							<UML:TaggedValue tag="minLength" xmi.id="{concat($en-uri,'-mn')}"  value="{$minLength}"/>
						</xsl:if>
						<xsl:if test="exists(sh:maxLength)">
							<xsl:variable name="maxLength" select= "sh:maxLength"/>	
							<UML:TaggedValue tag="maxLength" xmi.id="{concat($en-uri,'-mx')}"  value="{$maxLength}"/>
						</xsl:if>
						<xsl:for-each select="sh:pattern">
							<xsl:variable name="pattern" select= "."/>	
							<xsl:variable name="nr" select= "position()"/>	
							<UML:TaggedValue tag="pattern" xmi.id="{concat($en-uri,'-pt',$nr)}"  value="{$pattern}"/>
						</xsl:for-each>
					</xsl:for-each-group>
				</UML:ModelElement.taggedValue>

				<!-- shift focus to enumeration (just one)-->
				<xsl:for-each select="key('subject', rdfs:range/@rdf:resource)">
				<!-- focus is Class -->
	
						<UML:Classifier.feature>
		
							<!-- fetch enumeration literals with object key-->
							<xsl:for-each select="key('object', @rdf:about)/..[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#NamedIndividual']">
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
	
				</xsl:for-each>	
			</UML:Enumeration>

			<!-- focus = ObjectProperty -->

			<xsl:variable name="en-name" select="key('subject',rdfs:range/@rdf:resource)/rdfs:label"/>
			<xsl:variable name="en-uri" select="key('subject',rdfs:range/@rdf:resource)/@rdf:about"/>
			<xsl:comment>generalization of <xsl:value-of select="$en-name"/></xsl:comment>	

			<!-- fetch  sh:PropertyShape with object-key en make distinct with for-each-group -->
			<xsl:for-each-group select="key('object', @rdf:about)/.." group-by="sh:path">
				<!-- focus = PropertyShape -->
				<xsl:variable name="en-core" select="type:cast(sh:datatype/@rdf:resource)"/>
				<UML:Generalization subtype="{$en-uri}" supertype="{$en-core}" xmi.id="{concat($en-uri,'-gn')}">		
	<!--				<UML:ModelElement.taggedValue>
						<UML:TaggedValue tag="ea_type" value="Generalization"/>
						<UML:TaggedValue tag="stereotype" value="Generalisatie"/>
						<UML:TaggedValue tag="Datum opname" xmi.id="EAID_FB3F1EDB_45C3_1445_8DCF_74AA807615B8">
						</UML:TaggedValue>
					</UML:ModelElement.taggedValue>
	-->			</UML:Generalization>
			</xsl:for-each-group>			

	</xsl:template>


	<!-- classes variant 1 -->
	<xsl:template match="sh:NodeShape" mode="class">
		<xsl:if test="exists(sh:property)">
			<xsl:call-template name="class"/>	
		</xsl:if>
	</xsl:template>

	<!-- classes variant 2-->
	<xsl:template match="rdf:Description" mode="class">
		<xsl:if test="exists(sh:property)">
			<xsl:call-template name="class"/>	
		</xsl:if>
	</xsl:template>
	
<!-- classes -->
	<xsl:template name ="class">
	
		<!-- focus is NodeShape -->
		<!-- filter: exists(sh:property) to exclude NodeShape for EnumerationClass-->
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

			<!-- find association(s)  -->
			<xsl:comment>association starting at source <xsl:value-of select="$cl-name"/></xsl:comment>	

			<!-- fetch associations variant 1 -->
			<xsl:for-each select="./sh:property/sh:PropertyShape[not(exists(sh:datatype))]">
				<xsl:call-template name="associations">
					<xsl:with-param name="cl-name" select="$cl-name"/>
					<xsl:with-param name="cl-uri" select="$cl-uri"/>
				</xsl:call-template>
			</xsl:for-each>		

			<!-- fetch associations variant 2 -->
			<xsl:for-each select="key('subject', sh:property/@rdf:resource)[not(exists(sh:datatype))]">		
				<xsl:call-template name="associations">
					<xsl:with-param name="cl-name" select="$cl-name"/>
					<xsl:with-param name="cl-uri" select="$cl-uri"/>
				</xsl:call-template>
			</xsl:for-each>		
	
	</xsl:template>

	<!-- attributes -->
	<xsl:template name ="attributes">
		<!-- focus = propertyshape -->									
		<!-- filter: exclude propertyshapes without datatype because they represent associations -->
		<xsl:variable name="at-name" select="sh:name"/>
		<xsl:variable name="at-uri" select="@rdf:about"/>
		<xsl:choose>
			<!-- attributes with domain rich datatype -->
			<xsl:when test="sh:nodeKind/@rdf:resource='http://www.w3.org/ns/shacl#Literal'">
				<xsl:variable name="at-type" select="key('subject', sh:path/@rdf:resource)/@rdf:about"/>
				<UML:Attribute name="{$at-name}" xmi.id="{$at-uri}" type="{$at-type}">
					<UML:ModelElement.taggedValue>
<!--										<UML:TaggedValue tag="type" value="{$at-type}"/>
-->		<!--								<UML:TaggedValue tag="stereotype" value="Attribuutsoort"/>
-->	
						<xsl:if test="exists(sh:minCount)">
							<UML:TaggedValue tag="lowerBound" value="{sh:minCount}"/>									
						</xsl:if>
						<xsl:if test="exists(sh:maxCount)">
							<UML:TaggedValue tag="upperBound" value="{sh:maxCount}"/>									
						</xsl:if>		

					</UML:ModelElement.taggedValue>
				</UML:Attribute>
			</xsl:when>
			<!-- attributes with domain enumeration -->
			<xsl:otherwise>
				<xsl:variable name="at-type" select="key('subject', sh:path/@rdf:resource)/rdfs:range/@rdf:resource"/>
				<UML:Attribute name="{$at-name}" xmi.id="{$at-uri}" type="{$at-type}">
					<UML:ModelElement.taggedValue>
<!--										<UML:TaggedValue tag="type" value="{$at-type}"/>
-->		<!--								<UML:TaggedValue tag="stereotype" value="Attribuutsoort"/>
-->
						<xsl:if test="exists(sh:minCount)">
							<UML:TaggedValue tag="lowerBound" value="{sh:minCount}"/>									
						</xsl:if>
						<xsl:if test="exists(sh:maxCount)">
							<UML:TaggedValue tag="upperBound" value="{sh:maxCount}"/>									
						</xsl:if>
					</UML:ModelElement.taggedValue>
				</UML:Attribute>
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
		<!-- filter: propertyshapes without datatype because they represent associations -->

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
