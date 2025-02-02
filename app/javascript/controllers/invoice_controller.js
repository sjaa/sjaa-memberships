import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="invoice"
export default class extends Controller {
  static targets = ["constant", "field", "total"]
  connect() {
  }

  calculate_total(event) {
    event.preventDefault()
    let sum = 0;

    // Sum the constants
    this.constantTargets.forEach(target => {
      let value = parseFloat(target.textContent) || 0;
      sum += value;
    });

    // Sum the dynamic fields
    this.fieldTargets.forEach(field => {
      let value = Math.abs(parseFloat(field.value) || 0);
      sum += value;

      // Update the itemized value, if id is present
      var updateElement = document.getElementById(field.dataset.updateid);
      if(updateElement) {
        updateElement.textContent = value;
      }

    });
    this.totalTarget.textContent = sum;
  }
}
