<template>
  <div v-if="note">
    <p>{{note}}</p>
    <p>タイトルと本文</p>
    <input type="checkbox">
    <input type="text" v-model="innerNote['title']">
    <input type="text" v-model="innerNote['content']">
    <button @click='update(note)'>更新</button>
    <button @click='throwAway(note.id)'>削除</button>
    </div>
</template>

<script>
import axios from 'axios'
import { ref }from 'vue'


export default {
  name: 'NoteListItem',
  props: {
    note :Object
  },
  setup(){
    let err = ref('')

    const update = (note) => {
      axios.patch('http://localhost:3000/api/v1/notes/' + note.id,
      {title: note.title, content: note.content, user_id:'1'})
      .catch((err) => {
        this.err.value = err
      })
    }

    const throwAway = (noteId) => {
      axios.post('http://localhost:3000/api/v1/notes/trash', {id: noteId, user_id:'1'})
      .catch((err) => {
        this.err = err
      })
    }

    return {
      err,
      update,
      throwAway
    }
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