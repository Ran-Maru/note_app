<template>
  <div>
    <br>
    <button @click="getNoteList()">メモ</button>
    <br>
    <button>リマインダー</button>
    <ul v-if="labelList" class="label-list">
      <li v-for="n of labelList.length" :key="n">
        <button @click="getLabeledNoteList(labelList[n-1].id)">
          {{labelList[n-1].name}}
        </button>
      </li>
    </ul>
    <LabelEditDialog :labelList="labelList"></LabelEditDialog>
    <br>
    <button @click="getArchivedList()">アーカイブ</button>
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
      content.emit('getNoteList')
    }

    const getLabeledNoteList = (labelId) => {
      const params = {"label_id": labelId}
      content.emit('getNoteList', params)
    }

    const getArchivedList = () => {
      const params = {"is_archived": true}
      content.emit('getNoteList', params)
    }

    const getTrashList = () => {
      const params = {"is_trash": true}
      content.emit('getNoteList', params)
    }

    return{
      getNoteList,
      getLabeledNoteList,
      getArchivedList,
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
