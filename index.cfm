<!--- index.cfm --->
<cfset itemService = new ItemService()>
<cfset items = itemService.getItems()>

<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reorderable Item List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/htmx.org@2.0.1" integrity="sha384-QWGpdj554B4ETpJJC9z+ZHJcA/i59TyjxEPXiiUgN2WmTyV5OEZWCD6gQhgkdpB/" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    <script src="itemList.js" defer></script>
    <script src="itemList.js" defer></script>    
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Reorderable Item List</h1>
    
    <div id="itemListContainer">
        <cfinclude template="item_list.cfm">
    </div>
</body>
</html>