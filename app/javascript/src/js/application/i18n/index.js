import { createI18n } from 'vue3-i18n'

const messages = {
  en: {
    footer: {
      copyright: 'Copyright {year}'
    },
    header: {
      navigation: {
        about: 'About',
        contact: 'Contact',
        home: 'Home',
        unknown: 'Unknown'
      }
    },
    view: {
      about: {
        content: 'About'
      },
      contact: {
        content: 'Contact'
      },
      home: {
        content: 'Homepage'
      },
      not_found: {
        content: 'Not found'
      }
    }
  }
}

const i18n = createI18n({
  locale: 'en',
  messages: messages
})

export default i18n;
