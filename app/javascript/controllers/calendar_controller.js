import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dateButton"];

  selectDate(event) {
    this.dateButtonTargets.forEach(button => {
      button.classList.remove("active");
    });
    event.currentTarget.classList.add("active");
  }
}