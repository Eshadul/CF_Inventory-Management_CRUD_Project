<cfset setLocale("en_US")>

<cfif isDefined("form.operation")>

    <cfif form.operation eq "edit">
        <cfquery datasource="sales_dsn" name="qProducts">
            UPDATE products
            SET  product_name = <cfqueryparam value="#form.product_name#" cfsqltype="cf_sql_varchar">
                ,description = <cfqueryparam value="#form.description#" cfsqltype="cf_sql_varchar">
                ,unit_price = <cfqueryparam value="#form.unit_price#" cfsqltype="cf_sql_numeric">
                ,quantity = <cfqueryparam value="#form.quantity#" cfsqltype="cf_sql_integer">
            WHERE id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfset form.operation = "">
    </cfif>

    <cfif form.operation eq "add">
        <cfquery datasource="sales_dsn" name="qProducts">
            INSERT into products (product_name, description, unit_price, quantity) 
            values (
                <cfqueryparam value="#form.product_name#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.description#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.unit_price#" cfsqltype="cf_sql_numeric">,
                <cfqueryparam value="#form.quantity#" cfsqltype="cf_sql_integer">
            )
        </cfquery>

        <cfset form.operation = "">
    </cfif>

</cfif>

<cfquery datasource="sales_dsn" name="qProducts">
    SELECT id, product_name, description, unit_price, quantity FROM products
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>Inventory Management</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
            <div>
                <a href="#" class="navbar-brand">Inventory Management</a>
            </div>
            <ul class="navbar-nav">
                <li>
                    <a href="/inventory_management" class="navbar-brand">Products</a>
                </li>
            </ul>
        </nav>
    </header>
    <div class="row">
        <div class="container">
            <h3 class="text-center">Product List</h3>
            <p>
                <a href="form.cfm" class="btn btn-primary">New Product</a>
            </p>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Product Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput query="qProducts">
                        <tr>
                            <td scope="row">#qProducts.id#</td>
                            <td>#qProducts.product_name#</td>
                            <td>#qProducts.description#</td>
                            <td>#lsCurrencyFormat(qProducts.unit_price)#</td>
                            <td>#qProducts.quantity#</td>
                            <td>
                            <a href="form.cfm?id=#qProducts.id#" class="btn btn-primary">Edit</a>
                            <button type='button' class="btn btn-danger" data-toggle='modal' data-target='##exampleModal' onclick='$(".delete_id").val(#qProducts.id#)'> Delete </button>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <input type="hidden" name="delete_id" class="delete_id">
                            <h5 class="modal-title" id="exampleModalLabel">Do you really want to delete this record?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            <button type="submit" class="btn btn-danger" onclick="deleteRecord()">Yes</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Optional JavaScript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        function deleteRecord() {
            var id = $(".delete_id").val();
            $.ajax({
                url: "http://localhost:8500/inventory_management/delete.cfm",
                method: "POST",
                data: { id: id },
                success: function(response) {
                    location.reload();
                },
            });
        }
    </script>
    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
