<template>
  <button @click="getNoteList()">一覧取得</button>
  <button @click="getLabelList()">ラベル一覧取得</button>
  <SearchBox @setNotes="setNotes"></SearchBox>
  <MainMenu 
    :labelList="labels"  
    @getNoteList="getNoteList"
    @setLabels="setLabels"
    ></MainMenu>
  <NoteList :noteList="notes" :labelList="labels"></NoteList>
</template>

<script>
import { ref, onMounted, provide }from 'vue'
import axios from 'axios'
import { API } from './const'
import MainMenu from './components/MainMenu.vue'
import NoteList from './components/NoteList.vue'
import SearchBox from './components/SearchBox.vue'

export default {
  name: 'App',
  components: {
    NoteList,
    MainMenu,
    SearchBox
},
  setup(){
    let notes = ref('')
    let labels = ref('')
    let err = ref('')
    
    const getNoteList = (params) => {
      axios.get(API.NOTES, {
        params
      })
      .then( response => {
        notes.value = response.data
    })
      .catch((e) => {
        err.value = e
    })
    }

    const getLabelList = () => {
      axios.get(API.LABELS)
      .then( response => {
        labels.value = response.data
      })
      .catch((e) => {
        err.value = e
      })
    }

    const setLabels = (param) => {
      labels.value = param
    }

    const setNotes = (param) => {
      notes.value = param
    }

    provide('setLabels', setLabels)
    provide('setNotes', setNotes)

    onMounted (()=> {
      getNoteList()
      getLabelList()
    })

    return{
      getNoteList,
      getLabelList,
      setLabels,
      notes,
      labels,
      setNotes
    }
  }
}
</script>
