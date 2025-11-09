import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="column-visibility"
export default class extends Controller {
  static targets = ["checkbox", "table"]
  static values = {
    storageKey: { type: String, default: "peopleTableColumnVisibility" }
  }

  connect() {
    // Use setTimeout to ensure the table is in the DOM
    setTimeout(() => {
      if (this.hasTableTarget) {
        this.loadPreferences()
      }
    }, 0)
  }

  toggle(event) {
    const checkbox = event.target
    const columnName = checkbox.dataset.column
    const isVisible = checkbox.checked

    this.setColumnVisibility(columnName, isVisible)
    this.savePreferences()
  }

  setColumnVisibility(columnName, isVisible) {
    if (!this.hasTableTarget) {
      console.warn('Table target not found')
      return
    }

    const cells = this.tableTarget.querySelectorAll(`[data-column="${columnName}"]`)
    cells.forEach(cell => {
      if (isVisible) {
        cell.classList.remove('column-hidden')
      } else {
        cell.classList.add('column-hidden')
      }
    })
  }

  loadPreferences() {
    const stored = localStorage.getItem(this.storageKeyValue)
    if (!stored) {
      // Default: all columns visible
      return
    }

    const preferences = JSON.parse(stored)
    this.checkboxTargets.forEach(checkbox => {
      const columnName = checkbox.dataset.column
      const isVisible = preferences[columnName] !== false // default to visible
      checkbox.checked = isVisible
      this.setColumnVisibility(columnName, isVisible)
    })
  }

  savePreferences() {
    const preferences = {}
    this.checkboxTargets.forEach(checkbox => {
      const columnName = checkbox.dataset.column
      preferences[columnName] = checkbox.checked
    })
    localStorage.setItem(this.storageKeyValue, JSON.stringify(preferences))
  }
}
