import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="alert"
export default class extends Controller {
  static values = {
    newGameUrl: String,
    successIcon: String,
    successTitle: String,
    winnerPersona: String,
    success: Boolean,
    errorIcon: String,
    errorTitle: String
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
              <p>Computer persona was : </p>
              <img src=${this.winnerPersonaValue} style= width:100px; height: 100px >
            </div>`,
      confirmButtonText: 'Start a new game',
      confirmButtonColor: '#FFC300'
    })
  }

  initErrorAlert() {
    Swal.fire({
      icon: this.errorIconValue,
      title: `<strong>${this.errorTitleValue}</strong>`,
      confirmButtonText: 'Try again',
      confirmButtonColor: '#FFC300',
    })
  }
}
