import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="alert"
export default class extends Controller {
  static values = {
    successIcon: String,
    successTitle: String,
    successText: String,
    computerPersona: String,
    success: Boolean,
    errorIcon: String,
    errorTitle: String,
    errorText: String,
  }
  connect() {
    if (this.successValue) {
      this.initSuccessAlert()
    } else {
      this.initErrorAlert()
    }
  }

  initSuccessAlert() {
    Swal.fire({
      icon: this.successIconValue,
      title: `<strong>${this.successTitleValue}</strong>`,
      html: `<div>
              <br>
              <strong>${this.successTextValue}</strong>
              <br>
              <p>Computer persona was : </p>
              <br>
              <img src=${this.computerPersonaValue} class='alert-persona-picture' >
            </div>`,
      confirmButtonText: 'Start a new game',
      confirmButtonColor: '#FFC300'
    })
  }

  initErrorAlert() {
    Swal.fire({
      icon: this.errorIconValue,
      title: `<strong>${this.errorTitleValue}</strong>`,
      html: `<div>
              <br>
              <p><strong>${this.errorTextValue.replaceAll('+', ' ')}</strong><p>
              <br>
              <p>Computer persona was : </p>
              <br>
              <img src=${this.computerPersonaValue} class='alert-persona-picture' >
            </div>`,
      confirmButtonText: 'Try again',
      confirmButtonColor: '#FFC300',
    })
  }
}
