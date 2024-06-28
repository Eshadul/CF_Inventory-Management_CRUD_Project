<cfset setLocale("en_US")>
<!--- <cfparam name="URL.id" default="0" > --->

<cfif isDefined("URL.id")>
    <cftry>
        <cfquery datasource="sales_dsn" name="qProducts">
            SELECT id, product_name, description, unit_price, quantity 
            FROM products
            WHERE id = <cfqueryparam value="#URL.id#" cfsqltype="cf_sql_integer" >
        </cfquery>

        <cfcatch>
            <cflocation url="index.cfm" >
        </cfcatch>   
    </cftry>
<cfelse>
    <cfset qProducts = StructNew()>
    <cfset qProducts.id = 0>
    <cfset qProducts.product_name = "">
    <cfset qProducts.description = "">
    <cfset qProducts.unit_price = 0>
    <cfset qProducts.quantity = 0>
</cfif>

<html lang="en">

<head>
    <title>Inventory Management</title>
    <link rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossorigin="anonymous">
    <meta charset="utf-8">    
</head>

<body>

<header>
    <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
        <div>
            <a href="/inventory_management" class="navbar-brand">
                Inventory Management
            </a>
        </div>

        <ul class="navbar-nav">
            <li><a href="/inventory_management" class="nav-link">Products</a></li>
        </ul>
    </nav>
</header>
<br>
<div class="container col-md-5">
    <div class="card">
        <div class="card-body">

            <cfif isDefined("URL.id")>
                <form action="index.cfm" method="post">
                <input type="hidden" name="operation" value="edit" />                    
                <h2> Editing Product </h2>
            <cfelse>
                <form action="index.cfm" method="post">
                <input type="hidden" name="operation" value="add" />                    
                <h2> Adding Product </h2>

            </cfif>

            <cfoutput>
                <cfif isDefined("URL.id")>
                    <input type="hidden" name="id"  value="#qProducts.id#" />
                </cfif>

                <fieldset class="form-group">
                    <label>Product Name</label> <input type="text"
                        value="#qProducts.product_name#" class="form-control"
                        name="product_name" required="required">
                </fieldset>

                <fieldset class="form-group">
                    <label>Description</label> <input type="text"
                        value="#qProducts.description#" class="form-control"
                        name="description">
                </fieldset>

                <fieldset class="form-group">
                    <label>Unit Price</label> $ <input type="number" step="0.01" min="0.01"
                        value="#qProducts.unit_price#" class="form-control"
                        name="unit_price">
                </fieldset>

                <fieldset class="form-group">
                    <label>Quantity</label> <input type="text"
                        value="#qProducts.quantity#" class="form-control"
                        name="quantity">
                </fieldset>
            </cfoutput>

            <button type="submit" class="btn btn-success">Save</button>
            <a href="/inventory_management" class="btn btn-success">Back</a>
            
            </form>
        </div>
    </div>
</div>

</body>

</html>