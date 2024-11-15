import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dateButton"]

  selectDate(event) {
    // Remove active class from all date buttons in the calendar
    document.querySelectorAll('.calendar-date').forEach(button => {
      button.classList.remove("active")
    })
    
    // Add active class to clicked button
    event.currentTarget.classList.add("active")
  }
}