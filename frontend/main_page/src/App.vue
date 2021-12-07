<template>
  <div>
    <header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
      <button @click="getNoteList()">一覧取得</button>
      <button @click="getLabelList()">ラベル一覧取得</button>
      <SearchBox @setNotes="setNotes"></SearchBox>
    </header>
    <MainMenu 
      :labelList="labels"  
      @getNoteList="getNoteList"
      @setLabels="setLabels"
      ></MainMenu>
    <NotePostField></NotePostField>
    <NoteList :noteList="notes" :labelList="labels"></NoteList>
  </div>
</template>

<script>
import { ref, onMounted, provide }from 'vue'
import axios from 'axios'
import { API } from './const'
import MainMenu from './components/MainMenu.vue'
import NotePostField from './components/NotePostField.vue'
import NoteList from './components/NoteList.vue'
import SearchBox from './components/SearchBox.vue'

export default {
  name: 'App',
  components: {
    NoteList,
    MainMenu,
    NotePostField,
    SearchBox,
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

    const getLabels = () => labels

    const setNotes = (param) => {
      notes.value = param
    }

    provide('setLabels', setLabels)
    provide('setNotes', setNotes)
    provide('getLabels', getLabels())

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
