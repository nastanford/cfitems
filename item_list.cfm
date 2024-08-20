<!--- item_list.cfm --->
<cfset itemService = new ItemService()>
<cfset items = itemService.getItems()>

<table class="table table-striped">
    <thead>
        <tr>
            <th class="pe-3">Position</th>
            <th class="px-3">Name</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody id="itemList">
        <cfoutput query="items">
            <tr data-id="#items.id#">
                <td class="pe-3">#items.position#</td>
                <td class="pe-3">#items.name#</td>
                <td class="pe-3">
                    <button class="drag-handle btn btn-sm btn-secondary" aria-label="Drag to reorder">Drag</button>
                    <button onclick="moveUp(this)" aria-label="Move item up" class="move-up btn btn-sm btn-secondary" <cfif items.currentRow eq 1>disabled</cfif>>Up</button>
                    <button onclick="moveDown(this)" aria-label="Move item down" class="move-down btn btn-sm btn-secondary" <cfif items.currentRow eq items.recordCount>disabled</cfif>>Down</button>
                </td>
            </tr>
        </cfoutput>
    </tbody>
</table>