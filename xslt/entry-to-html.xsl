<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">    
    <xsl:output encoding="UTF-8" method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="/entry/heading"/></title>
            </head>
            <body><xsl:apply-templates/>
            </body>
        </html>    
    </xsl:template>
    <xsl:template match="entry">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="heading"><h1><xsl:apply-templates/></h1></xsl:template>
    <xsl:template match="block"><p><xsl:apply-templates/></p></xsl:template>
    <xsl:template match="*"></xsl:template>
</xsl:stylesheet>