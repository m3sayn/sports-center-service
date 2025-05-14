<template>
  <header>
    <nav class="navbar">
      <i
        v-if="userEmail"
        class="logout-icon bi-box-arrow-left"
        @click="logout"
        title="Выйти"
      ></i>
      <router-link v-if="userEmail" to="/profile">Мой профиль</router-link>
      <router-link v-if="userEmail === 'admin@mail.com'" to="/admin"
        >Админка</router-link
      ><router-link v-if="!userEmail" to="/login">Вход</router-link>
      <!-- <router-link v-if="!userEmail" to="/signup">Регистрация</router-link> -->
      <router-link to="/trainings">Тренировки</router-link>
    </nav>
    <div class="wrap-logo">
      <router-link to="/" class="logo-link">
        <img alt="Meme" src="../assets/logo.png" width="50" />
      </router-link>
    </div>
  </header>
  <hr class="header-divider" />
</template>

<script>
export default {
  data() {
    return {
      userEmail: null,
    };
  },
  mounted() {
    this.userEmail = localStorage.getItem("userEmail");
  },
  methods: {
    logout() {
      localStorage.removeItem("userEmail");
      this.userEmail = null;
      this.$router.push("/");
    },
  },
};
</script>

<style scoped>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #e6f2ff;
  padding: 15px 30px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.wrap-logo {
  margin-left: auto;
}

.logo-link {
  display: flex;
  align-items: center;
  text-decoration: none;
  color: #2c3e50;
  font-weight: bold;
  font-size: 1.2rem;
  gap: 10px;
}

.logo-link img {
  transition: transform 0.3s ease;
}

.logo-link:hover img {
  transform: scale(1.1);
}

.navbar {
  display: flex;
  gap: 20px;
  align-items: center;
}

.navbar a {
  text-decoration: none;
  color: #2c3e50;
  font-weight: 500;
  padding: 5px 10px;
  border-radius: 7px;
  transition: all 0.3s ease;
}

.navbar a:hover {
  background-color: #cce0ff;
  color: #1a73e8;
}

.navbar a.router-link-exact-active {
  color: #1a73e8;
  border-bottom: 2px solid #1a73e8;
}

.header-divider {
  border: none;
  background-color: #b3d1ff;
  height: 1px;
  width: 100%;
  margin: 0;
}
.logout-icon {
  font-size: 1.5rem;
  color: #1a73e8;
  cursor: pointer;
  transition: all 0.3s ease;
  padding: 5px;
  border-radius: 4px;
}

.logout-icon:hover {
  color: #0d47a1;
  background-color: rgba(26, 115, 232, 0.1);
  transform: scale(1.1);
}

.logout-icon:active {
  transform: scale(0.95);
}
</style>
