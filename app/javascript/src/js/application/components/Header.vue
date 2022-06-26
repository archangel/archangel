<template>
  <header id="header">
    <div id="nav">
      <router-link :to="{ name: 'home_path' }">{{ $t('header.navigation.home') }}</router-link> |
      <router-link :to="{ name: 'about_path' }">{{ $t('header.navigation.about') }}</router-link> |
      <router-link :to="{ name: 'contact_path' }">{{ $t('header.navigation.contact') }}</router-link> |
      <router-link to="/aaaa">{{ $t('header.navigation.unknown') }}</router-link>
    </div>
  </header>
</template>
