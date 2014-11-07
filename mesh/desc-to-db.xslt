<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="iso-8859-1"/>

<xsl:strip-space elements="*" />

<xsl:template match="Term">
<!-- Unfortunately, performace is horrible if using variables -->
<!--
<xsl:variable name="descriptor" select="normalize-space(../../../../DescriptorName/child::String)"/>
<xsl:variable name="term" select="normalize-space(child::String)"/>
-->
<xsl:if test="normalize-space(../../../../DescriptorName/child::String) != normalize-space(child::String)">
	<!-- Post processing should replace ' with \' and then ` with ' -->
	<xsl:text>&#xa;insert into mesh(descriptor, term) values(`</xsl:text>
	<xsl:value-of select="normalize-space(../../../../DescriptorName/child::String)"/>
	<xsl:text>`,`</xsl:text>
	<xsl:value-of select="normalize-space(child::String)"/>
	<xsl:text>`);</xsl:text>
	<xsl:text>&#xa;insert into mesh(descriptor, term) values(`</xsl:text>
	<xsl:value-of select="normalize-space(child::String)"/>
	<xsl:text>`,`</xsl:text>
	<xsl:value-of select="normalize-space(../../../../DescriptorName/child::String)"/>
	<xsl:text>`);</xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="TermList">
  <xsl:apply-templates select="Term"/>
</xsl:template>

<xsl:template match="Concept">
  <xsl:apply-templates select="TermList"/>
</xsl:template>

<xsl:template match="ConceptList">
  <xsl:apply-templates select="Concept"/>
</xsl:template>

<xsl:template match="DescriptorRecord">
  <xsl:apply-templates select="ConceptList"/>
</xsl:template>

<xsl:template match="/">
<xsl:text>SET autocommit=0;</xsl:text>
<xsl:apply-templates/>
<xsl:text>&#xa;COMMIT;</xsl:text>
</xsl:template>

</xsl:stylesheet>
