<template>
  <div>
    <br>
    <button @click="getNoteList()">メモ</button>
    <br>
    <button>リマインダー</button>
    <ul v-if="labelList" class="label-list">
      <li v-for="n of labelList.length" :key="n">
        <button>{{labelList[n-1].name}}</button>
      </li>
    </ul>
    <LabelEditDialog :labelList="labelList"></LabelEditDialog>
    <br>
    <button>アーカイブ</button>
    <br>
    <button @click="getTrashList()">ゴミ箱</button>
  </div>
</template>

<script>
import LabelEditDialog from './LabelEditDialog.vue'

export default {
  name: 'MainMenu',
  components: {
    LabelEditDialog
  },

  props: {
    labelList:{}
  },

  emits: ['getNoteList'],

  setup(_, content){
    const getNoteList = () => {
      content.emit('getNoteList', false)
    }

    const getTrashList = () => {
      content.emit('getNoteList',true)
    }

    return{
      getNoteList,
      getTrashList
    }
  }
}

</script>

<style scoped>
.label-list{
  list-style: none;
  padding: 0;
  margin: 0;
}

</style>
