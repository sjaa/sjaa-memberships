import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mentor-contact"
export default class extends Controller {
  static targets = ["message", "submitButton", "form"]

  connect() {
    console.log("Mentor contact controller connected")
  }

  async submitForm(event) {
    event.preventDefault()

    const form = this.formTarget
    const formData = new FormData(form)
    const submitButton = this.submitButtonTarget

    // Disable submit button
    submitButton.disabled = true
    submitButton.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Sending...'

    try {
      const response = await fetch(form.action, {
        method: 'POST',
        body: formData,
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Accept': 'application/json'
        }
      })

      const data = await response.json()

      if (response.ok && data.success) {
        // Show success message
        this.showAlert('success', data.message)
        // Close modal
        const modal = bootstrap.Modal.getInstance(document.getElementById('mentorContactModal'))
        modal.hide()
        // Reset form
        form.reset()
      } else {
        // Show error message
        this.showAlert('danger', data.error || 'Failed to send message. Please try again.')
      }
    } catch (error) {
      console.error('Error submitting form:', error)
      this.showAlert('danger', 'An error occurred. Please try again.')
    } finally {
      // Re-enable submit button
      submitButton.disabled = false
      submitButton.innerHTML = '<i class="bi bi-send me-2"></i>Send Message'
    }
  }

  showAlert(type, message) {
    // Create and show Bootstrap alert
    const alertHtml = `
      <div class="alert alert-${type} alert-dismissible fade show mt-3" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    `

    // Try to find the best container for the alert
    let container = document.getElementById('alert-container')

    // If no dedicated alert container, try common containers
    if (!container) {
      container = document.querySelector('.container') ||
                  document.querySelector('.container-fluid') ||
                  document.querySelector('main') ||
                  document.body
    }

    if (container) {
      // Remove any existing alerts first
      const existingAlerts = container.querySelectorAll('.alert')
      existingAlerts.forEach(alert => alert.remove())

      // Add the new alert
      const alertDiv = document.createElement('div')
      alertDiv.innerHTML = alertHtml
      const alertElement = alertDiv.firstElementChild

      // Insert at the beginning if it's a proper container, otherwise at the top
      if (container.id === 'alert-container' || container === document.body) {
        container.appendChild(alertElement)
      } else {
        container.insertBefore(alertElement, container.firstChild)
      }

      // Scroll to the alert
      alertElement.scrollIntoView({ behavior: 'smooth', block: 'nearest' })

      // Auto-dismiss after 5 seconds
      setTimeout(() => {
        if (alertElement && alertElement.parentNode) {
          const bsAlert = new bootstrap.Alert(alertElement)
          bsAlert.close()
        }
      }, 5000)
    }
  }

  openModal(event) {
    const button = event.currentTarget
    const mentorName = button.dataset.mentorName

    // Update modal title
    const modalTitle = document.getElementById('mentorContactModalLabel')
    modalTitle.textContent = `Contact ${mentorName}`

    // Update form action
    const form = this.formTarget
    form.action = button.dataset.contactUrl

    // Pre-populate message
    const messageField = this.messageTarget
    const defaultMessage = `Hi ${mentorName.split(' ')[0]},\n\nI'm interested in learning more about astronomy and would appreciate your guidance. Could you help me with...`
    messageField.value = defaultMessage

    // Show modal
    const modal = new bootstrap.Modal(document.getElementById('mentorContactModal'))
    modal.show()
  }
}
