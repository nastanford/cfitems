<cfsetting showdebugoutput="false">
<!--- item_list.cfm --->
<cfset itemService = new ItemService()>
<cfset items = itemService.getItems()>

  <table class="table table-striped">
    <thead>
      <tr>
        <th class="col-1">Position</th>
        <th class="col-9">Name</th>
        <th class="col-2">Actions</th>
      </tr>
    </thead>
    <tbody id="itemList">
      <cfoutput query="items">
        <tr data-id="#items.id#">
          <td class="col-1">#items.position#</td>
          <td class="col-10">#items.name#</td>
          <td class="col-1" nowrap>
            <button class="drag-handle btn btn-sm btn-secondary" aria-label="Drag to reorder">Move</button>
            <button onclick="moveUp(this)" aria-label="Move item up" class="move-up btn btn-sm btn-secondary" <cfif items.currentRow eq 1>disabled</cfif>>Up</button>
            <button onclick="moveDown(this)" aria-label="Move item down" class="move-down btn btn-sm btn-secondary" <cfif items.currentRow eq items.recordCount>disabled</cfif>>Down</button>
          </td>
        </tr>
      </cfoutput>
    </tbody>
  </table>
