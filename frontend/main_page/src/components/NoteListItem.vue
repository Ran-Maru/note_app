<template>
  <div v-if="note">
    <p>{{note}}</p>
    <p>タイトルと本文</p>
    <input type="checkbox">
    <input type="text" v-model="propsNote['title']">
    <textarea v-model="propsNote['content']"></textarea>
    <button @click='update(note)'>更新</button>
    <button @click='throwAway(note.id)'>削除</button>
      <ul v-if="labelList" class="label-list">
        <li v-for="n of labelList.length" :key="n">
           <input type="checkbox" :id="'label' + note.id + labelList[n-1].id" @change="checkBox(note, labelList[n-1])">
           {{ labelList[n-1].name}}
        </li>
      </ul>
    </div>
</template>

<script>
import axios from 'axios'
import { ref, computed, onUpdated } from 'vue'
import { API } from '../const'

export default {
  name: 'NoteListItem',
  props: {
    note :Object,
    labelList:{}
  },
  setup(props){
    let err = ref('')
    const propsNote = computed(() => props.note ).value

    const initCheckmark = () => {
      const note = props.note
      const labelList = props.labelList
      
      //すべてのチェックボックスのチェックを外す。
      for(const label of labelList) {
        const box = document.getElementById("label" + note.id +  label.id)
        box.checked  = false
      }
      
      // 該当のチェックボックスにチェックを入れる。
      for(const attachedLabel of note.labels) {
        const box = document.getElementById("label" + note.id + attachedLabel.id)
        if (box){
          box.checked  = true
        }
      }
    }

    const update = (note) => {
      axios.patch(API.NOTES + note.id,
      {title: note.title, content: note.content, user_id:'1'})
      .catch((err) => {
        this.err.value = err
      })
    }

    const throwAway = (noteId) => {
      axios.post(API.NOTES_TRASH, {id: noteId, user_id:'1'})
      .catch((err) => {
        this.err = err
      })
    }

    const checkBox = (note, label) => {
      const isChecked = document.getElementById("label" + note.id + label.id).checked
      if (isChecked) {
        $_checkOn(note, label)
      } else {
        $_checkOff(note, label)
      }
    }

    const $_checkOn = (note, label) => {
      axios.post(API.LABELINGS, {note_id: note.id, label_id: label.id})
      .catch((err) => {
        this.err = err
      })
    }
    
    const $_checkOff = (note, label) => {
      axios.post(API.LABELINGS_DESTROY, {note_id: note.id, label_id: label.id})
      .catch((err) => {
        this.err = err
      })
    }

    onUpdated(() => {
      initCheckmark()
    })

    return {
      err,
      propsNote,
      initCheckmark,
      update,
      throwAway,
      checkBox
    }
  },
}
</script>

<style scoped>
.label-list{
  list-style: none;
}

</style>