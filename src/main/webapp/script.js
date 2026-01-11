const editbtn = document.querySelector('.btn-save');
// --- 1. GET ALL ELEMENTS FIRST (Organized) ---
const signUpBtn = document.getElementById("signup-button");
const loginBtn = document.getElementById("login-button");
const profileBtn = document.getElementById("profile-button");
const cartBtn = document.getElementById("cart-button");
const logoutBtn = document.getElementById("logout-button");

const mainPage = document.getElementById("main-page");
const loginPage = document.getElementById("login-page");
const signUpPage = document.getElementById("sign-up-page");
const cartPage = document.getElementById("cart-page");
const checkOutPage = document.getElementById("checkout-page");
const profilePage = document.getElementById("profile-page");
const editProfilePage = document.getElementById("edit-profile-page");
const editProfileForm = document.getElementById("edit-profile-form");

const squarePage = document.getElementById("square-page");
const shawlPage = document.getElementById("shawl-page");
const innercapPage = document.getElementById("innercap-page");

// --- 2. AUTH UI LOGIC ---
// Change 'const' to 'var' so we can update it from main.jsp
var isLoggedIn = false; 

function updateAuthUI() {
    if(isLoggedIn){
        signUpBtn.style.display = 'none';
        loginBtn.style.display = 'none';
        profileBtn.style.display = 'inline-block';
        cartBtn.style.display = "inline-block";
        logoutBtn.style.display = 'inline-block';
    } else {
        signUpBtn.style.display = 'inline-block';
        loginBtn.style.display = 'inline-block';
        profileBtn.style.display = 'none';
        logoutBtn.style.display = 'none';
        // cartBtn.style.display = "none"; // Optional
    }
}

// Run it once on load
updateAuthUI();

// --- 3. HELPER FUNCTION: HIDE ALL PAGES ---
// This fixes the "stacking" issue. We call this before showing ANY page.
function hideAllPages() {
    const pages = document.querySelectorAll(".page");
    pages.forEach(page => {
        page.style.display = "none";
    });
}

// --- 4. NAVIGATION FUNCTIONS ---
function showHomePage(){
    hideAllPages();
    mainPage.style.display = "flex";
}

function showCartPage(){
    hideAllPages();
    cartPage.style.display = "flex";
}

function showSignUpPage(){
    hideAllPages();
    signUpPage.style.display = "flex";
}

function showLogInPage(){
    hideAllPages();
    loginPage.style.display = "flex";
}

function showCheckOutPage(){
    hideAllPages();
    checkOutPage.style.display = "flex";
}

function showProfilePage() {
    hideAllPages();
        profilePage.style.display = "flex";
}

function showEditProfilePage() {
    hideAllPages();
        editProfilePage.style.display = "flex";
} 

// 1. Get the elements
const historyLink = document.getElementById("sidebar-history-link");
const historyPage = document.getElementById("order-history-page");

// 2. Define the show function
function showHistoryPage() {
    hideAllPages(); // Helper function we made earlier
    historyPage.style.display = "block"; // Use block or flex depending on your CSS
}

// 3. Add the click listener
if (historyLink) {
    historyLink.addEventListener("click", (event) => {
        event.preventDefault(); // Stop the link from jumping
        showHistoryPage();
    });
}

// --- 5. EVENT LISTENERS (Buttons) ---

const homeBtn = document.getElementById("home-button");
homeBtn.addEventListener("click", showHomePage);

const contactBtn = document.getElementById("contact-button");
// contactBtn.addEventListener("click", ... ); // Add if you have a contact page

cartBtn.addEventListener("click", showCartPage);

signUpBtn.addEventListener("click", showSignUpPage);

loginBtn.addEventListener("click", showLogInPage);

profileBtn.addEventListener("click", showProfilePage);

editbtn.addEventListener("click", showEditProfilePage);


const proceedCheckOutBtn = document.getElementById("proceed-checkout-button");

// SAFETY CHECK: Only add the listener if the button actually exists!
if (proceedCheckOutBtn) {
    proceedCheckOutBtn.addEventListener("click",() =>{
      showCheckOutPage();
    });
}

const returnMain = document.getElementById("return-shop");
if(returnMain) {
    returnMain.addEventListener("click", showHomePage);
}

// --- 6. CATEGORY BUTTONS (Fixed Logic) ---
const squareBtn = document.getElementById("square-button");
const shawlBtn = document.getElementById("shawl-button");
const innerCapBtn = document.getElementById("innerCap-button");

squareBtn.addEventListener("click",()=>{
  hideAllPages();
  squarePage.style.display = "flex";
});

shawlBtn.addEventListener("click", () =>{
  hideAllPages();
  shawlPage.style.display = "flex";
});

