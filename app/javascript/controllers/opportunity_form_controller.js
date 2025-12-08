import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="opportunity-form"
export default class extends Controller {
  static targets = ["skillBadge", "skillsContainer"]

  connect() {
    console.log("Opportunity form controller connected")
  }

  updateSkillLevel(event) {
    const skillId = event.target.dataset.skillId
    const level = parseInt(event.target.value)
    const badge = this.skillBadgeTargets.find(b => b.dataset.skillId === skillId)

    if (badge) {
      // Update badge text
      const levelNames = ['None', 'Beginner', 'Intermediate', 'Advanced']
      badge.textContent = levelNames[level]

      // Update badge color
      badge.classList.remove('bg-secondary', 'bg-info', 'bg-warning', 'bg-success')
      const bgClasses = ['bg-secondary', 'bg-info', 'bg-warning', 'bg-success']
      badge.classList.add(bgClasses[level])
    }
  }
}
