import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dateButton"]

  connect() {
    // If there's a selected date in the URL params, highlight it on page load
    const urlParams = new URLSearchParams(window.location.search)
    const selectedDate = urlParams.get('selected_date')
    if (selectedDate) {
      this.highlightDate(selectedDate)
    }
  }

  selectDate(event) {
    // Remove active class from all dates
    this.dateButtonTargets.forEach(button => {
      button.classList.remove('active')
    })
    
    // Add active class to clicked date
    event.currentTarget.classList.add('active')
  }

  highlightDate(dateString) {
    this.dateButtonTargets.forEach(button => {
      button.classList.remove('active')
      if (button.dataset.date === dateString) {
        button.classList.add('active')
      }
    })
  }
}