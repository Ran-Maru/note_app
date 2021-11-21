<template>
  <div>
    <button v-if="!postFormVisible" @click="toggleForm">メモを入力</button>
    <div v-if="postFormVisible">
      <input type="text" v-model='title' placeholder="タイトル">
      <textarea v-model='content' placeholder="メモを入力..."></textarea>
      <button @click='postNote(title, content)'>メモ作成</button>
      <button @click="toggleForm">保存せずに閉じる</button>
    </div>
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
import NoteListItem from './NoteListItem.vue'
import { ref }from 'vue'
import { API } from '../const'

export default {
  name: 'NoteList',
  components: {
    NoteListItem
  },

  props: {
    noteList: {},
    labelList:{}
  },
  setup(props){
    let title = ref('')
    let content = ref('')
    let postFormVisible = ref(false)

    // 表示・非表示を切り替える。
    const toggleForm = () => {
      postFormVisible.value = !postFormVisible.value
      // 入力フォーム初期化
      title.value = ''
      content.value = ''
    }

    const postNote = (title, content) => {
      axios.post(API.NOTES, {title: title, content: content, user_id:'1'})
      .then( response => {
        // 適切な変数に代入する。
        response.data
      })
      .catch((e) => {
        this.value = e
      })
      toggleForm()
    }

    const throwAway = (noteId) => {
      axios.post(API.NOTES_TRASH, {id: noteId, user_id:'1'})
      .catch((e) => {
        this.err = e
      })
    }
    
    return {
      notes: props.notes,
      title,
      content,
      postFormVisible,
      toggleForm,
      postNote,
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