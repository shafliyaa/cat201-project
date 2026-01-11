<%@ page import="com.example.hijabluxe.Cart" %>
<%@ page import="com.example.hijabluxe.Product" %>
<%@ page import="com.example.hijabluxe.ProductService" %>
<%@ page import="com.example.hijabluxe.User" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>     
<%@ page import="java.util.ArrayList" %>

<%
    // --- FETCH PRODUCTS (Make sure this is OUTSIDE any if-blocks) ---
    List<Product> allProducts = ProductService.getInstance().getAllProducts();
    List<Product> displayList = new ArrayList<>(allProducts);
    java.util.Collections.reverse(displayList);
    int max = Math.min(displayList.size(), 3); // Define 'max' here!

    // --- 0. HANDLE LOGOUT (Must be first!) ---
    String action = request.getParameter("action");
    if("logout".equals(action)) {
        session.invalidate(); 
        response.sendRedirect("main.jsp"); 
        return; 
    }

    // --- 1. GET DATA FROM FORMS ---
    String loginEmail = request.getParameter("login_email");
    String loginPassword = request.getParameter("login_password");
    
    String signupName = request.getParameter("signup_name");
    String signupEmail = request.getParameter("signup_email");
    String signupPassword = request.getParameter("signup_password");

    // --- SETUP THE "MOCK DATABASE" (First time only) ---
    Map<String, String[]> userDB = (Map<String, String[]>) application.getAttribute("userDB");
    if(userDB == null) {
        userDB = new HashMap<>();
        application.setAttribute("userDB", userDB);
    }

    // --- 2. HANDLE SIGN UP ---
    if(signupName != null && signupEmail != null && signupPassword != null) {
        String[] newUser = { signupName, signupPassword };
        userDB.put(signupEmail, newUser);
    }

    // --- 3. HANDLE LOGIN ---
    String loginMessage = ""; 
    String currentUserName = (String) session.getAttribute("currentUserName");

    if(loginEmail != null && loginPassword != null) {
        String[] foundUser = userDB.get(loginEmail);

        if(foundUser != null && foundUser[1].equals(loginPassword)) {
            String storedName = foundUser[0];
            User loggedInUser = new User(storedName, loginEmail, foundUser[1], "", "");
            session.setAttribute("currentUser", loggedInUser);
            session.setAttribute("isLoggedIn", "true");
            loginMessage = "Login Successful! Welcome back, " + storedName;
        } else {
            loginMessage = "Error: Wrong email or password (or user not found).";
        }
    }
