import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["fields", "template"]

  connect() {
    this.number = 0
  }

  addField(event) {
    event.preventDefault()

    var cloned = this.templateTarget.content.cloneNode(true)
    console.log(cloned)
    cloned.childNodes.forEach((node) => {
      if (node.nodeType != Node.TEXT_NODE) {
        node.innerHTML.replace(/NEWID/g, `new_interest_${this.number}`)
        this.fieldsTarget.appendChild(node)
      }
    })
    this.number += 1
  }

  removeField(event) {
    event.preventDefault()
    // Pass in parameters with data-form-id-params=...
    document.getElementById(event.params.id).remove()
  }
}
