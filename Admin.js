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

    // 4. Set default page on load
    switchPage('dashboard'); 
});