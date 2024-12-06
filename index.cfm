<cfinclude template="./includes/header.cfm">
<style>
content_title{
  font-family: "proxima-nova", sans-serif;
}
</style>

<div class="container">
  <div class="row">
    <h2 class="content_title">Item Reorder List</h2>
    <h5>Drag and Drop and Buttons - 508 Compatible</h5>
    <div id="itemListContainer">
      <cfinclude template="item_list.cfm">
    </div>
    <cfinclude template="./includes/footer.cfm">
  </div>
</div>
