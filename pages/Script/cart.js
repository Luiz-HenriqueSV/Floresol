
let cart = JSON.parse(localStorage.getItem('shoppingCart')) || [];


const cartIcon = document.getElementById('cart-icon');


const FRETE_VALOR = 20.00; 


function formatPrice(price) {
    return price.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
}


function saveCart() {
    localStorage.setItem('shoppingCart', JSON.stringify(cart));
    updateCartIcon();
    
    if (document.getElementById('cart-table-body')) {
        renderCart();
    }
}

function updateCartIcon() {
    const totalItems = cart.reduce((total, item) => total + item.quantity, 0);
    if (cartIcon) {
        
        cartIcon.textContent = `🛒 Carrinho (${totalItems})`;
    }
}


function addItemToCart(product) {

    const existingItem = cart.find(item => item.id === product.id);

    if (existingItem) {
        
        existingItem.quantity += product.quantity;
    } else {
        
        product.quantity = 1; 
        cart.push(product);
    }

    saveCart();
}


function removeItemFromCart(id) {
    cart = cart.filter(item => item.id !== id);
    saveCart();
}

function updateQuantity(id, newQuantity) {
    const item = cart.find(item => item.id === id);
    if (item) {
        if (newQuantity <= 0) {
            removeItemFromCart(id);
        } else {
            item.quantity = newQuantity;
            saveCart();
        }
    }
}


function calculateCartTotals() {
    const subtotal = cart.reduce((total, item) => total + (item.price * item.quantity), 0);
    const total = subtotal + FRETE_VALOR;
    
    document.getElementById('summary-subtotal').textContent = formatPrice(subtotal);
    document.getElementById('summary-frete').textContent = formatPrice(FRETE_VALOR);
    document.getElementById('summary-total').textContent = formatPrice(total);
}

function renderCart() {
    const cartBody = document.getElementById('cart-table-body');
    if (!cartBody) return; 

    cartBody.innerHTML = ''; 

    if (cart.length === 0) {
        cartBody.innerHTML = '<tr><td colspan="4">Seu carrinho está vazio.</td></tr>';
        
        document.getElementById('summary-subtotal').textContent = formatPrice(0);
        document.getElementById('summary-frete').textContent = formatPrice(FRETE_VALOR);
        document.getElementById('summary-total').textContent = formatPrice(FRETE_VALOR); 
        return;
    }

    cart.forEach(item => {
        const itemSubtotal = item.price * item.quantity;
        
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>
                ${item.name}
                <br>
                <a href="#" class="remove-link" onclick="removeItemFromCart('${item.id}'); return false;">Remover</a>
            </td>
            <td>${formatPrice(item.price)}</td>
            <td>
                <input type="number" 
                       value="${item.quantity}" 
                       min="1" 
                       style="width: 50px; text-align: center;"
                       onchange="updateQuantity('${item.id}', parseInt(this.value))">
            </td>
            <td>${formatPrice(itemSubtotal)}</td>
        `;
        cartBody.appendChild(row);
    });
    
    calculateCartTotals();
}

// Inicialização: Garante que o ícone e a renderização (se na página do carrinho) ocorram ao carregar
document.addEventListener('DOMContentLoaded', () => {
    updateCartIcon();
    // Renderiza a lista de itens APENAS se estivermos na página do carrinho
    if (document.getElementById('cart-table-body')) {
        renderCart();
    }
});