import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bulk-actions"
export default class extends Controller {
  static targets = ["checkbox", "selectAll", "selectedCount", "submitButton", "groupSelector"]
  static values = {
    csrfToken: String
  }

  connect() {
    this.updateUI()
  }

  toggleAll(event) {
    const isChecked = event.target.checked
    this.checkboxTargets.forEach(checkbox => {
      checkbox.checked = isChecked
    })
    this.updateUI()
  }

  toggleOne() {
    this.updateUI()
  }

  updateUI() {
    const selectedCheckboxes = this.checkboxTargets.filter(cb => cb.checked)
    const selectedCount = selectedCheckboxes.length

    // Update selected count display
    if (this.hasSelectedCountTarget) {
      this.selectedCountTarget.textContent = selectedCount
    }

    // Update select all checkbox state
    if (this.hasSelectAllTarget) {
      const allChecked = selectedCheckboxes.length === this.checkboxTargets.length
      const someChecked = selectedCheckboxes.length > 0
      this.selectAllTarget.checked = allChecked
      this.selectAllTarget.indeterminate = someChecked && !allChecked
    }

    // Enable/disable submit button based on selection
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.disabled = selectedCount === 0
    }
  }

  async submit(event) {
    event.preventDefault()

    const selectedCheckboxes = this.checkboxTargets.filter(cb => cb.checked)
    const personIds = selectedCheckboxes.map(cb => cb.value)

    if (personIds.length === 0) {
      alert('Please select at least one person')
      return
    }

    // Get selected groups from multi-select
    const groupIds = Array.from(this.groupSelectorTarget.selectedOptions).map(option => option.value)

    if (!groupIds || groupIds.length === 0) {
      alert('Please select at least one group')
      return
    }

    try {
      const response = await fetch('/people/bulk_add_to_groups', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': this.csrfTokenValue
        },
        body: JSON.stringify({
          person_ids: personIds,
          group_ids: groupIds
        })
      })

      const data = await response.json()

      if (response.ok) {
        // Show success message
        alert(data.message || `Successfully added ${personIds.length} people to ${groupIds.length} group(s)`)

        // Clear selections
        this.checkboxTargets.forEach(cb => cb.checked = false)
        if (this.hasGroupSelectorTarget) {
          this.groupSelectorTarget.selectedIndex = -1
        }
        this.updateUI()

        // Reload the page to show updated data
        window.location.reload()
      } else {
        alert(data.error || 'An error occurred while adding people to groups')
      }
    } catch (error) {
      console.error('Error:', error)
      alert('An error occurred while processing your request')
    }
  }
}
