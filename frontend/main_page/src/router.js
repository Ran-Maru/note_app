import SignUp from './components/SignUp.vue'
import Login from './components/Login.vue'
import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(),
  routes: [
      { path: '/signUp', component: SignUp },
      { path: '/login', component: Login }
  ]
})

export { router }
