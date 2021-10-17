<template>
  <div>
    <br>
    <button>リマインダー</button>
    <ul v-if="labelList">
      <li v-for="n of labelList.length" :key="n">
        <button>{{labelList[n-1].name}}</button>
      </li>
    </ul>
    <button>ラベルの編集</button>
    <br>
    <button>アーカイブ</button>
    <br>
    <button>ゴミ箱</button>
  </div>
</template>

<script>
export default {
  name: 'MainMenu',

  props: {
    labelList:{}
  },

  setup(){

  }
}

</script>