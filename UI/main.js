window.addEventListener('message', function(event) {
  if (event.data.action === 'openCraftingMenu') {
      openCraftingMenu(event.data.items);
  }
});

function openCraftingMenu(items) {
  const craftingMenu = document.getElementById('craftingMenu');
  const craftingItems = document.getElementById('craftingItems');
  
  craftingItems.innerHTML = '';
  items.forEach(item => {
      const listItem = document.createElement('li');
      listItem.innerHTML = `<img src="${item.image}" alt="${item.name}" class="item-image">
                            <span class="item-label">${item.name}</span>
                            <button class="craft-button hidden">Craft</button>`;
      listItem.addEventListener('click', () => selectItem(listItem));
      craftingItems.appendChild(listItem);
  });

  craftingMenu.classList.remove('hidden');
}

function selectItem(listItem) {
  const selected = document.querySelector('#craftingItems li.selected');
  if (selected) {
      selected.classList.remove('selected');
      selected.querySelector('.craft-button').classList.add('hidden');
  }
  listItem.classList.add('selected');
  listItem.querySelector('.craft-button').classList.remove('hidden');
}

document.addEventListener('click', function(event) {
  if (event.target.classList.contains('craft-button')) {
      const listItem = event.target.closest('li');
      const itemName = listItem.querySelector('.item-label').textContent.trim();
      craftItem(itemName, listItem);
  }
});

function craftItem(itemName, listItem) {
  const messageBox = document.getElementById('messageBox');
  fetch(`https://${GetParentResourceName()}/craftItem`, {
      method: 'POST',
      body: JSON.stringify({ item: itemName }),
      headers: {
          'Content-Type': 'application/json'
      }
  }).then(resp => resp.json()).then(resp => {
      if (resp.status === 'ok') {
          messageBox.innerText = 'Crafting';
      } else if (resp.status === 'error') {
          messageBox.innerText = 'You don\'t have the required items to craft';
      }
      messageBox.classList.remove('hidden');
  });
}

function closeCraftingMenu() {
  const craftingMenu = document.getElementById('craftingMenu');
  craftingMenu.classList.add('hidden');
  const messageBox = document.getElementById('messageBox');
  if (messageBox) {
      messageBox.classList.add('hidden');
  }
  fetch(`https://${GetParentResourceName()}/closeUI`, {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json'
      }
  });
}

document.getElementById('closeButton').addEventListener('click', closeCraftingMenu);