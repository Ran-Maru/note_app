<template>
  <div>
    タイトル
    <input type="text" v-model='title'>
    内容
    <input type="text" v-model='content'>
    <button @click='postNote(title, content)'>メモ作成</button>
    <button @click="getList()">一覧取得</button>
      <ul> 
        <li v-for="n of length" :key="n">
          <NoteListItem v-bind:note="notes.data[n-1]"></NoteListItem>
        </li>
      </ul>
    </div>
</template>

<script>
import axios from 'axios'
import NoteListItem from './components/NoteListItem.vue'

export default {
  name: 'App',
  components: {
    NoteListItem
  },
  data(){
    return {
      notes: '',
      length: '',
      title:'',
      content: ''
    }
  },
methods: {
  getList(){
    axios.get('http://localhost:3000/api/v1/notes ')
    .then( response => {
      this.notes = response.data
      this.length = this.notes.data.length
    })
    .catch((err) => {
      this.notes = err
    })
  },
    postNote(title, content){
      axios.post('http://localhost:3000/api/v1/notes', {title: title, content: content, user_id:'1'})
      .then( response => {
        // 適切な変数に代入する。
        response.data
      })
      .catch((err) => {
        this.notes = err
      })
  },
    throwAway(noteId){
      axios.post('http://localhost:3000/api/v1/notes/trash', {id: noteId, user_id:'1'})
      .catch((err) => {
        this.err = err
      })
    },

  },
}
</script>