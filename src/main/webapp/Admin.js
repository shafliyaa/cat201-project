document.addEventListener('DOMContentLoaded', () => {
    const navLinks = document.querySelectorAll('.menu-item');
    const sections = document.querySelectorAll('.admin-block'); 
    const pageTitle = document.querySelector('.breadcrumb-area h1');

    // 1. Function to switch between "pages"
    function switchPage(targetId) {
        // Hide all admin sections first
        sections.forEach(section => {
            section.style.display = 'none';
        });
        
        // Show the targeted section
        const targetSection = document.getElementById(targetId);
        if (targetSection) {
            targetSection.style.display = 'block';
        }
    }

    // 2. Navigation Click Logic
    navLinks.forEach(link => {
        link.onclick = function(e) { 
            e.preventDefault(); 
            const linkText = this.innerText.toLowerCase();
            let targetId = "";

            // Mapping Button Text to Section IDs
            if (linkText.includes("dashboard")) targetId = "dashboard";
            else if (linkText.includes("products")) targetId = "products";
            else if (linkText.includes("add product")) targetId = "add-product"; 
            else if (linkText.includes("orders")) targetId = "orders";
            else if (linkText.includes("customers")) targetId = "customers";
            // Discount mapping removed
            else if (linkText.includes("log out")) {
                targetId = "logout-section";
                // Reset Logout View State
                document.getElementById("logout-confirm-view").style.display = "block";
                document.getElementById("logout-success-view").style.display = "none";
            }

            if (targetId) {
                switchPage(targetId);
                // Update the Header Title
                pageTitle.innerText = this.innerText.trim(); 
            }
        };
    });

    // 3. Logout Page Logic
    const confirmBtn = document.getElementById("confirm-logout-btn");
    const cancelBtn = document.getElementById("cancel-logout-btn");

    if (confirmBtn) {
        confirmBtn.onclick = () => {
            // Hide confirmation, show success message
            document.getElementById("logout-confirm-view").style.display = "none";
            document.getElementById("logout-success-view").style.display = "block";
        };
    }

    if (cancelBtn) {
        cancelBtn.onclick = () => {
            switchPage('dashboard');
            pageTitle.innerText = "📊 Dashboard";
        };
    }

    // 4. Add Product form submit
    // 4. Add Product form submit
    const productForm = document.getElementById("product-form");
    if (productForm) {
        productForm.addEventListener("submit", function (e) {
            e.preventDefault();

            const formData = new URLSearchParams({
                name: document.getElementById("p-name").value,
                category: document.getElementById("p-category").value,
                price: document.getElementById("p-price").value,
                stock: document.getElementById("p-stock").value,
                image: document.getElementById("p-image").value
            });

            // Use relative path
            fetch("products", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: formData
            })
                .then(res => {
                    if (!res.ok) {
                        return res.text().then(text => {
                            throw new Error(text || "Server error");
                        });
                    }
                    return res.json().catch(() => {
                        // Fallback if the response is not valid JSON but success (unlikely but safe)
                        return {};
                    });
                })
                .then(data => {
                    if(data.status && data.status === 'error') {
                        throw new Error(data.message);
                    }
                    alert("Product saved successfully!");
                    document.getElementById("product-form").reset();
                    loadProducts();
                    switchPage("products");
                })
                .catch(err => {
                    console.error("Error:", err);
                    alert("Error saving product: " + err.message);
                });
        });
    }

    // 5. Set default page on load
    switchPage('dashboard');
    loadProducts();

    //6.
    // 6. Load products
    function loadProducts() {
        fetch("products") // This calls our Servlet's doGet
            .then(res => res.json())
            .then(products => {
                const tbody = document.getElementById("product-table-body");
                tbody.innerHTML = ""; // Clear old data

                products.forEach(p => {
                    tbody.innerHTML += `
                    <tr>
                        <td>${p.name}</td>
                        <td>${p.category}</td>
                        <td>$${p.price.toFixed(2)}</td>
                        <td>In Stock (${p.stock})</td>
                    </tr>
                `;
                });
            });
    }

});