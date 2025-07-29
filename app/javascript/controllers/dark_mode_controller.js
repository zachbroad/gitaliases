import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "label"]

  connect() {
    // Check for saved theme preference or default to 'system'
    const savedTheme = localStorage.getItem('theme') || 'system'
    this.currentMode = savedTheme
    this.applyTheme(savedTheme)
    this.updateToggleState(savedTheme)
    
    // Listen for system theme changes
    this.mediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
    this.mediaQuery.addEventListener('change', this.handleSystemThemeChange.bind(this))
  }

  disconnect() {
    if (this.mediaQuery) {
      this.mediaQuery.removeEventListener('change', this.handleSystemThemeChange.bind(this))
    }
  }

  toggle() {
    // Cycle through: light -> dark -> system -> light
    const modes = ['light', 'dark', 'system']
    const currentIndex = modes.indexOf(this.currentMode)
    const nextIndex = (currentIndex + 1) % modes.length
    const newMode = modes[nextIndex]
    
    this.currentMode = newMode
    this.applyTheme(newMode)
    this.updateToggleState(newMode)
    localStorage.setItem('theme', newMode)
  }

  handleSystemThemeChange() {
    // Only apply system changes if we're in system mode
    if (this.currentMode === 'system') {
      this.applyTheme('system')
    }
  }

  applyTheme(mode) {
    if (mode === 'dark') {
      document.documentElement.classList.add('dark')
    } else if (mode === 'light') {
      document.documentElement.classList.remove('dark')
    } else if (mode === 'system') {
      // Use system preference
      if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
        document.documentElement.classList.add('dark')
      } else {
        document.documentElement.classList.remove('dark')
      }
    }
  }

  updateToggleState(mode) {
    if (this.hasToggleTarget) {
      const icon = this.toggleTarget.querySelector('svg')
      const button = this.toggleTarget
      
      // Update icon and tooltip based on mode
      if (mode === 'light') {
        button.title = 'Switch to dark mode'
        icon.innerHTML = `
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
        `
      } else if (mode === 'dark') {
        button.title = 'Switch to system mode'
        icon.innerHTML = `
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
        `
      } else { // system
        button.title = 'Switch to light mode'
        icon.innerHTML = `
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
        `
      }
      
      // Update label if it exists
      if (this.hasLabelTarget) {
        const labels = {
          'light': 'Light',
          'dark': 'Dark', 
          'system': 'System'
        }
        this.labelTarget.textContent = labels[mode]
      }
    }
  }
}