<template>
    <p v-if="note">タイトル:{{note['title']}},本文:{{note['content']}}</p>
    <button @click='throwAway(note.id)'>削除</button>
</template>

<script>
import axios from 'axios'

export default {
  name: 'Note',
  props: {
    note :Object
  },
  data(){
    return{
      err:''
  }
  },
  methods: {
    throwAway(noteId){
      axios.post('http://localhost:3000/api/v1/notes/trash', {id: noteId, user_id:'1'})
      .catch((err) => {
        this.err = err
      })
    }
  }
}
</script>