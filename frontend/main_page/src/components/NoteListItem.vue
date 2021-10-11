<template>
  <div v-if="note">
    <p>{{note}}</p>
    <p>タイトルと本文</p>
    <input type="checkbox">
    <input type="text" v-model="innerNote['title']">
    <input type="text" v-model="innerNote['content']">
    <button @click='throwAway(note.id)'>削除</button>
    </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'NoteListItem',
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
    },
  },
  computed: {
    innerNote: {
      get(){
        return this.$props.note
      },
    }
  }
}
</script>