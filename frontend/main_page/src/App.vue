<template>
  <button @click="getNoteList()">一覧取得</button>
  <button @click="getLabelList()">ラベル一覧取得</button>
  <MainMenu :labelList="labels"  @getNoteList="getNoteList"></MainMenu>
  <NoteList :noteList="notes" :labelList="labels"></NoteList>
</template>

<script>
import { ref, onMounted }from 'vue'
import axios from 'axios'

import MainMenu from './components/MainMenu.vue'
import NoteList from './components/NoteList.vue'

export default {
  name: 'App',
  components: {
    NoteList,
    MainMenu
  },
  setup(){
    let notes = ref('')
    let labels = ref('')
    let err = ref('')
    
    const getNoteList = (isTrash = false) => {
      axios.get('http://localhost:3000/api/v1/notes', {
        params: {
          isTrash: isTrash 
        }
      })
      .then( response => {
        notes.value = response.data
    })
      .catch((e) => {
        err.value = e
    })
    }

    const getLabelList = () => {
      axios.get('http://localhost:3000/api/v1/labels')
      .then( response => {
        labels.value = response.data
      })
      .catch((e) => {
        err.value = e
      })
    }

    onMounted (()=> {
      getNoteList()
      getLabelList()
    })

    return{
      getNoteList,
      getLabelList,
      notes,
      labels,
    }
  }
}
</script>
