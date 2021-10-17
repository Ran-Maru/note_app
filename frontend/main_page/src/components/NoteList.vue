<template>
  <div>
    タイトル
    <input type="text" v-model='title'>
    内容
    <input type="text" v-model='content'>
    <button @click='postNote(title, content)'>メモ作成</button>
      <ul v-if="noteList"> 
        <li v-for="n of noteList.data.length" :key="n">
          <NoteListItem v-bind:note="noteList.data[n-1]"></NoteListItem>
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

  props: {
    noteList: {

    }
  },
  setup(props){
    let title = ref('')
    let content = ref('')

    const postNote = (title, content) => {
      axios.post('http://localhost:3000/api/v1/notes', {title: title, content: content, user_id:'1'})
      .then( response => {
        // 適切な変数に代入する。
        response.data
      })
      .catch((e) => {
        this.value = e
      })
    }

    const throwAway = (noteId) => {
      axios.post('http://localhost:3000/api/v1/notes/trash', {id: noteId, user_id:'1'})
      .catch((e) => {
        this.err = e
      })
    }
    
    return {
      notes: props.notes,
      title,
      content,
      postNote,
      throwAway
    }
  }
}
</script>