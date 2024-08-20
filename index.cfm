<!--- index.cfm --->
<cfset itemService = new ItemService()>
<cfset items = itemService.getItems()>

<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reorderable Item List</title>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="../assets/css/styles.css">
    <script src="https://unpkg.com/htmx.org@2.0.1" integrity="sha384-QWGpdj554B4ETpJJC9z+ZHJcA/i59TyjxEPXiiUgN2WmTyV5OEZWCD6gQhgkdpB/" crossorigin="anonymous"></script>

    <style>
        .drag-handle { cursor: move; }
        .dragging { opacity: 0.5; }
    </style>
</head>
<body>
    <h1>Reorderable Item List</h1>
    
    <div id="itemListContainer">
        <cfinclude template="item_list.cfm">
    </div>


<script>
document.body.addEventListener('htmx:configRequest', (event) => {
  event.detail.headers['X-Requested-With'] = 'XMLHttpRequest';
});

let sortable;

function initSortable() {
  if (sortable) {
      sortable.destroy();
  }
  sortable = new Sortable(document.getElementById('itemList'), {
      animation: 150,
      handle: '.drag-handle',
      onEnd: function (evt) {
          const item = evt.item;
          const newIndex = evt.newIndex;
          updateOrder(item.dataset.id, newIndex + 1);
      }
  });
}

initSortable();

document.body.addEventListener('htmx:afterSwap', function(evt) {
  initSortable();
});

function moveUp(btn) {
  const row = btn.closest('tr');
  const prevRow = row.previousElementSibling;
  if (prevRow) {
      const id = row.dataset.id;
      const newPosition = parseInt(prevRow.querySelector('td:first-child').textContent);
      updateOrder(id, newPosition);
  }
}

function moveDown(btn) {
  const row = btn.closest('tr');
  const nextRow = row.nextElementSibling;
  if (nextRow) {
      const id = row.dataset.id;
      const newPosition = parseInt(nextRow.querySelector('td:first-child').textContent);
      updateOrder(id, newPosition);
  }
}

function updateOrder(id, newPosition) {
  htmx.ajax('POST', 'update_order.cfm', {
      target: '#itemListContainer',
      swap: 'innerHTML',
      values: { id: id, newPosition: newPosition }
  });
}

// ... (previous code remains the same)

function updateButtonStates() {
const rows = document.querySelectorAll('#itemList tr');
rows.forEach((row, index) => {
  const upButton = row.querySelector('.move-up');
  const downButton = row.querySelector('.move-down');
  
  upButton.disabled = (index === 0);
  downButton.disabled = (index === rows.length - 1);
});
}

function moveUp(btn) {
const row = btn.closest('tr');
const prevRow = row.previousElementSibling;
if (prevRow) {
  const id = row.dataset.id;
  const newPosition = parseInt(prevRow.querySelector('td:first-child').textContent);
  updateOrder(id, newPosition);
}
}

function moveDown(btn) {
const row = btn.closest('tr');
const nextRow = row.nextElementSibling;
if (nextRow) {
  const id = row.dataset.id;
  const newPosition = parseInt(nextRow.querySelector('td:first-child').textContent);
  updateOrder(id, newPosition);
}
}

function updateOrder(id, newPosition) {
htmx.ajax('POST', 'update_order.cfm', {
  target: '#itemListContainer',
  swap: 'innerHTML',
  values: { id: id, newPosition: newPosition }
});
}

document.body.addEventListener('htmx:afterSwap', function(evt) {
initSortable();
updateButtonStates();
});

// Initial call to set button states
updateButtonStates();
</script>

</body>
</html>