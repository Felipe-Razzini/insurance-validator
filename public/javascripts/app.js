import { createApp } from 'vue'

createApp({
  data() {
    return {
      showClientForm: false,
      isLoading: false,
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
    submitForm() {
        if (!this.companyNumber || !this.contactName) {
          this.isLoading = false;
        } else {
          this.isLoading = true;
          this.$nextTick(() => {
            this.$el.querySelector('form').submit();
          });
      }
    }
  }
}).mount('#app')
