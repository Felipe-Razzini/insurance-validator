import { createApp } from 'vue'

createApp({
  data() {
    return {
      showClientForm: false,
      isLoading: false
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
  }
}).mount('#app')
