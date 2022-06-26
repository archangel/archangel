<script>
  import Header from './components/Header.vue'
  import Footer from './components/Footer.vue'

  export default {
    components: {
      Header,
      Footer
    }
  }
</script>

<template>
  <Header />

  <section id="main">
    <router-view />
  </section>

  <Footer />
</template>
