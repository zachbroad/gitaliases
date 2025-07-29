import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectedTags", "input", "hiddenField", "suggestions"]
  static values = { value: String }

  connect() {
    this.tags = new Set()
    this.loadInitialTags()
    this.bindEvents()
  }

  loadInitialTags() {
    if (this.valueValue) {
      const initialTags = this.valueValue.split(',').map(tag => tag.trim()).filter(tag => tag)
      initialTags.forEach(tag => this.addTagToSet(tag))
    }
  }

  bindEvents() {
    this.inputTarget.addEventListener('keydown', this.handleKeydown.bind(this))
    this.inputTarget.addEventListener('blur', this.handleBlur.bind(this))
  }

  handleKeydown(event) {
    if (event.key === 'Enter' || event.key === ',') {
      event.preventDefault()
      this.addCurrentTag()
    } else if (event.key === 'Backspace' && this.inputTarget.value === '') {
      this.removeLastTag()
    }
  }

  handleBlur(event) {
    if (this.inputTarget.value.trim()) {
      this.addCurrentTag()
    }
  }

  addCurrentTag() {
    const tag = this.inputTarget.value.trim().toLowerCase()
    if (tag) {
      this.addTagToSet(tag)
      this.inputTarget.value = ''
    }
  }

  addTag(event) {
    const tag = event.target.dataset.tag
    this.addTagToSet(tag)
  }

  addTagToSet(tag) {
    if (!this.tags.has(tag)) {
      this.tags.add(tag)
      this.renderTags()
      this.updateHiddenField()
    }
  }

  removeTag(event) {
    const tag = event.target.dataset.tag
    this.tags.delete(tag)
    this.renderTags()
    this.updateHiddenField()
  }

  removeLastTag() {
    const tagsArray = Array.from(this.tags)
    if (tagsArray.length > 0) {
      const lastTag = tagsArray[tagsArray.length - 1]
      this.tags.delete(lastTag)
      this.renderTags()
      this.updateHiddenField()
    }
  }

  renderTags() {
    this.selectedTagsTarget.innerHTML = ''
    this.tags.forEach(tag => {
      const pill = this.createTagPill(tag)
      this.selectedTagsTarget.appendChild(pill)
    })
  }

  createTagPill(tag) {
    const pill = document.createElement('span')
    pill.className = 'inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-indigo-100 text-indigo-800'
    pill.innerHTML = `
      ${tag}
      <button type="button" 
              data-action="click->tag-selector#removeTag" 
              data-tag="${tag}"
              class="ml-2 inline-flex items-center justify-center w-4 h-4 rounded-full text-indigo-600 hover:bg-indigo-200 hover:text-indigo-800 focus:outline-none">
        <svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
          <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
        </svg>
      </button>
    `
    return pill
  }

  updateHiddenField() {
    this.hiddenFieldTarget.value = Array.from(this.tags).join(', ')
  }
}