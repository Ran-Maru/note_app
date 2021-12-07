<template>
  <div>
    <input type="search" v-model='searchWords' @blur="offFocus" placeholder="検索">
  </div>
</template>

<script>
import axios from 'axios'
import { ref, watch }from 'vue'
import { API } from '../const'

export default {
  name: 'SearchBox',
  emits: ['setNotes'],
  setup(_, content){
    let searchWords = ref('')

    // TODO: 検索ボックスのクリアボタン押下時にメイン画面に（すべてのメモ表示）戻す。
    watch(searchWords, () => searchNotes());

    const searchNotes = () => {
      if(searchWords.value.length < 2){
        return
      }

      axios.post(API.NOTES_SEARCH, 
      {user_id:'1', search_word: searchWords.value})
      .then( response => {
        content.emit('setNotes', response.data)
      })
    }

    // 未入力状態でカーソルが外れると、メインメニューのメモボタンが押された状態になる。
    const offFocus = () => {
      if(searchWords.value.length >= 1){
        return
      }
      document.getElementById("notes-button").click();
    }

    return{
      searchWords,
      offFocus
    }
  }
}
</script>

