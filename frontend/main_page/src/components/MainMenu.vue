<template>
  <div>
    <br>
    <button>リマインダー</button>
    <ul v-if="labelList">
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
    const getTrashList = () => {
      content.emit('getNoteList',true)
    }

    return{
      getTrashList,
    }
  }
}

</script>
