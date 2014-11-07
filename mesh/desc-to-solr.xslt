<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="iso-8859-1"/>

<xsl:strip-space elements="*" />

<xsl:template match="DescriptorName">
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="normalize-space(child::String)"/>
</xsl:template>

<xsl:template match="Term">
<xsl:text>,</xsl:text>
<xsl:value-of select="normalize-space(child::String)"/>
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
  <xsl:apply-templates select="DescriptorName|ConceptList"/>
</xsl:template>

<xsl:template match="/">
<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
