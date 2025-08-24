// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap.bundle.min"

function loadScript(url, callback) {
  // Create a new script element
  var script = document.createElement('script');

  // Set the script's src attribute to the provided URL
  script.src = url;

  // Optional: Set the async attribute if you want the script to load asynchronously
  script.async = true;

  // Set the onload event handler to call the callback function
  script.onload = function () {
    if (callback) {
      callback();
    }
  };

  // Append the script to the document's head or body
  document.head.appendChild(script);
}

function loadPayPalButtons() {
  console.log('Executing custom function after Turbolinks load');
  var container = document.getElementById('paypal-button-container')
  if (container) {
    loadScript(`https://www.paypal.com/sdk/js?client-id=${window.AppConfig.pp_client}`, () => {
      paypal.Buttons({
        env: container.dataset.paypal_mode, // Valid values are sandbox and live.
        createOrder: async () => {
          // Get the form element
          const form = document.getElementById('new_membership');

          // Create a FormData object from the form
          const formData = new FormData(form);

          // Send a POST request with the form data
          var response = await fetch(form.action, {
            method: 'POST',
            body: formData,
          });

          const responseData = await response.json();
          if (!responseData.token) {
            console.log(`Error: ${responseData.error}`);
          }

          return responseData.token;
        },

        onError: (err) => {
          console.error('PayPal Button Error:', err);
          showPayPalError(err.message);
        },

        onApprove: async (data) => {
          // Catch any exceptions and report errors
          try {
            const response = await fetch('/memberships/capture_order', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json'
              },
              body: JSON.stringify({ order_id: data.orderID })
            });

            const responseData = await response.json();

            if (responseData.status === 'COMPLETED') {
              // Activate paypalSuccess bootstrap modal
              var modal = new bootstrap.Modal(document.getElementById('paypalSuccessModal'));
              modal.show();
              console.log('Payment complete!');
              // Sleep for 2 seconds to allow the message to be displayed
              await new Promise(resolve => setTimeout(resolve, 2000));
              // Redirect to the person edit page
              window.location.href = responseData.redirect;
            }
            else {
              showPayPalError(responseData.error);
            }
          } catch (error) {
            console.error('Error during PayPal order capture:', error);
            showPayPalError(error.message);
            return;
          }
        }
      }).render('#paypal-button-container');

    });
  }
}

function showPayPalError(error_string) {
  console.log(`PayPal capture error: ${error_string}`);
  var errorDiv = document.getElementById('paypalErrors');
  errorDiv.innerHTML = `A PayPal Error Occurred: ${error_string} Please try again later.`;
  // Show paypalErrorModal bootstrap modal
  var modal = new bootstrap.Modal(document.getElementById('paypalErrorModal'));
  modal.show();
}

function loadImageModals() {
  console.log("loading Image Modals...");
  const modalImage = document.querySelector("#lightboxModal img");

  document.querySelectorAll("[data-bs-toggle='modal']").forEach(img => {
    img.addEventListener("click", () => {
      const fullUrl = img.dataset.fullImageUrl;
      console.log(`fullUrl: ${fullUrl}`);
      modalImage.src = fullUrl;
    });
  });
}

function populateJulianDate() {
  document.querySelectorAll(`.julian-generator`).forEach(generator => {
    generator.addEventListener("click", () => {
      var target = document.getElementById(generator.dataset.target);
      var name_source = document.getElementById(generator.dataset.nameSource);
      var name = name_source.value || 'San Jose'
      var initials = name.split(' ').map(word => word[0]?.toUpperCase()).filter(Boolean).join('')
      var id = `${initials}${generator.dataset.jd}`
      console.log(`Generated ID: ${id}`)
      target.value = id
    });
  });
}


document.addEventListener('turbo:load', function () {
  console.log('turbo loaded')
  loadPayPalButtons();
  loadImageModals();
  populateJulianDate();
});