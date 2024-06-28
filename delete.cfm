<cfif isDefined("form.id")>
    <cfquery datasource="sales_dsn" name="qProducts">
        DELETE FROM products WHERE id=#form.id#
    </cfquery>
</cfif>

<cflocation url="index.cfm" >
