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