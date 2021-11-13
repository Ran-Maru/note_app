<template>
  <div v-if="note">
    <p>{{note}}</p>
    <p>タイトルと本文</p>
    <input type="checkbox">
    <input type="text" v-model="propsNote['title']">
    <textarea v-model="propsNote['content']"></textarea>
    <button @click='update(note)'>更新</button>
    <button @click='throwAway(note.id)'>削除</button>
    <LabelCheckList :note="note"></LabelCheckList>
  </div>
</template>

<script>
import axios from 'axios'
import { ref, computed } from 'vue'
import { API } from '../const'
import LabelCheckList from './LabelCheckList.vue'

export default {
  name: 'NoteListItem',  
  components: {
    LabelCheckList
  },
  props: {
    note :Object,
    labelList:{}
  },
  setup(props){
    let err = ref('')
    const propsNote = computed(() => props.note ).value

    const update = (note) => {
      axios.patch(API.NOTES + note.id,
      {title: note.title, content: note.content, user_id:'1'})
      .catch((err) => {
        this.err.value = err
      })
    }

    const throwAway = (noteId) => {
      axios.post(API.NOTES_TRASH, {id: noteId, user_id:'1'})
      .catch((err) => {
        this.err = err
      })
    }

    return {
      err,
      propsNote,
      update,
      throwAway,
    }
  },
}
</script>

<style scoped>
.label-list{
  list-style: none;
}

</style>