<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="iso-8859-1"/>

<xsl:strip-space elements="*" />

<xsl:template match="T">
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template match="Synonym">
<xsl:text>,</xsl:text><xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template match="TermInfo">
<xsl:if test="child::Synonym">
<xsl:apply-templates select="T|Synonym"/>
</xsl:if>
</xsl:template>

<xsl:template match="/">
<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
