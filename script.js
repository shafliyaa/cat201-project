const signUpBtn = document.getElementById("signup-button");
const loginBtn = document.getElementById("login-button");
const profileBtn = document.getElementById("profile-button");
const cartBtn = document.getElementById("cart-button");

const isLoggedIn = true;

if(isLoggedIn){
    signUpBtn.style.display = 'none';
    loginBtn.style.display = 'none';
    profileBtn.style.display = 'inline-block';
    cartBtn.style.display = "inline-block";
}

const mainPage = document.getElementById("main-page");
const loginPage = document.getElementById("login-page");
const signUpPage = document.getElementById("sign-up-page");

const loginHover = document.getElementById("login-hover");


loginHover.addEventListener("click", () => {
    signUpPage.style.display = 'none';
    loginPage.scrollIntoView({ behavior: "smooth" });
    loginPage.style.display = 'flex';
})

const loginForm = document.getElementById("login-form");

loginForm.addEventListener("submit", function(event){
    const password = document.getElementById("login-password").value;

    if(password.length < 8){
        alert("Password must be at least 8 characters");
        event.preventDefault(); // stop submission
    } 
});

const signUpForm = document.getElementById("sign-up-form");

signUpForm.addEventListener("submit", function(event){
    const password = document.getElementById("sign-up-password").value;

    if(password.length < 8){
        alert("Password must be at least 8 characters");
        event.preventDefault(); // stop submission
    } 
});

const forgetPasswordBtn = document.getElementById("forget-password-login");


forgetPasswordBtn.addEventListener("click", (event) =>{
    event.preventDefault();
    alert("Forget password page not implemented for this assignment.");
})


const homeBtn = document.getElementById("home-button");
const contactBtn = document.getElementById("contact-button");
const aboutBtn = document.getElementById("about-button");
//profile button
//about button

const cartPage = document.getElementById("cart-page");

homeBtn.addEventListener("click", ()=>{
    showHomePage();
})

cartBtn.addEventListener("click", ()=>{
    showCartPage();
})

signUpBtn.addEventListener("click",()=>{
  showSignUpPage();
})

loginBtn.addEventListener("click",()=>{
  showLogInPage();
})

function showHomePage(){
    const pages = document.querySelectorAll(".page");
    pages.forEach(page=>{
        page.style.display = "none";
    })

    mainPage.style.display = "flex";
}

function showCartPage(){
    const pages = document.querySelectorAll(".page");
    pages.forEach(page=>{
        page.style.display = "none";
    })

    cartPage.style.display = "flex";
}

function showSignUpPage(){
    const pages = document.querySelectorAll(".page");
    pages.forEach(page=>{
        page.style.display = "none";
    })

    signUpPage.style.display = "flex";
}


function showLogInPage(){
    const pages = document.querySelectorAll(".page");
    pages.forEach(page=>{
        page.style.display = "none";
    })

    loginPage.style.display = "flex";
}

// Load cart from localStorage or empty array
let cart = JSON.parse(localStorage.getItem('cart')) || [];

// Render cart table
function renderCart() {
  const tbody = document.getElementById('cart-items');
  tbody.innerHTML = '';

  let total = 0;

  cart.forEach(item => {
    const subtotal = item.price * item.quantity;
    total += subtotal;

    tbody.innerHTML += `
      <tr>
        <td>${item.name}</td>
        <td>$${item.price.toFixed(2)}</td>
        <td>
          <input type="number" min="1" value="${item.quantity}"
            onchange="updateQuantity('${item.id}', this.value)">
        </td>
        <td>$${subtotal.toFixed(2)}</td>
        <td>
            <button onclick="removeFromCart('${item.id}')">Remove</button>
        </td>
      </tr>
    `;
  });

  updateTotals(total);
}

// Update quantity when input changes
function updateQuantity(id, qty) {
  const item = cart.find(p => p.id === id);
  if (item) {
    item.quantity = Number(qty);
    saveCart();
    renderCart();
  }
}

// Update subtotal and total
function updateTotals(subtotal) {
  document.getElementById('subtotal').textContent = `$${subtotal.toFixed(2)}`;
  document.getElementById('total').textContent = `$${subtotal.toFixed(2)}`;
}

// Save cart to localStorage
function saveCart() {
  localStorage.setItem('cart', JSON.stringify(cart));
}

// Add item to cart
function addToCart(id, name, price) {
  const existing = cart.find(item => item.id === id);
  if (existing) {
    existing.quantity += 1;
  } else {
    cart.push({
      id: id,
      name: name,
      price: price,
      quantity: 1
    });
  }

  saveCart();
  renderCart();
}

// Render cart on page load
renderCart();

// Add event listeners to all add-to-cart buttons
document.querySelectorAll('.add-to-cart').forEach(button => {
  button.addEventListener('click', function () {
    const product = this.closest('.products'); // matches your HTML

    if (!product) return; // safety check

    const id = product.dataset.id;
    const name = product.dataset.name;
    const price = Number(product.dataset.price);

    addToCart(id, name, price);
  });
});

function removeFromCart(id) {
    if (!confirm("Are you sure you want to remove this item?")) return;
    // Filter out the item with this id
    cart = cart.filter(item => item.id !== id);

    // Save updated cart
    saveCart();

    // Re-render table
    renderCart();
}


const returnMain = document.getElementById("return-shop");

returnMain.addEventListener("click",()=>{
    cartPage.style.display = "none";
    mainPage.style.display = "flex";
})

const squareBtn = document.getElementById("square-button");
const shawlBtn = document.getElementById("shawl-button");
const innerCapBtn = document.getElementById("innerCap-button");
const squarePage = document.getElementById("square-page");
const shawlPage = document.getElementById("shawl-page");
const innercapPage = document.getElementById("innercap-page");

squareBtn.addEventListener("click",()=>{
  mainPage.style.display = "none";
  squarePage.style.display = "flex";
})

shawlBtn.addEventListener("click", () =>{
  mainPage.style.display = "none";
  shawlPage.style.display = "flex";
})

innerCapBtn.addEventListener("click", ()=>{
  mainPage.style.display = "none";
  innercapPage.style.display = "flex";
})



const proceedCheckOutBtn = document.getElementById("proceed-checkout-button");
const checkOutPage = document.getElementById("checkout-page");

proceedCheckOutBtn.addEventListener("click",() =>{
  showCheckOutPage();
})

function showCheckOutPage(){
  const pages = document.querySelectorAll(".page");

  pages.forEach(page=>{
    page.style.display ="none";
  })

  checkOutPage.style.display = "flex";

}


const profilePage = document.getElementById("profile-page");

// Link the profile button to the function
profileBtn.addEventListener("click", () => {
    showProfilePage();
});

function showProfilePage() {
    const pages = document.querySelectorAll(".page");
    
    // Hide all other pages
    pages.forEach(page => {
        page.style.display = "none";
    });

    // Show the profile page
    profilePage.style.display = "flex"; 
}

//Function untuk connect dengan java
async function fetchProductsFromJava() {
    try {
        const response = await fetch('get-products'); // Calls the @WebServlet address
        const products = await response.json();

        const container = document.getElementById("product-display-area");
        container.innerHTML = ""; // Clear existing

        products.forEach(item => {
            container.innerHTML += `
                <div class="product-card">
                    <h3>${item.name}</h3>
                    <p>Price: $${item.price.toFixed(2)}</p>
                    <button onclick="addToCart('${item.id}', '${item.name}', ${item.price})">
                        Add to Cart
                    </button>
                </div>
            `;
        });
    } catch (err) {
        console.error("Error connecting to Java:", err);
    }
}