<template>
  <div>
  <p>メモにつけるラベル</p>
    <div v-if="labelList">
      <ul v-if="labelList" class="label-list">
        <li v-for="n of labelList.value.length" :key="n">
           <input type="checkbox" :id="'label' + note.id + labelList.value[n-1].id" @change="checkBox(note, labelList.value[n-1])">
           {{ labelList.value[n-1].name}}
        </li>
      </ul>
    </div>  
  </div>
</template>

<script>
import axios from 'axios'
import { ref, inject, onUpdated } from 'vue'
import { API } from '../const'

export default {
  name: 'LabelCheckList',
  props: {
    note :Object,
  },
  setup(props){
    let err = ref('')

    let labelList = ref('')
    const getLabels = inject('getLabels')
    labelList.value = getLabels

    const initCheckmark = () => {
      const note = props.note
      const labels = labelList.value._value

      //すべてのチェックボックスのチェックを外す。
      for(const label of labels) {
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
      labelList,
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