<template>
  <div>
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
      list: ''
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
  }
  }
}
</script>