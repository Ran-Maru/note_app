<template>
  <div>
    <header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
      <button @click="getNoteList()">一覧取得</button>
      <button @click="getLabelList()">ラベル一覧取得</button>
      <SearchBox @setNotes="setNotes"></SearchBox>
    </header>
    <div class="container-fluid">
      <div class="row">
        <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse"
          style="overflow-y: auto; position: fixed; top:20px; height: 600px;">
          <div class="position-sticky pt-3">
            <MainMenu 
              :labelList="labels"  
              @getNoteList="getNoteList"
              @setLabels="setLabels"
              ></MainMenu>
          </div>
        </nav>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
          <NotePostField></NotePostField>
          <NoteList :noteList="notes" :labelList="labels"></NoteList>
        </main>
      </div>
    </div>
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
