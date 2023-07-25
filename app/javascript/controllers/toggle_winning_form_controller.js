import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-winning-form"
export default class extends Controller {
  static targets = ['winningForm', 'winningFormContainer']

  displayWinningForm(event) {
    event.target.classList.add('d-none')
    this.winningFormTarget.classList.remove('d-none')
    this.winningFormContainerTarget.classList.remove('mx-auto')
  }
}
