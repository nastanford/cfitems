<!--- update_order.cfm --->
<cfset itemService = new ItemService()>
<cfset itemService.updateItemPosition(form.id, form.newPosition)>

<cfinclude template="item_list.cfm">