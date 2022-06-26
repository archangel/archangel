import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import About from '../views/About.vue'
import Contact from '../views/Contact.vue'
import NotFound from '../views/NotFound.vue'

const routes = [
  {
    path: '/',
    name: 'home_path',
    component: Home
  },
  {
    path: '/about',
    name: 'about_path',
    component: About,
  },
  {
    path: '/contact',
    name: 'contact_path',
    component: Contact,
  },
  {
    path: '/:pathMatch(.*)',
    component: NotFound
  }
]
const router = createRouter({
  history: createWebHistory(),
  routes
})
export default router
