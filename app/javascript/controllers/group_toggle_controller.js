import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="group-toggle"
export default class extends Controller {
  static targets = ["checkbox", "label", "icon"]

  connect() {
    // Initialize all labels with proper state on connect
    this.labelTargets.forEach((label, index) => {
      const checkbox = this.checkboxTargets[index]
      this.updateLabelState(label, checkbox.checked)
    })
  }

  toggle(event) {
    // Prevent the default label click behavior to avoid double-toggling
    event.preventDefault()

    const label = event.currentTarget
    const checkboxId = label.getAttribute('for')
    const checkbox = document.getElementById(checkboxId)

    if (checkbox) {
      // Toggle the checkbox state
      checkbox.checked = !checkbox.checked

      // Update the visual state
      this.updateLabelState(label, checkbox.checked)
    }
  }

  updateLabelState(label, isChecked) {
    const icon = label.querySelector('[data-group-toggle-target="icon"]')

    if (isChecked) {
      // Joined state: green button with checkmark
      label.classList.remove('btn-outline-secondary')
      label.classList.add('btn-success')
      if (icon) {
        icon.textContent = '✓'
      }
    } else {
      // Not joined state: outlined button with plus
      label.classList.remove('btn-success')
      label.classList.add('btn-outline-secondary')
      if (icon) {
        icon.textContent = '+'
      }
    }
  }
}
