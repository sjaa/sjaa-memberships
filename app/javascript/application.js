// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap.bundle.min"
import "channels"

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
      var first_name_source = document.getElementById(generator.dataset.firstNameSource);
      var last_name_source = document.getElementById(generator.dataset.lastNameSource);
      var name = name_source.value || 'San Jose'
      if(first_name_source.value.trim().length > 0 && last_name_source.value.trim().length > 0) name = `${first_name_source.value.trim()} ${last_name_source.value.trim()}`
      var initials = name.split(' ').map(word => word[0]?.toUpperCase()).filter(Boolean).join('')
      var id = `${initials}${generator.dataset.jd}`
      console.log(`Generated ID: ${id}`)
      target.value = id
    });
  });
}

function loadNotifications(showAll = true) {
  console.log(`Loading ${showAll ? 'all' : 'unread'} notifications...`)

  // Fetch notifications based on showAll flag
  const url = showAll ? '/notifications.json' : '/notifications/unread.json'
  fetch(url, {
    credentials: 'same-origin'
  })
    .then(response => response.json())
    .then(notifications => {
      const dropdown = document.getElementById('notification-dropdown')
      if (!dropdown) return

      if (notifications.length === 0) {
        dropdown.innerHTML = `
          <div class="dropdown-item text-center text-muted py-3">
            <i class="bi bi-inbox"></i>
            <div>No ${showAll ? '' : 'unread '}notifications</div>
          </div>
        `
        return
      }

      dropdown.innerHTML = ''
      notifications.forEach(notification => {
        const item = createNotificationItem(notification)
        dropdown.appendChild(item)
      })
    })
    .catch(error => console.error('Error loading notifications:', error))

  // Fetch unread count
  updateUnreadCount()

  // Set up toggle button (only add listener once)
  const toggleBtn = document.getElementById('toggle-notifications')
  if (toggleBtn && !toggleBtn.dataset.listenerAdded) {
    toggleBtn.dataset.listenerAdded = 'true'
    toggleBtn.addEventListener('click', (e) => {
      e.preventDefault()
      e.stopPropagation()
      toggleNotifications()
    })
  }

  // Set up mark all read button (only add listener once)
  const markAllReadBtn = document.getElementById('mark-all-read')
  if (markAllReadBtn && !markAllReadBtn.dataset.listenerAdded) {
    markAllReadBtn.dataset.listenerAdded = 'true'
    markAllReadBtn.addEventListener('click', (e) => {
      e.preventDefault()
      e.stopPropagation()
      markAllNotificationsAsRead()
    })
  }
}

function toggleNotifications() {
  const toggleBtn = document.getElementById('toggle-notifications')
  if (!toggleBtn) return

  const showAll = toggleBtn.dataset.showAll === 'true'
  const newShowAll = !showAll

  // Update button state and text
  toggleBtn.dataset.showAll = newShowAll
  toggleBtn.textContent = newShowAll ? 'Show unread only' : 'Show all'

  // Reload notifications with new filter
  loadNotifications(newShowAll)
}

