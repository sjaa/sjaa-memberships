import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mentor-toggle"
export default class extends Controller {
  static targets = ["checkbox", "description"]

  toggle() {
    if (this.checkboxTarget.checked) {
      this.descriptionTarget.style.display = "block"
    } else {
      this.descriptionTarget.style.display = "none"
    }
  }
}
