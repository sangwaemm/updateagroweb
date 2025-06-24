document.addEventListener('DOMContentLoaded', function() {

    // --- Logic for the "Sell Product" Modal ---
    const modal = document.getElementById('sell-modal');
    const openModalBtn = document.getElementById('open-sell-modal-btn');
    const closeModalBtn = document.querySelector('.close-btn');

    // When the user clicks the "Sell Product" button, open the modal
    openModalBtn.onclick = function() {
        modal.style.display = 'block';
    }

    // When the user clicks on <span> (x), close the modal
    closeModalBtn.onclick = function() {
        modal.style.display = 'none';
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }

    // --- Logic for the "Contact Seller" Buttons ---
    const productGrid = document.getElementById('product-market');

    productGrid.addEventListener('click', function(event) {
        // Stop the click from bubbling up to the card's onclick event
        event.stopPropagation();

        const contactBtn = event.target.closest('.contact-seller-btn');
        if (contactBtn) {
            // Find the sibling contact-options div and toggle its 'show' class
            const options = contactBtn.nextElementSibling;
            if (options && options.classList.contains('contact-options')) {
                // Close any other open contact options first
                document.querySelectorAll('.contact-options.show').forEach(openOption => {
                    if (openOption !== options) {
                        openOption.classList.remove('show');
                    }
                });
                // Then toggle the one that was clicked
                options.classList.toggle('show');
            }
        }
    });
    
    // Close contact options if clicking anywhere else
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.contact-container')) {
            document.querySelectorAll('.contact-options.show').forEach(openOption => {
                openOption.classList.remove('show');
            });
        }
    });
});
