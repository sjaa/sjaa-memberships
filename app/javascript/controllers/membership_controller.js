import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="membership"
export default class extends Controller {
  static targets = ["termMonths", "lifetime"]
  static values = { isLifetime: Boolean }

  connect() {
    if (this.isLifetimeValue) {
      this.lifetimeTarget.checked = true
      this.applyLifetime()
    }
  }

  toggleLifetime() {
    if (this.lifetimeTarget.checked) {
      this.savedTermMonths = this.termMonthsTarget.value
      this.applyLifetime()
    } else {
      this.termMonthsTarget.value = this.savedTermMonths || ""
      this.termMonthsTarget.readOnly = false
      this.termMonthsTarget.classList.remove("bg-light")
    }
  }

  applyLifetime() {
    this.termMonthsTarget.value = ""
    this.termMonthsTarget.readOnly = true
    this.termMonthsTarget.classList.add("bg-light")
  }
}
