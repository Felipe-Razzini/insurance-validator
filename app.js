import { createApp } from 'vue'

createApp({
  data() {
    return {
      showClientForm: false,
      companyNumber: '',
      contactName: ''
    }
  },
  methods: {
    displayForm() {
      this.showClientForm = true
      this.toggleFormVisibility(true);
    },
    hideForm() {
      this.showClientForm = false
      this.toggleFormVisibility(false);
    },
    toggleFormVisibility(isVisible) {
      const form = document.getElementById('client-form');
      if (isVisible) {
          setTimeout(() => {
              form.classList.add('show');
          }, 0);
      } else {
          form.classList.remove('show');
      }
    },
    async submitForm() {
      // Call the Companies House API
      const response = await fetch(`https://api.company-information.service.gov.uk/company/${this.companyNumber}`, {
          headers: {
              // Your API key
          }
      });
      const data = await response.json();

      // Check the data and decide whether to give insurance
      if (this.meetsRequirements(data)) {
          // Redirect to the success page
          window.location.href = 'success.html';
      } else {
          // Redirect to the error page
          window.location.href = 'error.html';
      }
  },
  meetsRequirements(data) {
      // Check the data and return true if the user meets the requirements, false otherwise
  }
  }
}).mount('#app')