function createNotificationItem(notification) {
  const item = document.createElement('a')
  item.className = 'dropdown-item notification-item' + (notification.unread ? ' unread' : '')
  item.href = notification.action_url || '#'
  item.setAttribute('data-notification-id', notification.id)

  const icon = notificationPriorityIcon(notification.category)
  const timeAgo = getTimeAgo(new Date(notification.created_at))

  item.innerHTML = `
    <div class="d-flex flex-column notification-content">
      <div class="d-flex align-items-start mb-1 notification-clickable">
        ${notification.unread ? '<span class="unread-indicator me-2"></span>' : '<span class="read-indicator me-2">✓</span>'}
        <span class="me-2 flex-shrink-0">${icon}</span>
        <div class="flex-grow-1 overflow-hidden">
          <div class="notification-message collapsed">${escapeNotificationHtml(notification.message)}</div>
        </div>
      </div>
      <div class="d-flex justify-content-between align-items-center">
        <small class="text-muted">${timeAgo}</small>
        <div class="d-flex gap-1 align-items-center">
          <span class="badge bg-${notificationPriorityClass(notification.priority)}">${notification.priority}</span>
          ${notification.unread ? '<button class="btn btn-sm btn-outline-secondary mark-read-btn" style="padding: 0.1rem 0.3rem; font-size: 0.7rem;">✓</button>' : ''}
        </div>
      </div>
    </div>
  `

  // Handle expanding/collapsing message
  const clickableArea = item.querySelector('.notification-clickable')
  const messageDiv = item.querySelector('.notification-message')

  if (clickableArea && messageDiv) {
    clickableArea.addEventListener('click', (e) => {
      e.preventDefault()
      e.stopPropagation()
      console.log('Toggling notification message')
      messageDiv.classList.toggle('collapsed')
    })
  }

  // Handle mark as read button
  const markReadBtn = item.querySelector('.mark-read-btn')
  if (markReadBtn) {
    markReadBtn.addEventListener('click', (e) => {
      e.preventDefault()
      e.stopPropagation()
      console.log('Marking notification as read:', notification.id)
      markNotificationAsRead(notification.id)
      item.classList.remove('unread')
      markReadBtn.remove()
      // Replace unread indicator with read indicator
      const indicator = item.querySelector('.unread-indicator')
      if (indicator) {
        indicator.className = 'read-indicator me-2'
        indicator.textContent = '✓'
      }
    })
  }

  // Handle navigation to action URL
  if (notification.action_url) {
    item.style.cursor = 'pointer'
    item.addEventListener('click', (e) => {
      if (!e.target.closest('.notification-clickable') && !e.target.closest('.mark-read-btn')) {
        window.location.href = notification.action_url
      }
    })
  } else {
    item.style.cursor = 'default'
  }

  return item
}

function markNotificationAsRead(notificationId) {
  if (!notificationId) {
    console.error('Cannot mark notification as read: notificationId is undefined')
    return
  }

  console.log(`Marking notification ${notificationId} as read via REST API`)
  fetch(`/notifications/${notificationId}/mark_as_read.json`, {
    method: 'PATCH',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
      'Accept': 'application/json'
    }
  })
  .then(response => {
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    return response.json()
  })
  .then(() => {
    updateUnreadCount()
  })
  .catch(error => console.error('Error marking notification as read:', error))
}

function markAllNotificationsAsRead() {
  fetch('/notifications/mark_all_as_read', {
    method: 'PATCH',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
    }
  })
  .then(response => response.json())
  .then(() => {
    // Update UI
    document.querySelectorAll('.notification-item.unread').forEach(item => {
      item.classList.remove('unread')
    })
    updateUnreadCount()
  })
  .catch(error => console.error('Error marking all as read:', error))
}

function updateUnreadCount() {
  fetch('/notifications/unread_count.json', {
    credentials: 'same-origin'
  })
    .then(response => response.json())
    .then(data => {
      const badge = document.getElementById('notification-badge')
      if (badge) {
        if (data.count > 0) {
          badge.textContent = data.count > 99 ? '99+' : data.count
          badge.style.display = 'inline-block'
        } else {
          badge.style.display = 'none'
        }
      }
    })
    .catch(error => console.error('Error fetching unread count:', error))
}

function notificationPriorityIcon(category) {
  const icons = {
    'job_status': '⚙️',
    'membership': '👤',
    'mentorship': '📚',
    'admin_alert': '⚠️',
    'system': 'ℹ️'
  }
  return icons[category] || 'ℹ️'
}

function notificationPriorityClass(priority) {
  const classes = {
    'urgent': 'danger',
    'high': 'warning',
    'normal': 'info',
    'low': 'secondary'
  }
  return classes[priority] || 'info'
}

function escapeNotificationHtml(text) {
  const div = document.createElement('div')
  div.textContent = text
  return div.innerHTML
}

function getTimeAgo(date) {
  const seconds = Math.floor((new Date() - date) / 1000)

  const intervals = {
    year: 31536000,
    month: 2592000,
    week: 604800,
    day: 86400,
    hour: 3600,
    minute: 60
  }

  for (const [unit, secondsInUnit] of Object.entries(intervals)) {
    const interval = Math.floor(seconds / secondsInUnit)
    if (interval >= 1) {
      return interval === 1 ? `1 ${unit} ago` : `${interval} ${unit}s ago`
    }
  }

  return 'Just now'
}

document.addEventListener('turbo:load', function () {
  console.log('turbo loaded')
  loadPayPalButtons();
  loadImageModals();
  populateJulianDate();
  loadNotifications();
});