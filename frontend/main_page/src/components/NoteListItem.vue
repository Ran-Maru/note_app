<template>
  <div v-if="note">
    <p>{{note}}</p>
    <p>タイトルと本文</p>
    <input type="checkbox">
    <input type="text" v-model="innerNote['title']">
    <input type="text" v-model="innerNote['content']">
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
import { ref, onUpdated }from 'vue'

export default {
  name: 'NoteListItem',
  props: {
    note :Object,
    labelList:{}
  },
  setup(props){
    let err = ref('')

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
        box.checked  = true
      }
    }

    const update = (note) => {
      axios.patch('http://localhost:3000/api/v1/notes/' + note.id,
      {title: note.title, content: note.content, user_id:'1'})
      .catch((err) => {
        this.err.value = err
      })
    }

    const throwAway = (noteId) => {
      axios.post('http://localhost:3000/api/v1/notes/trash', {id: noteId, user_id:'1'})
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
      axios.post('http://localhost:3000/api/v1/labelings', {note_id: note.id, label_id: label.id})
      .catch((err) => {
        this.err = err
      })
    }
    
    const $_checkOff = (note, label) => {
      axios.post('http://localhost:3000/api/v1/labelings/destroy', {note_id: note.id, label_id: label.id})
      .catch((err) => {
        this.err = err
      })
    }

    onUpdated(() => {
      initCheckmark()
    })

    return {
      err,
      initCheckmark,
      update,
      throwAway,
      checkBox
    }
  },

  computed: {
    innerNote: {
      get(){
        return this.$props.note
      },
    }
  }
}
</script>

<style scoped>
.label-list{
  list-style: none;
}

</style>