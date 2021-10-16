<template>
  <MainMenu/>
  <NoteList/>
</template>

<script>
import MainMenu from './components/MainMenu.vue'
import NoteList from './components/NoteList.vue'

export default {
  name: 'App',
  components: {
    NoteList,
    MainMenu
  }
}
</script>
