<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output encoding="UTF-8" method="html"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="entry">
        <xsl:variable name="sect_id" select="@identifier"/>
        <xsl:result-document method="xhtml" encoding="utf-8" href="../epub/html/{$sect_id}.xhtml"
            omit-xml-declaration="yes">
            <html>
                <head>
                    <title>
                        <xsl:apply-templates select="/entry/heading"/>
                    </title>
                </head>
                <body>
                    <xsl:apply-templates/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="heading">
        <h3>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>
    <xsl:template match="block | margin-block">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <!--   <xsl:template match="*"></xsl:template>-->
</xsl:transform>
