<template>
  <div>
    <button v-if="!postFormVisible" @click="toggleForm">メモを入力</button>
    <div v-if="postFormVisible">
      <input type="text" v-model='title' @keydown.enter="moveTab"
        @compositionstart="composing=true"
        @compositionend="composing=false"
        placeholder="タイトル"
      >
      <textarea v-model='content' placeholder="メモを入力..."></textarea>
      <button @click='postNote(title, content)'>メモ作成</button>
      <button @click="toggleForm">保存せずに閉じる</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { ref }from 'vue'
import { API } from '../const'

export default {
  name: 'NotePostField',

  setup(){
    let title = ref('')
    let content = ref('')
    let postFormVisible = ref(false)
    // 日本語入力中(IME)を示すフラグ
    let composing = ref(false)

    // 表示・非表示を切り替える。
    const toggleForm = () => {
      postFormVisible.value = !postFormVisible.value
      // 入力フォーム初期化
      title.value = ''
      content.value = ''
    }

    // 日本語入力中でない場合、エンター押下時にタブを移動させる。
    const moveTab = () => {
      if (composing.value){
        return
      }
      const dom = document.activeElement
      dom.nextElementSibling.focus()
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

    return {
      title,
      content,
      postFormVisible,
      composing,
      toggleForm,
      moveTab,
      postNote,
    }
  }
}
</script>