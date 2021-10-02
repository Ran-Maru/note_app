<template>
  <div>
    <p>
      {{list}}
    </p>
    <button @click="getList()">一覧取得</button>
  </div>
</template>

<script>

export default {
  data(){
    return {
      list: ''
    }
  },
methods: {
  getList(){
    fetch('http://localhost:3000/api/v1/notes')
    .then( response => {
      return response.json()
    })
    .then( json => {
      this.list = json
    })
    .catch((err) => {
      this.list = err
    });
  }
  }
}
</script>