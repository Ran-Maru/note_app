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
import NoteListItem from './NoteListItem.vue'
import { ref }from 'vue'

export default {
  name: 'NoteList',
  components: {
    NoteListItem
  },
  setup(){
    let notes = ref('')
    let length = ref('')
    let title = ref('')
    let content = ref('')

    const getList = () => {
      axios.get('http://localhost:3000/api/v1/notes ')
    .then( response => {
      notes.value = response.data
      length.value = notes.value.data.length
    })
    .catch((err) => {
      notes = err
    })
    }

    const postNote = (title, content) => {
      axios.post('http://localhost:3000/api/v1/notes', {title: title, content: content, user_id:'1'})
      .then( response => {
        // 適切な変数に代入する。
        response.data
      })
      .catch((err) => {
        notes.value = err
      })

    }

    const throwAway = (noteId) => {
      axios.post('http://localhost:3000/api/v1/notes/trash', {id: noteId, user_id:'1'})
      .catch((err) => {
        this.err = err
      })
    }
    
    return {
      notes,
      length,
      title,
      content,
      getList,
      postNote,
      throwAway
    }
  }
}
</script>