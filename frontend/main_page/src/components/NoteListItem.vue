<template>
  <div v-if="note">
    <div class="col">
      <input type="checkbox">
      <div class="card" style="width: 18rem;">
        <div data-bs-toggle="modal" :data-bs-target="bsTarget">
          <div class="card-body">
            <h5 class="card-title"> {{note.title}}</h5>
            <p class="card-text">{{note.content}}</p>
            <div v-if="!note.title && !note.content">
              <h5 class="card-title"> 空のメモ</h5>
            </div>
          </div>
        </div>
        <div class="card-footer">
          <!-- ここにも削除ボタン等を追加する。 -->
        </div>
      </div>
    </div>
    <div class="modal" :id="modalId" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header">
            <input type="text" v-model="propsNote['title']" placeholder="タイトル">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <textarea v-model="propsNote['content']" placeholder="メモ"></textarea>
          </div>
          <div class="modal-footer">
            <button @click='update(note)' type="button" data-bs-dismiss="modal">更新</button>
            <button type="button" data-bs-dismiss="modal">閉じる</button>
            <button @click='throwAway(note.id)' type="button" data-bs-dismiss="modal">削除</button>
            <LabelCheckList :note="note"></LabelCheckList>
          </div>    
        </div>    
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { ref, computed } from 'vue'
import { API } from '../const'
import LabelCheckList from './LabelCheckList.vue'

export default {
  name: 'NoteListItem',  
  components: {
    LabelCheckList
  },
  props: {
    note :Object,
    labelList:{}
  },
  setup(props){
    let err = ref('')
    const propsNote = computed(() => props.note ).value
    // Bootstrapによるモーダル操作のために必要
    let modalId = ref('')
    modalId.value = "myModal" + propsNote.id
    let bsTarget = ref('')
    bsTarget.value = "#" + modalId.value

    const update = (note) => {
      axios.patch(API.NOTES + note.id,
      {title: note.title, content: note.content, user_id:'1'})
      .catch((err) => {
        this.err.value = err
      })
    }

    const throwAway = (noteId) => {
      axios.post(API.NOTES_TRASH, {id: String(noteId), user_id:'1'})
      .catch((err) => {
        this.err = err
      })
    }

    return {
      err,
      propsNote,
      modalId,
      bsTarget,
      update,
      throwAway,
    }
  },
}
</script>

<style scoped>
.label-list{
  list-style: none;
}

</style>