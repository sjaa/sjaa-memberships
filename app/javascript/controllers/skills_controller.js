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
    const value = parseInt(event.target.value)

    const targetName = `${skillType}Value-${skillId}`
    const target = document.querySelector(`[data-skill-target="${targetName}"]`)

    if (target) {
      // Map numeric value to label (0-3 scale)
      const labels = ['None', 'Beginner', 'Intermediate', 'Advanced']
      target.textContent = labels[value] || 'None'

      // Update color based on skill level
      target.classList.remove('text-info', 'text-warning', 'text-success', 'text-muted')

      if (value === 0) {
        target.classList.add('text-muted')
      } else if (value === 1) {
        target.classList.add('text-info')
      } else if (value === 2) {
        target.classList.add('text-warning')
      } else if (value === 3) {
        target.classList.add('text-success')
      }
    }

    // Update the range slider color class
    event.target.classList.remove('skill-level-0', 'skill-level-1', 'skill-level-2', 'skill-level-3')
    event.target.classList.add(`skill-level-${value}`)
  }
}
