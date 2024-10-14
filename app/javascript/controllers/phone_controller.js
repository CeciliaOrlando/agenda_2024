import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["phoneNumbers", "template"]

  addPhoneNumber(event) {
    event.preventDefault()
    let content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, new Date().getTime())
    this.phoneNumbersTarget.insertAdjacentHTML('beforeend', content)
  }

  removePhoneNumber(event) {
    event.preventDefault()
    let item = event.target.closest(".phone-number-fields")
    if (item.dataset.newRecord === "true") {
      item.remove()
    } else {
      item.style.display = "none"
      item.querySelector("input[name*='_destroy']").value = "1"
    }
  }
}
