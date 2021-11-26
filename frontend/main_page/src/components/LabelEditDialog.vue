<template>
  <div>
    <a class="nav-link" type="button" data-bs-toggle="modal" data-bs-target="#labelEditModal">ラベルの編集</a>
    <div class="modal" id="labelEditModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <h7 class="modal-title">ラベルの編集</h7>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
          <LabelInputField/>
          <ul v-if="labelList" class="label-list">
              <li v-for="n of labelList.length" :key="n">
                <button @click='deleteLabel(labelList[n-1])'>削除</button>
                <input type="text" :value="propsLabels[n-1].name">
                <button @click='renameLabel(labelList, n-1, $event)'>更新</button>
                <p>{{ labelList[n-1 ]}}</p>
              </li>
            </ul>
          </div>
          <div class="modal-footer">
            <button type="button" data-bs-dismiss="modal">閉じる</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { ref, computed, inject } from 'vue'
import { API } from '../const'
import LabelInputField from './LabelInputField.vue'

export default {
  name: 'LabelEditDialog',
  components: {
    LabelInputField
  },
  props: {
    labelList:{}
  },

  setup(props){
    let err = ref('')
    const propsLabels = computed(() => props.labelList )
    const setLabels = inject('setLabels')

    const deleteLabel = (label) => {
      const params = { user_id: '1'}
      axios.delete(API.LABELS + label.id, {data: params})
      .then( response => {
        setLabels(response.data.data)
      })
      .catch((e) => {
        err.value = e
      })
    }

    const renameLabel = (labelList, nth, event) => { 
      // 処理対象input要素のvalueを取得する。
      const inputValue = event.target.previousElementSibling.value
      const oldValue = labelList[nth].name
      
      if (inputValue === oldValue) {
        return
      }

      for (let label of labelList){
        if (inputValue === label.name){
          alert('同名のラベルが既に存在するため、更新できません。')
          return
        }
      }
      
      const labelId = labelList[nth].id
      
      axios.patch(API.LABELS + labelId,
        {name:inputValue, user_id:'1'})
      .then( response => {
        setLabels(response.data.data)
      })
      .catch((err) => {
        this.err.value = err
      })
    }

    return{
      propsLabels,
      deleteLabel,
      renameLabel
    }
  }
}
</script>

<style scoped>
#overlay{
  /* 要素を重ねた時の順番 */
  z-index:1;

  /* 画面全体を覆う設定 */
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background-color:rgba(0,0,0,0.5);

  /* 画面の中央に要素を表示させる設定 */
  display: flex;
  align-items: center;
  justify-content: center;
}

/* #content{
  z-index:2;
  width:50%;
  padding: 1em;
  background:#fff;
} */

.label-list{
  list-style: none;
  padding: 0;
  margin: 0;
}

</style>