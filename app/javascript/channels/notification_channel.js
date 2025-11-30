import consumer from "channels/consumer"

// Notification channel for real-time notifications
const notificationChannel = consumer.subscriptions.create("NotificationChannel", {
  connected() {
    console.log("Connected to NotificationChannel")
  },

  disconnected() {
    console.log("Disconnected from NotificationChannel")
  },

  received(data) {
    console.log("Received notification:", data)

    if (data.type === 'unread_count') {
      // Update the badge count
      this.updateUnreadCount(data.count)
    } else {
      // New notification received
      this.handleNewNotification(data)
    }
  },

  handleNewNotification(notification) {
    // Update unread count badge
    this.incrementUnreadCount()

    // Show toast notification
    this.showToast(notification)

    // Add to notification dropdown if it's open
    this.addToDropdown(notification)
  },

  showToast(notification) {
    const toastContainer = document.getElementById('notification-toast-container')
    if (!toastContainer) return

    const toast = document.createElement('div')
    toast.className = `notification-toast notification-${notification.priority} alert alert-${this.getPriorityClass(notification.priority)} alert-dismissible fade show`
    toast.setAttribute('role', 'alert')
    toast.setAttribute('data-notification-id', notification.id)

    const icon = this.getPriorityIcon(notification.category)

    toast.innerHTML = `
      <div class="d-flex align-items-start">
        <span class="me-2">${icon}</span>
        <div class="flex-grow-1">
          <strong>${this.getCategoryLabel(notification.category)}</strong>
          <div>${this.escapeHtml(notification.message)}</div>
          ${notification.action_url ? `<a href="${notification.action_url}" class="alert-link">View</a>` : ''}
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    `

    toastContainer.appendChild(toast)

    // Mark as read when dismissed
    toast.addEventListener('closed.bs.alert', () => {
      this.markAsRead(notification.id)
    })

    // Auto-dismiss after delay based on priority
    const delay = notification.priority === 'urgent' ? 10000 : notification.priority === 'high' ? 7000 : 5000
    setTimeout(() => {
      const bsAlert = new bootstrap.Alert(toast)
      bsAlert.close()
    }, delay)
  },

  addToDropdown(notification) {
    const dropdown = document.getElementById('notification-dropdown')
    if (!dropdown) return

    const item = document.createElement('a')
    item.className = 'dropdown-item notification-item unread'
    item.href = notification.action_url || '#'
    item.setAttribute('data-notification-id', notification.id)

    const icon = this.getPriorityIcon(notification.category)
    const timeAgo = 'Just now'

    item.innerHTML = `
      <div class="d-flex align-items-start">
        <span class="me-2">${icon}</span>
        <div class="flex-grow-1">
          <div class="notification-message">${this.escapeHtml(notification.message)}</div>
          <small class="text-muted">${timeAgo}</small>
        </div>
        <span class="badge bg-${this.getPriorityClass(notification.priority)} ms-2">${notification.priority}</span>
      </div>
    `

    item.addEventListener('click', (e) => {
      if (!notification.action_url) {
        e.preventDefault()
      }
      this.markAsRead(notification.id)
      item.classList.remove('unread')
    })

    // Add to top of dropdown (after header)
    const firstItem = dropdown.querySelector('.dropdown-item')
    if (firstItem) {
      dropdown.insertBefore(item, firstItem)
    } else {
      dropdown.appendChild(item)
    }
  },

  updateUnreadCount(count) {
    const badge = document.getElementById('notification-badge')
    if (badge) {
      if (count > 0) {
        badge.textContent = count > 99 ? '99+' : count
        badge.style.display = 'inline-block'
      } else {
        badge.style.display = 'none'
      }
    }
  },

  incrementUnreadCount() {
    const badge = document.getElementById('notification-badge')
    if (badge) {
      const current = parseInt(badge.textContent) || 0
      this.updateUnreadCount(current + 1)
    }
  },

  markAsRead(notificationId) {
    this.perform('mark_as_read', { id: notificationId })
  },

  markAllAsRead() {
    this.perform('mark_all_as_read')
  },

  getCategoryLabel(category) {
    const labels = {
      'job_status': 'Background Job',
      'membership': 'Membership',
      'mentorship': 'Mentorship',
      'admin_alert': 'Admin Alert',
      'system': 'System'
    }
    return labels[category] || 'Notification'
  },

  getPriorityIcon(category) {
    const icons = {
      'job_status': '⚙️',
      'membership': '👤',
      'mentorship': '📚',
      'admin_alert': '⚠️',
      'system': 'ℹ️'
    }
    return icons[category] || 'ℹ️'
  },

  getPriorityClass(priority) {
    const classes = {
      'urgent': 'danger',
      'high': 'warning',
      'normal': 'info',
      'low': 'secondary'
    }
    return classes[priority] || 'info'
  },

  escapeHtml(text) {
    const div = document.createElement('div')
    div.textContent = text
    return div.innerHTML
  }
})

// Export for use in other modules
export default notificationChannel
