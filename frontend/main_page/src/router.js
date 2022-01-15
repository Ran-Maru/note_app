import SignUp from './components/SignUp.vue'
import Login from './components/Login.vue'
import Main from './components/Main.vue'
import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(),
  routes: [
      { path: '/', component: Main },
      { path: '/signUp', component: SignUp },
      { path: '/login', component: Login },
      { path: '/main', component: Main }
  ]
})

export { router }
