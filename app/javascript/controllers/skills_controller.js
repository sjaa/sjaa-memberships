import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="skills"
export default class extends Controller {
  static targets = ["additionalSkills", "toggleButton", "toggleText"]

  toggleAdditional() {
    const skills = this.additionalSkillsTarget
    const isHidden = skills.style.display === 'none'

    skills.style.display = isHidden ? 'block' : 'none'
    this.toggleTextTarget.textContent = isHidden ? '- Hide Additional Skills' : '+ Add More Skills'
  }

  updateValue(event) {
    const skillId = event.target.dataset.skillId
    const skillType = event.target.dataset.skillType
    const value = event.target.value

    const targetName = `${skillType}Value-${skillId}`
    const target = document.querySelector(`[data-skill-target="${targetName}"]`)

    if (target) {
      target.textContent = value
      target.classList.remove('text-danger', 'text-warning', 'text-success', 'text-muted')

      if (value == 0) {
        target.classList.add('text-muted')
      } else if (value <= 3) {
        target.classList.add('text-danger')
      } else if (value <= 6) {
        target.classList.add('text-warning')
      } else {
        target.classList.add('text-success')
      }
    }
  }
}
