<template>
  <div>
      <input placeholder="新しいラベルを作成" v-model="inputValue">
      <button @click="createLabel()">ラベルを作成</button>
  </div>
</template>

<script>
import axios from 'axios'
import { ref, inject } from 'vue'
import { API } from '../const'

export default {
  name: 'LabelInputField',

  setup(){
    let err = ref('')
    let inputValue = ref('')

    let labelList = ref('')
    const getLabels = inject('getLabels')
    labelList.value = getLabels
    const setLabels = inject('setLabels')

    const createLabel = () => {
      const labels = labelList.value._value

      if (!inputValue.value) {
        return
      }
      
      for (let label of labels){
        if (inputValue.value === label.name){
          alert('同名のラベルが既に存在するため、作成できません。')
          return
        }
      }
      
      axios.post(API.LABELS, {name: inputValue.value, user_id: '1'})
      .then( response => {
        setLabels(response.data.data)
      })
      .catch((e) => {
        err.value = e
      })
    }

    return{
      createLabel,
      inputValue
    }
  }
}
</script>
