<template>
  <div>
    <br>
    <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <ul v-if="noteList" class="note-list"> 
          <li v-for="n of noteList.data.length" :key="n">
            <NoteListItem 
              :note="noteList.data[n-1]" 
              :labelList="labelList">
            </NoteListItem>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import NoteListItem from './NoteListItem.vue'

export default {
  name: 'NoteList',
  components: {
    NoteListItem
  },

  props: {
    noteList: {},
    labelList:{}
  },
}
</script>

<style scoped>
.note-list{
  list-style: none;
  padding: 0;
  margin: 0;
}

</style>