innerCapBtn.addEventListener("click", ()=>{
  hideAllPages();
  innercapPage.style.display = "flex";
});

// --- 7. FORM HANDLERS ---
const loginHover = document.getElementById("login-hover");
if(loginHover) {
    loginHover.addEventListener("click", () => {
        signUpPage.style.display = 'none';
        loginPage.scrollIntoView({ behavior: "smooth" });
        loginPage.style.display = 'flex';
    });
}

const loginForm = document.getElementById("login-form");
if(loginForm) {
    loginForm.addEventListener("submit", function(event){
        const password = document.getElementById("login-password").value;
        if(password.length < 8){
            alert("Password must be at least 8 characters");
            event.preventDefault(); 
        } 
    });
}

const signUpForm = document.getElementById("sign-up-form");
if(signUpForm) {
    signUpForm.addEventListener("submit", function(event){
        const password = document.getElementById("sign-up-password").value;
        if(password.length < 8){
            alert("Password must be at least 8 characters");
            event.preventDefault(); 
        } 
    });
}

const forgetPasswordBtn = document.getElementById("forget-password-login");
if(forgetPasswordBtn) {
    forgetPasswordBtn.addEventListener("click", (event) =>{
        event.preventDefault();
        alert("Forget password page not implemented for this assignment.");
    });
}

if(editProfileForm) {
    editProfileForm.addEventListener("submit", function(event) {
        // If you don't have a servlet yet, prevent refresh for testing:
        // event.preventDefault();

        const newName = document.getElementById("user-name").value;
        if(newName.trim() === "") {
            alert("Username cannot be empty!");
            event.preventDefault();
        } else {
            alert("Profile Updated to: " + newName);
            // After alert, the form will submit to your servlet
        }
    });
}
// --- 8. CART & ALERTS LOGIC ---

// ADD TO CART (Sends to CartServlet)
document.querySelectorAll('.add-to-cart').forEach(button => {
    button.addEventListener('click', function () {
        const product = this.closest('.products');
        
        const id = product.dataset.id;
        const name = product.dataset.name;
        const price = product.dataset.price;

        window.location.href = `cart-action?action=add&id=${id}&name=${encodeURIComponent(name)}&price=${price}`;
    });
});

// CHECK URL PARAMS (Alerts & Auto-Open)
const params = new URLSearchParams(window.location.search);

// 1. ADD TO CART ALERT
if (params.get('status') === 'added') {
    alert("✅ Item successfully added to your cart!");
    window.history.replaceState(null, null, window.location.pathname);
}

// 2. ORDER SUCCESS ALERT
if (params.get('status') === 'success') {
    alert("🎉 Order Placed Successfully! Thank you for shopping with HijabLuxe.");
    window.history.replaceState(null, null, window.location.pathname);
    showHomePage();
}

// 3. AUTO-OPEN CART
if (params.get('view') === 'cart') {
    showCartPage();
}

// 4. SIGN UP SUCCESS -> AUTO OPEN LOGIN + PRE-FILL EMAIL
if (params.get('status') === 'registered') {
    alert("✅ Account created successfully! Please Login.");
    
    // Auto-switch to Login Page
    showLogInPage();
    
    // CHECK: Is there an email in the URL?
    const registeredEmail = params.get('email');
    if (registeredEmail) {
        // Find the login box and fill it
        const emailInput = document.getElementById("login-email");
        if (emailInput) {
            emailInput.value = registeredEmail;
        }
    }
    
    // Clean the URL (remove status AND email so it looks clean)
    window.history.replaceState(null, null, window.location.pathname);
}

// --- FINAL FOOTER & NAVIGATION FIX ---
document.addEventListener("DOMContentLoaded", function() {
    
    // Default: Show main page if no specific view is requested
    if (!params.has('view') && !params.has('status')) {
        hideAllPages();
        document.getElementById('main-page').style.display = 'block';
    }

    // Attach Footer Links (Cleaned Up Version)
    document.querySelectorAll('.footer-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault(); // Stop jump to top
            
            const target = this.getAttribute('data-target');

            // Map data-target to your existing functions
            if (target === 'profile-page') showProfilePage();
            else if (target === 'login-page') showLogInPage();
            else if (target === 'cart-page') showCartPage();
            else if (target === 'main-page') showHomePage();
            
            // Scroll to top smoothly
            window.scrollTo(0, 0);
        });
    });
});

// --- PROFILE UPDATE ALERT ---
// We use the existing 'params' variable here (don't create 'new' one again)

if (params.get('status') === 'updated') {
    alert("✅ Profile updated successfully!");

    // This cleans the URL so the alert doesn't pop up again on refresh
    window.history.replaceState(null, null, window.location.pathname);

    // Ensure we are looking at the profile page
    showProfilePage();
}