import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["fields", "template"]

  connect() {
    this.number = 0
  }

  addField(event) {
    event.preventDefault()
    var id = event.params.baseid
    var replaceId = event.params.replaceid || 'NEWID'
    var cloned = this.templateTarget.content.cloneNode(true)
    cloned.childNodes.forEach((node) => {
      if (node.nodeType != Node.TEXT_NODE) {
        if(node.id) node.id = `${id || 'new'}_${this.number}`
        node.innerHTML = node.innerHTML.replace(new RegExp(`${replaceId}`, 'g'), `${id || 'new'}_${this.number}`)
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
