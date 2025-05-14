import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/login",
    name: "login",
    component: () => import("../views/LoginView.vue"),
  },
  {
    path: "/signup",
    name: "signup",
    component: () => import("../views/RegisterView.vue"),
  },
  {
    path: "/schedule",
    name: "schedule",
    component: () => import("../views/ScheduleView.vue"),
  },
  {
    path: "/profile",
    name: "profile",
    component: () => import("../views/UserProfile.vue"),
  },
  {
    path: "/trainings",
    name: "trainings",
    component: () => import("../views/TrainingsView.vue"),
  },
  {
    path: "/my-trainings",
    name: "my-trainings",
    component: () => import("../views/MyTrainingsView.vue"),
  },
  {
    path: "/admin",
    name: "admin",
    component: () => import("../views/AdminPanelView.vue"),
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
