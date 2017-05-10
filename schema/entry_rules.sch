<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="purpose">
            <!-- Change the assert expression. -->
            <sch:assert test="@type = ('advice', 'making', 'application', 'medicine', 'observation', 'description')">Error: values for <name/> must be 'advise', 'making', 'application', 'medicine', 'observation', 'description' only</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>