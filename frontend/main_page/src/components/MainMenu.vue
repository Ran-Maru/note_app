<template>
  <div>
    <nav class="nav nav-pills flex-column">
      <a class="nav-link" href="#" @click="getNoteList()" id="notes-button">メモ</a>
      <a class="nav-link" href="#">リマインダー</a>
      <ul v-if="labelList" class="label-list">
        <li v-for="n of labelList.length" :key="n">
          <a class="nav-link" href="#" @click="getLabeledNoteList(labelList[n-1].id)">
            {{labelList[n-1].name}}
          </a>
        </li>
      </ul>
      <LabelEditDialog :labelList="labelList"></LabelEditDialog>
      <a class="nav-link" href="#" @click="getArchivedList()">アーカイブ</a>
      <a class="nav-link" href="#" @click="getTrashList()">ゴミ箱</a>
    </nav>
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
