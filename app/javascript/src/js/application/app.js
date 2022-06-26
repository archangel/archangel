import { createApp } from 'vue'
import router from './router'
import i18n from './i18n'
import App from '@/js/application/App.vue'

export default () => {
  document.addEventListener('DOMContentLoaded', () => {
    createApp(App).use(router)
                  .use(i18n)
                  .mount('#vue-app')
  })
}
