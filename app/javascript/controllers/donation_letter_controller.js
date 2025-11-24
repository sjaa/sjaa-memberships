import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="donation-letter"
export default class extends Controller {
  static targets = ["customMessage", "ccEmails", "sendButton", "form"]

  connect() {
    console.log("Donation letter controller connected")
  }

  async sendLetter(event) {
    event.preventDefault()

    const form = this.formTarget
    const formData = new FormData(form)
    const sendButton = this.sendButtonTarget

    // Disable send button
    sendButton.disabled = true
    sendButton.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Sending...'

    try {
      const response = await fetch(form.action, {
        method: 'POST',
        body: formData,
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Accept': 'text/vnd.turbo-stream.html'
        }
      })

      if (response.ok) {
        // Let Turbo handle the stream response (it will update flash messages)
        const text = await response.text()
        Turbo.renderStreamMessage(text)

        // Close modal on success
        const modal = bootstrap.Modal.getInstance(document.getElementById('donationLetterModal'))
        modal.hide()
        // Reset form
        form.reset()
      } else {
        // For errors, also handle the turbo stream response
        const text = await response.text()
        Turbo.renderStreamMessage(text)

        // Close modal on error as well
        const modal = bootstrap.Modal.getInstance(document.getElementById('donationLetterModal'))
        modal.hide()
        // Reset form
        form.reset()
      }
    } catch (error) {
      console.error('Error sending letter:', error)
      // Close modal even on network errors
      const modal = bootstrap.Modal.getInstance(document.getElementById('donationLetterModal'))
      modal.hide()
      alert('An error occurred. Please try again.')
    } finally {
      // Re-enable send button
      sendButton.disabled = false
      sendButton.innerHTML = '<i class="bi bi-envelope me-2"></i>Send Letter'
    }
  }

  previewLetter(event) {
    event.preventDefault()

    const form = this.formTarget
    const formData = new FormData(form)

    // Build query string from form data
    const params = new URLSearchParams(formData)
    const previewUrl = `${form.dataset.previewUrl}?${params.toString()}`

    // Open preview in new window
    window.open(previewUrl, '_blank')
  }

  openModal(event) {
    event.preventDefault()

    // Show modal
    const modal = new bootstrap.Modal(document.getElementById('donationLetterModal'))
    modal.show()
  }
}
