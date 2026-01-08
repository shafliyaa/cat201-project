<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
    if (contextPath == null || contextPath.isEmpty()) {
        contextPath = "";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HijabLuxe Admin - Elegant Management</title>
    <link rel="stylesheet" href="AdminStyle.css">
</head>
<body>

    <header id="header-part">
        <h1>Welcome To Admin Page</h1>
        <div class="header-tools">
        </div>
    </header>

    <div id="admin-container">
        <nav id="sidebar">
            <h1 id="ShopName">HijabLuxe</h1>
            <div class="menu-list">
                <a href="#" class="menu-item">📊 Dashboard</a>
                <a href="#" class="menu-item">🛍️ Products</a>
                <a href="#" class="menu-item">➕ Add Product</a>
                <a href="#" class="menu-item">📦 Orders</a>
                <a href="#" class="menu-item">👥 Customers</a>
                <a href="#" class="menu-item">Log Out</a>
            </div>
        </nav>

        <main id="main-content">
            <header id="content-header">
                <div class="breadcrumb-area">
                    <h1>Admin Control Center</h1>
                    <p>Full system overview for HijabLuxe.</p>
                </div>
            </header>

            <section id="dashboard" class="admin-block">
                <div class="brand-story-compact">
                    <div class="story-card">
                        <h2>Our Vision</h2>
                        <p>"To be the global benchmark for elegant coverage, where every woman feels empowered, confident, and beautiful in her identity."</p>
                    </div>
                    <div class="story-card">
                        <h2>Our Mission</h2>
                        <p>"To provide high-quality hijabs that blend traditional values with contemporary style, ensuring comfort and grace."</p>
                    </div>
                </div>

                <h2 class="block-title">📊 Performance Overview</h2>
                <div class="card-container">
                    <div class="stat-card">
                        <h3>Total Revenue</h3>
                        <p class="stat-value">$12,450.00</p>
                        <span class="trend up">+12%</span>
                    </div>
                    <div class="stat-card">
                        <h3>Pending Orders</h3>
                        <p class="stat-value">24</p>
                    </div>
                    <div class="stat-card">
                        <h3>Total Customers</h3>
                        <p class="stat-value">1,205</p>
                    </div>
                </div>
            </section>

            <section id="products" class="admin-block">
                <h2 class="block-title">🛍️ Product Inventory</h2>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Stock Status</th>
                            </tr>
                        </thead>
                        <tbody id="product-table-body">
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="add-product" class="admin-block">
                <h2 class="block-title">➕ Add New Product</h2>
                <form id="product-form" class="admin-form">
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" id="p-name" placeholder="e.g. Premium Silk Shawl" required>
                    </div>
                    <div class="form-row" style="display: flex; gap: 15px;">
                        <div class="form-group" style="flex: 1;">
                            <label>Category</label>
                            <select id="p-category" style="width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ddd;">
                                <option>Square</option>
                                <option>Shawl</option>
                                <option>Inner Cap</option>
                            </select>
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <label>Price ($)</label>
                            <input type="number" id="p-price" placeholder="80.00" step="0.01" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Stock Quantity</label>
                        <input type="number" id="p-stock" placeholder="50" required>
                    </div>
                    <div class="form-group">
                        <label>model.Product Image URL</label>
                        <input type="text" id="p-image" placeholder="https://image-link.com/photo.jpg">
                    </div>
                    <div class="form-actions" style="margin-top: 20px;">
                        <button type="submit" class="btn-success" style="background-color: #28a745; color: white; padding: 10px 25px; border: none; border-radius: 6px; cursor: pointer; font-weight: bold;">Save
                            Product</button>
                        <button type="reset" class="btn-secondary" style="padding: 10px 25px; border: none; border-radius: 6px; cursor: pointer;">Clear Form</button>
                    </div>
                </form>
            </section>

            <section id="orders" class="admin-block">
                <h2 class="block-title">📦 Recent Orders</h2>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#HL-1109</td>
                                <td>Siti Aminah</td>
                                <td>$89.00</td>
                                <td><span class="status-badge processing">Processing</span></td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>#HL-1108</td>
                                <td>Syarifah Asri</td>
                                <td>$70.00</td>
                                <td><span class="status-badge processing">Processing</span></td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>#HL-1107</td>
                                <td>Nurul Safwan</td>
                                <td>$77.00</td>
                                <td><span class="status-badge processing">Processing</span></td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>#HL-1106</td>
                                <td>Aqilah Azwan</td>
                                <td>$40.00</td>
                                <td><span class="status-badge processing">Processing</span></td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>#HL-1105</td>
                                <td>Safwah Mohd</td>
                                <td>$55.00</td>
                                <td><span class="status-badge processing">Processing</span></td>
                            </tr>
                        </tbody>
                         <tbody>
                            <tr>
                                <td>#HL-1104</td>
                                <td>Puteri Sahimi</td>
                                <td>67.00</td>
                                <td><span class="status-badge processing">Processing</span></td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>#HL-1103</td>
                                <td>Arinah Sulaiman</td>
                                <td>58.00</td>
                                <td><span class="status-badge processing">Completed</span></td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>#HL-1102</td>
                                <td>Shafiqa haikal</td>
                                <td>88.00</td>
                                <td><span class="status-badge processing">Completed</span></td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>#HL-1101</td>
                                <td>siti mohd</td>
                                <td>99.00</td>
                                <td><span class="status-badge processing">Completed</span></td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>#HL-1100</td>
                                <td>haida nasir</td>
                                <td>95.00</td>
                                <td><span class="status-badge processing">Completed</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="customers" class="admin-block">
                <h2 class="block-title">👥 Customer Database</h2>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Total Spent</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Syarifah Asri</td>
                                <td>syarifah@email.com</td>
                                <td>$450.00</td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>Nurul Safwan</td>
                                <td>nurul@email.com</td>
                                <td>$50.00</td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>Aqilah Azwan</td>
                                <td>aqilah@email.com</td>
                                <td>$250.00</td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>Safwah Mohd</td>
                                <td>safwah@email.com</td>
                                <td>$70.00</td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>Puteri Sahimi</td>
                                <td>puteri@email.com</td>
                                <td>$500.00</td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>Arinah Sulaiman</td>
                                <td>arinah@email.com</td>
                                <td>$79.00</td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>Shafiqa haikal</td>
                                <td>shafiqa@email.com</td>
                                <td>$380.00</td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>siti mohd</td>
                                <td>siti@email.com</td>
                                <td>$600.00</td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr>
                                <td>haida nasir</td>
                                <td>haida@email.com</td>
                                <td>$390.00</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="logout-section" class="admin-block">
                <div class="logout-container">
                    <div id="logout-confirm-view">
                        <span class="logout-icon">🔓</span>
                        <h2>Sign Out</h2>
                        <p>Are you sure you want to end your session?</p>
                        <div class="logout-actions">
                            <button id="confirm-logout-btn" class="btn-danger">Yes, Log Out</button>
                            <button id="cancel-logout-btn" class="btn-secondary">Cancel</button>
                        </div>
                    </div>
                    <div id="logout-success-view" style="display: none;">
                        <span class="logout-icon">✅</span>
                        <h2>Logged Out</h2>
                        <p>You have been successfully logged out.</p>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <footer id="footer-part">
        <div class="footer-column">
            <h2>HijabLuxe Admin</h2>
            <p>© 2025 HijabLuxe Panel</p>
        </div>
        <div class="footer-column">
            <h3>Support</h3>
            <p>Admin Help Desk: hijabluxe.dev@gmail.com</p>
        </div>
        <div class="footer-column">
            <h3>System Info</h3>
            <p>Version: v1.0.4 | Privacy Policy</p>
        </div>
    </footer>

    <script src="Admin.js"></script>
</body>
</html>