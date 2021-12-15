<template>
  <div>
    <nav class="nav nav-pills flex-column" id="main-menu">
      <a class="nav-link" href="#" @click="getNoteList($event)" id="notes-button">メモ</a>
      <a class="nav-link" href="#">リマインダー</a>
      <ul v-if="labelList" class="label-list">
        <li v-for="n of labelList.length" :key="n">
          <a class="nav-link" href="#" @click="getLabeledNoteList(labelList[n-1].id, $event)">
            {{labelList[n-1].name}}
          </a>
        </li>
      </ul>
      <a class="nav-link" type="button" data-bs-toggle="modal" data-bs-target="#labelEditModal">ラベルの編集</a>
      <a class="nav-link" href="#" @click="getArchivedList($event)">アーカイブ</a>
      <a class="nav-link" href="#" @click="getTrashList($event)">ゴミ箱</a>
    </nav>
  </div>
</template>

<script>
export default {
  name: 'MainMenu',

  props: {
    labelList:{}
  },

  emits: ['getNoteList'],

  setup(_, content){
    const getNoteList = ($event) => {
      _activeNav($event)
      content.emit('getNoteList')
    }

    const getLabeledNoteList = (labelId, $event) => {
      _activeNav($event)
      const params = {"label_id": labelId}
      content.emit('getNoteList', params)
    }

    const getArchivedList = ($event) => {
      _activeNav($event)
      const params = {"is_archived": true}
      content.emit('getNoteList', params)
    }

    const getTrashList = ($event) => {
      _activeNav($event)
      const params = {"is_trash": true}
      content.emit('getNoteList', params)
    }

    // 選択されたnav要素にアクティブ状態のスタイルを設定する。
    const _activeNav = ($event) => {
      // アクティブ状態を初期化する。
      // id="main-menu"のDOM内で、アクティブ状態になっているnav-linkのリストを取得する。
      const nav = document.getElementById("main-menu")
      const activeNavLinks = nav.getElementsByClassName('nav-link active');
      // アクティブ状態になっているnavLinkがある場合、初期化処理をおこなう。
      if (activeNavLinks.length > 0 ){
        // アクティブ状態となるnav-linkは常に1つのため、0番目の要素にのみ処理をおこなう。
        activeNavLinks[0].classList.remove("active")
      }

      // スタイルを設定する。
      const navLink = $event.target
      navLink.classList.add("active")
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
