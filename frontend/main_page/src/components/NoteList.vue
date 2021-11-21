<template>
  <div>
      <NotePostField></NotePostField>
      <ul v-if="noteList" class="note-list"> 
        <li v-for="n of noteList.data.length" :key="n">
          <NoteListItem 
            :note="noteList.data[n-1]" 
            :labelList="labelList">
          </NoteListItem>
        </li>
      </ul>
  </div>
</template>

<script>
import axios from 'axios'
import NotePostField from './NotePostField.vue'
import NoteListItem from './NoteListItem.vue'
import { API } from '../const'

export default {
  name: 'NoteList',
  components: {
    NotePostField,
    NoteListItem
  },

  props: {
    noteList: {},
    labelList:{}
  },
  setup(props){

    const throwAway = (noteId) => {
      axios.post(API.NOTES_TRASH, {id: noteId, user_id:'1'})
      .catch((e) => {
        this.err = e
      })
    }
    
    return {
      notes: props.notes,
      throwAway
    }
  }
}
</script>

<style scoped>
.note-list{
  list-style: none;
  padding: 0;
  margin: 0;
}

</style>