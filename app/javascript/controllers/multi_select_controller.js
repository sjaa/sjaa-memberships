import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="multi-select"
export default class extends Controller {
  static targets = ["fieldset", "template"]

  connect() {
  }
}
