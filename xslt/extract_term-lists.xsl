<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="/">
        <xsl:result-document method="text" encoding="UTF-8" href="../materials.csv">
            <xsl:apply-templates select="//material">
                <xsl:sort select="." order="ascending"/>
            </xsl:apply-templates>
        </xsl:result-document>
        <xsl:result-document method="text" encoding="UTF-8" href="../tools.csv">
            <xsl:apply-templates select="//tool">
                <xsl:sort select="." order="ascending"/>
            </xsl:apply-templates>
        </xsl:result-document>
        

    </xsl:template>
    <xsl:template match="material| tool">

     <xsl:value-of select="preceding::entry[1]/@identifier"/>
     <xsl:text>|</xsl:text>
     <xsl:value-of select="normalize-space(.)"/>
     <xsl:text>&#10;</xsl:text>
        
    </xsl:template>
</xsl:stylesheet>