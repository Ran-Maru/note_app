  <template>
    <h1>ログインのページ</h1>
    <input type="text" v-model="id" placeholder="ログインID">
    <br>
    <input type="password" v-model="password" placeholder="パスワード">
    <br>
    <button @click="login">ログイン</button>
  </template>

  <script>
    import { ref }from 'vue'

    export default {
      name: 'Login',
      setup(){
        let id = ref('')
        let password = ref('')

        const login = () =>{
          // ログインAPI実行
          console.log(id.value + password.value)
        }
        return{
          id,
          password,
          login
        }
      }
    }
  </script>
