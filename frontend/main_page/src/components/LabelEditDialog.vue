<template>
  <div>
    <button @click="openModal">ラベルの編集</button>
    <div id="overlay" v-show="showContent">
      <div id="content">
        <p>ラベルの編集</p>
        <input placeholder="新しいラベルを作成"><button>ラベルを作成</button>
        <ul v-if="labelList" class="label-list">
          <li v-for="n of labelList.length" :key="n">
            <button>削除</button>
            <input v-bind:value="labelList[n-1].name">
            <button>更新</button>
          </li>
        </ul>
        <button @click="closeModal">閉じる</button>
      </div>
    </div>
  </div>
</template>

<script>
import { ref }from 'vue'

export default {
  name: 'LabelEditDialog',
  props: {
    labelList:{}
  },

  setup(){
    let showContent = ref(false)

    const openModal = () => {
      showContent.value = true
    }
  
    const closeModal = () => {
      showContent.value = false
    }

    return{
      showContent,
      openModal,
      closeModal
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

#content{
  z-index:2;
  width:50%;
  padding: 1em;
  background:#fff;
}

.label-list{
  list-style: none;
  padding: 0;
  margin: 0;
}

</style>