%>
<!DOCTYPE html> 
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HijabLuxe - The Art of Elegant Coverage</title>
        <link rel="stylesheet" href="styles.css">
    </head>


    <body>
        <div id="desktop-view">
            <!-- banner-->
            <div id="header-part">
                <p>Summer Sale For All Square Premium Set A - OFF 50%!</p>
                <a href="#new-arrival">ShopNow</a>
            </div>
            <!-- header-->
            <div id="nav-bar">
                <h1 id="ShopName">HijabLuxe</h1>
                <div id="nav-bar-button">
                    <button id="home-button">Home</button>
                    <a href="#footer-part" id="contact-button">Contact</a>
                    <button id="signup-button">Sign Up</button>
                    <button id="login-button">Log In</button>
                    <button id="profile-button">Profile</button>
                    <button id="cart-button">Cart</button>
                    <a href="main.jsp?action=logout" id ="logout-button" style="text-decoration: none; color: rgb(171, 31, 31); padding: 8px 16px">Log Out</a>
                </div>
            </div>

            <div class="line"></div>

            <!-- login page-->
            <div id="login-page" class="page">
                    <img src="image/login-image.png" class="login-image">
                    <div id="login-info"> 
                        <h1>Log in to HijabLuxe</h1>
                        <p>Enter your details below</p>
                            <form id="login-form" method="post" action="main.jsp">
                                <input type="email" id="login-email" name="login_email" placeholder="Email" required>
                                <input type="password" id="login-password" name="login_password" placeholder="Password" required>
                                <input type="submit" value="Log In" id="login-page-button"> 
                                <button id="forget-password-login">Forget Password?</button>
                            </form>

                            <% if(loginMessage != null && !loginMessage.isEmpty()) { %>
                                <div style="padding: 10px; margin: 10px 0; border-radius: 5px; 
                                    background-color: <%= loginMessage.contains("Error") ? "#f8d7da" : "#d4edda" %>; 
                                    color: <%= loginMessage.contains("Error") ? "#721c24" : "#155724" %>;">
                                    
                                    <%= loginMessage %>
                                </div>
                            <% } %>
                    </div>
            </div>

            <!-- Sign Up Page -->
            <div id="sign-up-page" class="page">
                <img src="image/login-image.png" class="login-image">
                <div id="sign-up-info">
                    <h1>Create an Account</h1>
                    <p>Enter your details below</p>
                        <form id="sign-up-form" method="post" action="main.jsp">
                            <input type="text" id="sign-up-name" name="signup_name" placeholder="Name" required>
                            <input type="email" id="sign-up-email" name="signup_email" placeholder="Email" required>
                            <input type="password" id="sign-up-password" name="signup_password" placeholder="Password" required>
                            <div id="create-button">
                                <input type="submit" id="create-account-button" value="Create Account">
                                <p>or</p>
                                <button id="google-button"><img src="image/Icon-Google.png">Sign up with Google</button>
                            </div> 
                        </form>

                        <% if(signupName != null && signupEmail != null && signupPassword != null) { %>
                            <div style="background-color: #d1ecf1; padding: 10px; margin: 10px 0;">
                                Account Created for: <%= signupName %> (<%= signupEmail %>)
                            </div>
                        <% } %>
                    <div id="sign-up-bottom">
                        <p>Already have account?</p>
                        <button id="login-hover">Log In</button>                    
                    </div>
                </div>
            </div>

            <!-- Main Page -->

            <div id="main-page" class="page">
                <!-- HERO SECTION NEW -->
                <div style="text-align: center; padding: 60px 0 30px 0;">
                    <h1 style="font-size: 52px; color: #2C3E50; margin: 0;">
                        Discover Elegant <span style="color: #8F4E68;">Hijabs</span>
                    </h1>
                    <p style="color: #7D7D7D; font-size: 18px; margin-top: 10px;">Premium quality hijabs for every occasion</p>
                </div>
                <div id="main-page-header" >
                    <div id="main-page-button">
                        
                        <button id="square-button"><span>Square</span></button>
                        <button id="shawl-button"><span>Shawl</span></button>
                        <button id="innerCap-button"><span>Inner Cap</span></button>
                    </div>

                    <div>
                        <img src="image/main-page.webp" id="main-page-1">

                    </div>
                </div>

            
                <!-- New Arrival Section -->
                <div id="new-arrival">
                    <h2 style="color: #2C3E50; text-align: center; font-size: 28px;">New Arrival</h2>
                    <div id="new-arrival-content">
                        <%
                            // The logic: Start at 0, go until max, increase by 1
                            for (int i = 0; i < max; i++) {
                                Product p = displayList.get(i);
                                String imgPath = (p.getImage() == null || p.getImage().isEmpty())
                                        ? "image/default-product.webp"
                                        : p.getImage();
                        %>
                        <div class="products"
                                data-id="<%= p.getId() %>"
                                data-name="<%= p.getName() %>"
                                data-price="<%= p.getPrice() %>">

                            <img src="<%= imgPath %>" class="pic">
                            <p><%= p.getName() %></p>
                            <p>$<%= String.format("%.2f", p.getPrice()) %></p>
                            <img class="star" src="image/Five%20star.png">
                            <button class="add-to-cart">Add To Cart</button>
                        </div>
                        <% } %>
                    </div>
                </div>
                <div id="popular-now">
                    <h3 class="title">Popular Now</h3>
                    <div id="popular-content">
                        <div class="products" data-id="4" data-name="square Brown Husk" data-price="30">
                            <img src="image/brown%20husk.webp" id="brown-husk" class="pic">
                            <p>Square Brown Husk</p>
                            <p>$30</p>
                            <img class="star" src="image/Five%20star.png">
                            <button class="add-to-cart">Add To Cart</button>
                        </div>
                        <div class="products" data-id="5" data-name="square White Sulam" data-price="109">
                            <img src="image/WHITE%20PANCAR%20BACK.webp" id="white-pancar" class="pic">
                            <p>Square White Sulam</p>
                            <p>$109</p>
                            <img class="star" src="image/Five%20star.png">
                            <button class="add-to-cart">Add To Cart</button>
                        </div>
                        <div class="products" data-id="6" data-name="shawl Ikatan Lite" data-price="299">
                            <img src="image/TudungPeople-Ikatan-Lite-03.webp" id="ikatan-style" class="pic">
                            <p>Shawl Ikatan Lite</p>
                            <p>$299</p>
                            <img class="star" src="image/Four%20Half%20Star.png">
                            <button class="add-to-cart">Add To Cart</button>
                        </div>
                    </div>   
                </div>
                <div id="main-bottom">
                    <div class="bottom-services">
                        <img src="image/Services.png" id="delivery-pic">
                        <h3>FREE AND FAST DELIVERY</h3>
                        <p>Free Delivery For Order Above $140</p>
                    </div>
                    <div class="bottom-services">
                        <img src="image/Services%20(1).png" id="customer-pic">
                        <h3>24/7 CUSTOMER SERVICES</h3>
                        <p>Friendly 24/7 Customer Services</p>
                    </div>
                    <div class="bottom-services">
                        <img src="image/Services%20(2).png" id="moneyback-pic">
                        <h3>MONEY BACK GUARANTEE</h3>
                        <p>We Return Money Within 30 Days</p>
                    </div>
                </div>
            </div>

            <div id="square-page" class="page">
                <h1 class="middle-title">Square</h1>
                <div id="square-product">
                    <div class="products" data-id="7" data-name="Bawal Printed Aura" data-price="109">
                        <img src="image/bawal-1.webp" id="bawal-1" class="pic">
                        <p>Bawal Printed Aura</p>
                        <p>$109</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>class=
                    </div>
                    <div class="products" data-id="8" data-name="Bawal Printed Pastel" data-price="130">
                        <img src="image/bawal-2.webp" id="bawal-2" class="pic">
                        <p>Bawal Printed Pastel</p>
                        <p>$130</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="9" data-name="Bawal Printed Premium Aura" data-price="209">
                        <img src="image/bawal-3.webp" id="bawal-3" class="pic">
                        <p>Bawal Printed Premium Aura</p>
                        <p>$209</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="10" data-name="Bawal Plain Premium Aura" data-price="140">
                        <img src="image/bawal-4.jpg" id="bawal-4" class="pic">
                        <p>Bawal Plain Premium Aura</p>
                        <p>$140</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="11" data-name="Bawal Printed Premium Lite" data-price="150">
                        <img src="image/bawal-5.webp" id="bawal-5" class="pic">
                        <p>Bawal Printed Premium Lite</p>
                        <p>$150</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                </div>
            </div>

               <div id="shawl-page" class="page">
                <h1 class="middle-title">Shawl</h1>
                <div id="shawl-product">
                    <div class="products" data-id="12" data-name="Shawl Plain Premium Red" data-price="80">
                        <img src="image/shawl-1.webp" id="shawl-1" class="pic">
                        <p>Shawl Plain Premium Red</p>
                        <p>$80</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="13" data-name="Shawl Plain Premium Grey" data-price="80">
                        <img src="image/shawl-2.webp" id="shawl-2" class="pic">
                        <p>Shawl Plain Premium Grey</p>
                        <p>$80</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="14" data-name="Shawl Printed Premium Aura" data-price="203">
                        <img src="image/shawl-3.webp" id="shawl-3" class="pic">
                        <p>Shawl Printed Premium Aura</p>
                        <p>$203</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="15" data-name="Shawl Printed Premium Meddin" data-price="200">
                        <img src="image/shawl-4.webp" id="shawl-4" class="pic">
                        <p>Shawl Printed Premium Meddin</p>
                        <p>$200</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="16" data-name="Shawl Printed Premium K" data-price="209">
                        <img src="image/shawl-5.webp" id="shawl-5" class="pic">
                        <p>Shawl Printed Premium K</p>
                        <p>$209</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                </div>
            </div>

            <div id="innercap-page" class="page">
                <h1 class="middle-title">InnerCap</h1>
                <div id="innercap-product">
                    <div class="products" data-id="17" data-name="Inner Cap Black" data-price="15">
                        <img src="image/innercap-1.jpg" id="innercap-1" class="pic">
                        <p>Inner Cap Black</p>
                        <p>$15</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="18" data-name="Inner Cap Peach" data-price="35">
                        <img src="image/innercap-2.webp" id="innercap-2" class="pic">
                        <p>Inner Cap Peach</p>
                        <p>$35</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="19" data-name="Inner Ninja Premium" data-price="29">
                        <img src="image/innercap-3.webp" id="innercap-3" class="pic">
                        <p>Inner Ninja Premium</p>
                        <p>$29</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                    <div class="products" data-id="20" data-name="Inner Necktie" data-price="20">
                        <img src="image/innercap-4.webp" id="shawl-4" class="pic">
                        <p>Inner Necktie</p>
                        <p>$20</p>
                        <img class="star" src="image/Five%20star.png">
                        <button class="add-to-cart">Add To Cart</button>
                    </div>
                </div>
            </div>

    <div id="cart-page" class="page">
        <h3 id="home-cart">Cart</h3>
        <div id="cart">
        <table>
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                    <th>Action</th> </tr>
            </thead>
            <tbody id="cart-items">
                <%
                    Cart pageCart = (Cart) session.getAttribute("cart");
                    
                    if(pageCart != null && pageCart.getItems() != null && !pageCart.getItems().isEmpty()) {
                        for(Product p : pageCart.getItems()) {
                %>
                <tr>
                    <td><%= p.getName() %></td>
                    <td>RM <%= String.format("%.2f", p.getPrice()) %></td>
                    <td>1</td>
                    <td>RM <%= String.format("%.2f", p.getPrice()) %></td>
                    
                    <td>
                        <a href="cart-action?action=remove&id=<%= p.getId() %>" 
                        style=" text-decoration: none; color: white; background-color: #DB4444; padding: 5px 10px; border-radius: 5px;">
                        Remove
                        </a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" style="text-align: center; padding: 20px; color: #666;">
                        Your cart is currently empty.
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <div id="return-button">
        <button id="return-shop">Return To Shop</button>
    </div>

    <%-- 4. CART TOTAL SECTION --%>
    <div id="cart-bottom">
        <div id="cart-total-section">
            <h3>Cart Total</h3>
            
            <%
                // Calculate total safe string (prevents error if cart is null)
                String displayTotal = "0.00";
                if(pageCart != null) {
                    displayTotal = String.format("%.2f", pageCart.getTotalPrice());
                }
            %>

            <p>Subtotal:</p>
            <p id="cart-subtotal">RM <%= displayTotal %></p>
            
            <p>Total:</p>
            <p id="cart-total">RM <%= displayTotal %></p>
            
            <%-- Only show Checkout Button if cart has items --%>
            <% if(pageCart != null && !pageCart.getItems().isEmpty()) { %>
                <button id="proceed-checkout-button">Proceed to Checkout</button>
            <% } else { %>
                 <button style="background: grey; cursor: not-allowed;" disabled>Cart Empty</button>
            <% } %>
        </div>
    </div>
</div>


<div id="checkout-page" class="page">
    <form method="POST" action="orders">
        <section id="shipping-details">
            <h2>1. Delivery Details</h2>
            
            <fieldset id="contact-info-checkout" style="width: 100%; margin-bottom: 20px;">
                 <legend>Contact Information</legend>
                <input type="email" id="email" name="email" required placeholder="Email Address">
                <input type="tel" id="phone" name="phone" required placeholder="Phone Number" style="margin-top: 15px;">
            </fieldset>

            <fieldset>
                <legend>Shipping Address</legend>
                <input type="text" id="full-name" name="full_name" required placeholder="Full Name">
                <input type="text" id="address-line1" name="address_line1" required placeholder="Street Address">
                <input type="text" id="city" name="city" required placeholder="City">
                
                <select id="State" name="State" required>
                    <option value="">-- Select State --</option>
                    <option value="jhr">Johor</option>
                        <option value="kdh">Kedah</option>
                        <option value="kln">Kelantan</option>
                        <option value="kl">Kuala Lumpur</option>
                        <option value="lab">Labuan</option>
                        <option value="mal">Malacca</option>
                        <option value="ns">Negeri Sembilan</option>
                        <option value="phg">Pahang</option>
                        <option value="png">Penang</option>
                        <option value="prk">Perak</option>
                        <option value="prl">Perlis</option>
                        <option value="pj">Putrajaya</option>
                        <option value="sbh">Sabah</option>
                        <option value="swk">Sarawak</option>
                        <option value="slg">Selangor</option>
                        <option value="trg">Terengganu</option>
                    </select>

                <input type="text" id="postcode" name="postcode" required placeholder="Postcode">
            </fieldset>
        </section>


        <section id="payment-details">
            <h2>2. Payment Method</h2>
            <div style="margin-bottom: 20px; display: flex; gap: 20px;">
                <label><input type="radio" name="payment_method" value="card" checked> Card</label>
                <label><input type="radio" name="payment_method" value="fpx"> FPX</label>
            </div>
            
            <fieldset id="card-info">
                <legend>Card Details</legend>
                <input type="text" id="card-number" name="card_number" placeholder="Card Number">
                <div style="display: flex; gap: 10px;">
                    <input type="text" id="expiry" name="expiry" placeholder="MM/YY">
                    <input type="text" id="cvc" name="cvc" placeholder="CVC">
                </div>
            </fieldset>
        </section>
        
            <div class="summary-section">
                <section id="order-summary">
                    <h2>Your Order</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Item (Qty)</th>
                            <th>Total</th>
                        </tr>
                    </thead>
            
                <tbody>
                    <% 
                        // 1. Get the Cart from the Session
                        Cart checkoutCart = (Cart) session.getAttribute("cart");
                        double checkoutTotal = 0.00;

                        // 2. Check if the cart exists
                        if(checkoutCart != null && checkoutCart.getItems() != null && !checkoutCart.getItems().isEmpty()) {
                            
                            // 3. Calculate the total for the footer
                            checkoutTotal = checkoutCart.getTotalPrice();

                            // 4. Loop through every product to make a Row <tr>
                            for(Product p : checkoutCart.getItems()) {
                    %>
                        <tr>
                            <td><%= p.getName() %> <span style="color: #888; font-size: 0.9em;">(x1)</span></td>
                            <td>RM <%= String.format("%.2f", p.getPrice()) %></td>
                        </tr>
                    <% 
                            } 
                        } else { 
                    %>
                        <tr>
                            <td colspan="2" style="text-align: center; color: red;">No items in cart.</td>
                        </tr>
                    <% 
                        } 
                    %>
                </tbody>

                <tfoot>
                    <tr>
                        <td>Subtotal:</td>
                        <td>RM <%= String.format("%.2f", checkoutTotal) %></td>
                    </tr>
                    <tr style="font-weight: bold; color: #4B0082;">
                        <td>Grand Total:</td>
                        <td>RM <%= String.format("%.2f", checkoutTotal) %></td>
                    </tr>
                </tfoot>
            </table>
                </section>
            </div>
        <button type="submit" id="place-order-btn">Complete Purchase</button>
    </form>

</div>

<div id="order-history-page" class="page">
    <div class="history-container">
        <h1 class="history-title">Order History</h1>

        <%
            // 1. Get the list of orders from the server
            List<String[]> myHistoryList = (List<String[]>) application.getAttribute("orderDB");

            // 2. Check if there are any orders
            if (myHistoryList != null && !myHistoryList.isEmpty()) {
                
                // 3. Loop through them (Backwards so newest is first)
                for (int i = myHistoryList.size() - 1; i >= 0; i--) {
                    String[] order = myHistoryList.get(i);
                    
                    // Extract data (Matches your OrderServlet format)
                    String hName = order[0];
                    String hEmail = order[1];
                    // order[2] is address
                    // order[3] is state
                    // order[4] is payment
                    String hTotal = order[5];
        %>

        <div class="order-card">
            <div class="order-header">
                <div>
                    <p class="label">Order ID</p>
                    <p class="value">#ORD-<%= 1000 + i %></p>
                </div>
                <div>
                    <p class="label">Status</p>
                    <p class="value status-delivered" style="color: #f39c12;">Processing</p>
                </div>
            </div>

            <table class="history-table">
                <thead>
                    <tr>
                        <th>Customer Info</th>
                        <th>Payment Method</th>
                        <th>Grand Total</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <strong><%= hName %></strong><br>
                            <span style="font-size: 12px; color: #777;"><%= hEmail %></span>
                        </td>
                        <td><%= order[4].toUpperCase() %></td>
                        <td><%= hTotal %></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <% 
                } // End Loop
            } else { 
        %>
        
        <div style="text-align: center; padding: 40px; color: #666;">
            <h3>No orders found yet.</h3>
            <p>Go buy something!</p>
        </div>

        <% } %>

        <button id="return-home-btn" onclick="location.href='main.jsp'">Back to Shopping</button>
    </div>
</div>

<div id="profile-page" class="page">
    <div class="profile-layout">
        <aside class="profile-sidebar">
            <nav>
                <div class="sidebar-group">
                    <h3>Manage My Account</h3>
                    <ul>
                        <li><a href="#" class="active-link">My Profile</a></li>
                    </ul>
                </div>
                <div class="sidebar-group">
                    <h3>My Orders</h3>
                    <ul>
                        <li><a href="#" onclick="showPage('order-history-page')">My History</a></li>
                    </ul>
                </div>
            </nav>
        </aside>

        <main class="profile-content">
            <div class="profile-form-card">
                <h2 class="form-title">My Profile</h2>
                <div class="profile-view-details">
                    <%
                        User currentUser = (User) session.getAttribute("currentUser");
                    %>
                    <p>Name: <%= (currentUser != null ? currentUser.getUsername() : "Guest") %></p>
                    <p>Email: <%= (currentUser != null ? currentUser.getEmail() : "-") %></p>
                    <p>Address: <%= (currentUser != null ? currentUser.getAddress() : "-") %></p>
                    <button class="btn-save" onclick="showPage('edit-profile-page')">Edit Profile</button>
                </div>
            </div>
        </main>
    </div>
</div>

<div id="edit-profile-page" class="page">
    <div class="profile-layout">
        <aside class="profile-sidebar">
            <nav>
                <div class="sidebar-group">
                    <h3>Manage My Account</h3>
                    <ul>
                        <li><a href="#" onclick="showPage('profile-page')">Back to Profile</a></li>
                    </ul>
                </div>
            </nav>
        </aside>

        <main class="profile-content">
            <div class="profile-form-card">
                <h2 class="form-title">Edit Your Profile</h2>
                <form id="edit-profile-form">
                    <div class="form-row">
                        <div class="input-group">
                            <label for="user-name">Username</label>
                            <input type="text" id="user-name">
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn-cancel" onclick="showPage('profile-page')">Cancel</button>
                        <button type="submit" class="btn-save">Save Changes</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>

            <div id="footer-part">
                <div>
                    <h2>HijabLuxe</h2>
                    <p>Subscribe</p>
                    <p>Get 10% off your first order</p>
                    <input placeholder="Enter your email">
                        <img>
                    </input>
                </div>
                <div>
                    <h3>Support</h3>
                    <p>123, Jalan Mutiara Indah, 10000, Georgetown, Penang</p>
                    <p>hijabluxe@gmail.com</p>
                    <p>+6012-17890234</p>
                </div>
                <div>
                    <h3>Account</h3>
                    <p><a href="#" class="footer-link" data-target="profile-page">My Account</a></p>
                    <p><a href="#" class="footer-link" data-target="login-page">Login/Register</a></p>
                    <p><a href="#" class="footer-link" data-target="cart-page">Cart</a></p>
                    <p><a href="#" class="footer-link" data-target="main-page">Shop</a></p>
                </div>
                <div>
                    <h3>Quick Link</h3>
                    <p>Privacy Policy</p>
                    <p>Terms of Use</p>
                    <p>FAQ</p>
                    <p>Contact</p>
                </div>
                <div>
                    <h3>Download</h3>
                    <p>Save $4 with App New User Only</p>
                    <img src="image/qr.png">
                    <img src="image/getOnApps.png">
                </div>
            </div>
        </div>
        <script src="script.js"></script>

    <script>
        // --- CONNECT JAVA SESSION TO JAVASCRIPT ---
        <% 
            // Check if our Java session has the "isLoggedIn" flag we set earlier
            if(session.getAttribute("isLoggedIn") != null) { 
        %>
            // If Java says yes, we tell JavaScript to set it to true
            isLoggedIn = true;
            updateAuthUI(); // Call the function we just made in script.js
        <% } %>


        // --- KEEP THE CORRECT TAB OPEN AFTER RELOAD ---
        
        <% if(request.getParameter("signup_email") != null) { %>
            // 1. Show a popup so they know it worked
            alert("Account successfully created! Please log in.");

            // 2. Send them directly to the Login Page
            showLogInPage(); 
            
            // 3. Optional: Pre-fill the email box for them (Bonus UX!)
            document.getElementById("login-email").value = "<%= signupEmail %>";
        <% } %>

        <% if(request.getParameter("login_email") != null) { %>
            <%-- Check if the login message indicates Success --%>
            <% if(loginMessage != null && loginMessage.contains("Success")) { %>
                
                // 1. Login Worked: Go straight to Home Page
                showHomePage();
                
                // 2. Optional: Show a popup so they know it worked
                alert("Login Successful! Welcome back.");

            <% } else { %>
                
                // 3. Login Failed: Stay on Login Page to show the Red Error Box
                showLogInPage();
                
            <% } %>
        <% } %>
    </script>

    </body>
</html>
