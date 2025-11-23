import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section", "form", "groupName", "submitButton"]

  connect() {
    // Listen for modal show event to capture which section button was clicked
    const modal = document.getElementById('createGroupModal')
    if (modal) {
      modal.addEventListener('show.bs.modal', (event) => {
        // Get the button that triggered the modal
        const button = event.relatedTarget
        // Get the section from the button's data attribute
        const section = button.getAttribute('data-section')
        // Update the hidden field with the section value
        this.sectionTarget.value = section
      })
    }
  }

  submitForm(event) {
    // Allow default form submission, but disable submit button to prevent double-clicks
    this.submitButtonTarget.disabled = true
    this.submitButtonTarget.textContent = "Creating..."
  }
}
