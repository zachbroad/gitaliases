import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { autoDismiss: Boolean }

  connect() {
    if (this.autoDismissValue) {
      // Auto-dismiss after 5 seconds
      this.timeout = setTimeout(() => {
        this.dismiss()
      }, 5000)
    }
  }

  dismiss() {
    // Clear timeout if it exists
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
    
    // Add fade-out animation
    this.element.style.transition = "opacity 0.3s ease-out"
    this.element.style.opacity = "0"
    
    // Remove element after animation
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }

  disconnect() {
    // Clean up timeout when controller is removed
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }
}