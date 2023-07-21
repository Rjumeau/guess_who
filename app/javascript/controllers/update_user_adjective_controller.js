import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['adjectiveList']
  static values = { url: String }

  async getUserFeature(event) {
    const selectedFeature = event.target.value;
    const url = this.urlValue
    const response = await fetch(`${url}?feature=${selectedFeature}`);
    const data = await response.json();
    const adjectives = data.adjectives || [];
    this.updateAdjectiveList(adjectives);
  }

  updateAdjectiveList(adjectives) {
    const adjectiveListElement = this.adjectiveListTarget;
    while (adjectiveListElement.firstChild) {
      adjectiveListElement.removeChild(adjectiveListElement.firstChild);
    }

    adjectives.forEach(adjective => {
      this.addAdjective(adjective, adjectiveListElement)
    });
  }

  addAdjective(adjective, adjectiveListElement) {
    const option = document.createElement('option');
    option.value = adjective;
    option.textContent = adjective;
    adjectiveListElement.appendChild(option);
  }
}
