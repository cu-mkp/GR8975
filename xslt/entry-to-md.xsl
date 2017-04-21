<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="text"/>

    <!-- SAT: Selecciona las <div> de primer nivel: -->
    <xsl:template match="/">
        <xsl:apply-templates select="/entry"/>
    </xsl:template>

    <!-- <xsl:strip-space elements="*"/>-->
    <xsl:param name="materials">
        <xsl:sequence select="//material/normalize-space(.)"> </xsl:sequence>
    </xsl:param>

    <xsl:param name="categories">
        <xsl:sequence select="//activity/normalize-space(@type)"> </xsl:sequence>
    </xsl:param>


    <xsl:template match="entry">
        <xsl:message select="$materials"/>
        <xsl:variable name="sect_id" select="@identifier"/>
        <xsl:result-document method="text" encoding="utf-8" href="../_texts/{$sect_id}.md"
            omit-xml-declaration="yes">

            <!-- YAML for Ed -->
            <xsl:text>---&#x0A;layout: narrative&#x0A;</xsl:text>
            <xsl:text>title: </xsl:text>
            <xsl:value-of select="normalize-space(child::heading)"/>
            <xsl:text>&#x0A;</xsl:text>
            <xsl:text>folio: </xsl:text>
            <xsl:value-of select="child::folio[1]/@number"/>
            <xsl:text>&#x0A;</xsl:text>
            <xsl:text>annotation: </xsl:text>
            <xsl:choose>
                <xsl:when test="//annotations/annotation/normalize-space(@title)">
                    <xsl:text>yes</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>no</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
             <xsl:text>&#x0A;</xsl:text>
            <xsl:text>author:</xsl:text>
            <xsl:text>&#x0A;</xsl:text>
            <xsl:text>mode: annotated</xsl:text>
            <xsl:text>&#x0A;</xsl:text>
            <xsl:text>editor: GR8975 Seminar Participants&#x0A;</xsl:text>
            <xsl:text>rights: Public Domain&#x0A;</xsl:text>
            <xsl:text>categories: </xsl:text>
            <xsl:text>[</xsl:text>
            <xsl:value-of select="replace($categories, ' ', ', ')"/>
            <xsl:text>]</xsl:text>
            <xsl:text>&#x0A;</xsl:text>
            <xsl:text>tags: </xsl:text>
            <xsl:text>[</xsl:text>
            <xsl:value-of select="replace($materials, ' ', ', ')"/>
            <xsl:text>]</xsl:text>
            <xsl:text>&#x0A;</xsl:text>
            <xsl:text>---&#x0A;&#x0A;</xsl:text>

            <xsl:apply-templates/>


        </xsl:result-document>
    </xsl:template>

    <xsl:template match="heading">
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>## </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#xa;&#xa;</xsl:text>
    </xsl:template>

    <xsl:template match="block">
        <xsl:text>&#x0A;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#x0A;</xsl:text>
    </xsl:template>

    <xsl:template match="margin-block | block[@position]">
        <xsl:text>&#x0A;</xsl:text>
        <xsl:text>&gt; </xsl:text>
        <xsl:text>*position:&#160;</xsl:text>
        <xsl:value-of select="@position"/>
        <xsl:text>*</xsl:text>
        <xsl:text>&#x0A;</xsl:text>
        <xsl:text>&gt; </xsl:text><xsl:text>&#x0A;</xsl:text>
        <xsl:text>&gt; </xsl:text><xsl:apply-templates/>
        <xsl:text>&#x0A;</xsl:text>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:value-of select="replace(replace(replace(., '-', '—'), '\s+', ' '), '\+', '\\+')"/>
    </xsl:template>

    <!-- folio breaks and link to image -->
    <xsl:template match="folio">
        <xsl:text>&lt;div class="folio" align="center"&gt;</xsl:text>
        <xsl:text>- - - - - &lt;a href="</xsl:text>
        <xsl:value-of select="@url"/>
        <xsl:text>" target="_blank"&gt;</xsl:text>
<!--        <xsl:text>&lt;img src="https://github.com/cu-mkp/GR8975-edition/assets/photo-icon.png" alt="folio image: " style="display:inline-block; margin-bottom:-3px;"/&gt;</xsl:text>-->
        <xsl:value-of select="@number"/>
        <xsl:text>&lt;/a&gt; - - - - -</xsl:text>
        <xsl:text> &lt;/div&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="purpose">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template
        match="
            activity | animal | figure | foreign
            | material | material_format | place | plant
            | profession | image | ref | sub_recipe | tool | unit | color | name | q
            | sup | time">
        <xsl:text>&lt;span class="</xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>"&gt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&lt;/span&gt;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
