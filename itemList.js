// itemList.js
document.addEventListener('DOMContentLoaded', function() {
  initializeItemList();
});

function initializeItemList() {
  initSortable();
  updateButtonStates();
  setupEventListeners();
}

let sortable;

function initSortable() {
  if (sortable) {
      sortable.destroy();
  }
  const itemList = document.getElementById('itemList');
  if (itemList) {
      sortable = new Sortable(itemList, {
          animation: 150,
          handle: '.drag-handle',
          onEnd: function (evt) {
              const item = evt.item;
              const newIndex = evt.newIndex;
              updateOrder(item.dataset.id, newIndex + 1);
          }
      });
  }
}

function updateButtonStates() {
  const rows = document.querySelectorAll('#itemList tr');
  rows.forEach((row, index) => {
      const upButton = row.querySelector('.move-up');
      const downButton = row.querySelector('.move-down');
      
      if (upButton) upButton.disabled = (index === 0);
      if (downButton) downButton.disabled = (index === rows.length - 1);
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

function setupEventListeners() {
  document.body.addEventListener('htmx:configRequest', (event) => {
      event.detail.headers['X-Requested-With'] = 'XMLHttpRequest';
  });

  document.body.addEventListener('htmx:afterSwap', function(evt) {
      initializeItemList();
  });
}