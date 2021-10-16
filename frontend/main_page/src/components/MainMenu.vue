<template>
  <div>
    <button @click="getLabelList()">ラベル取得一覧取得</button>
    <br>
    <button>リマインダー</button>
    <ul>
      <li v-for="n of length" :key="n">
        <button>{{labels[n-1].name}}</button>
      </li>
    </ul>
    <br>
    <button>ラベルの編集</button>
    <br>
    <button>アーカイブ</button>
    <br>
    <button>ゴミ箱</button>
  </div>
</template>

<script>
import axios from 'axios'
import { ref }from 'vue'

export default {
  name: 'MainMenu',
  setup(){
    let labels = ref('')
    let length = ref('')

    const getLabelList = () => {
      axios.get('http://localhost:3000/api/v1/labels')
      .then( response => {
        labels.value = response.data
        length.value = labels.value.length
      })
      .catch((err) => {
        labels = err
      })
    }

    return {
      labels,
      length,
      getLabelList
    }

  }
}


</script>