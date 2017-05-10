<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="/">
        <xsl:text>&#10;</xsl:text>
        <xsl:text>#</xsl:text>
        <xsl:text>&#160;Element Definitions</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates select="//element[@name = 'block']"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="element">
        <xsl:apply-templates select="content-model/child"><xsl:sort select="text()"></xsl:sort></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="child">
        <xsl:text>&#10;</xsl:text>
        <xsl:text>###</xsl:text>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
</xsl:stylesheet>