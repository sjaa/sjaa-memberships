import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["fields", "template"]

  connect() {
  }

  addField(event) {
    event.preventDefault()

    var content = this.templateTarget.innerHTML
    this.fieldsTarget.insertAdjacentHTML("afterend", content)
  }

  removeField(event) {
    event.preventDefault()
    // Pass in parameters with data-form-id-params=...
    document.getElementById(event.params.id).remove()
  }
}
