<script>
  export default {
    data() {
      return {
        copy: '&copy;'
      }
    },
    computed: {
      currentYear() {
        return new Date().getFullYear()
      }
    }
  }
</script>

<template>
  <footer id="footer">
    <p class="copyright">{{ copy }} {{ $t('footer.copyright', { year: currentYear }) }}</p>
  </footer>
</template>
