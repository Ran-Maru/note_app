<template>
  <div>
    タイトル
    <input type="text" v-model='title'>
    内容
    <input type="text" v-model='content'>
    <button @click='postNote(title, content)'>メモ作成</button>
    <p>
      {{list}}
    </p>
    <button @click="getList()">一覧取得</button>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data(){
    return {
      list: '',
      title:'',
      content: ''
    }
  },
methods: {
  getList(){
    axios.get('http://localhost:3000/api/v1/notes ')
    .then( response => {
      this.list = response.data
    })
    .catch((err) => {
      this.list = err
    });
  },
    postNote(title, content){
      axios.post('http://localhost:3000/api/v1/notes', {title: title, content: content, user_id:'1'})
      .then( response => {
        // 適切な変数に代入する。
        response.data
      })
      .catch((err) => {
        this.list = err
      })
    }
  }
}
</script>