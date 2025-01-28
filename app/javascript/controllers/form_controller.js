import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["fields", "template", "source"]

  connect() {
    this.number = 0
  }

  addField(event) {
    event.preventDefault()
    var id = event.params.baseid
    var replaceId = event.params.replaceid || 'NEWID'
    var cloned = this.templateTarget.content.cloneNode(true)

    // Find a form value to use as a replacement value
    var replaceValue = event.params.replacevalue || 'REPLACEVALUE'
    var replaceName = event.params.replacename || 'REPLACENAME'
    var value = null
    var name = null

    console.log(`Adding Field... ${event.inspect}`)

    // Construct the target node and replace important values
    cloned.childNodes.forEach((node) => {
      if (node.nodeType != Node.TEXT_NODE) {
        if(node.id) node.id = `${id || 'new'}_${this.number}`

        node.innerHTML = node.innerHTML.replace(new RegExp(`${replaceId}`, 'g'), `${id || 'new'}_${this.number}`)

        // Assume the source is a combo-box
        if(this.hasSourceTarget) {
          var selectedOption = this.sourceTarget.querySelector('[aria-selected="true"]')
          var clearHandle = this.sourceTarget.getElementsByClassName('hw-combobox__handle')[0]
          node.innerHTML = node.innerHTML.replace(new RegExp(`${replaceValue}`, 'g'), `${selectedOption.dataset.value}`)
          node.innerHTML = node.innerHTML.replace(new RegExp(`${replaceName}`, 'g'), `${selectedOption.dataset.autocompletableAs}`)

          // Clear the selection
          clearHandle.click();
        }

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
