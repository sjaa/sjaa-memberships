import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["status"]
  connect() {
  }

  copy(event) {
    event.preventDefault()
    var text = event.params.text
    var message = ''

    navigator.clipboard.writeText(text).then(() => {
      /* clipboard successfully set */
      message = `<span class="text-success">Successfully copied ${text}</span>`
      if(this.statusTarget) this.statusTarget.innerHTML = message
    }, () => {
      /* clipboard write failed */
      message = `<span class="text-danger">Could not copy ${text}</span>`
      if(this.statusTarget) this.statusTarget.innerHTML = message
    })
  }
}
