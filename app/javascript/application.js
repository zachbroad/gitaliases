// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Copy to clipboard function
window.copyToClipboard = function(text, button) {
  navigator.clipboard.writeText(text).then(function() {
    // Update button text temporarily
    const originalText = button.innerHTML;
    button.innerHTML = '✅ Copied!';
    button.classList.add('bg-green-100', 'text-green-700', 'border-green-500');
    
    setTimeout(() => {
      button.innerHTML = originalText;
      button.classList.remove('bg-green-100', 'text-green-700', 'border-green-500');
    }, 2000);
  }).catch(function(err) {
    console.error('Failed to copy text: ', err);
  });
}
