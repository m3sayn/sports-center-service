<template>
  <div class="profile-container">
    <div class="profile-header">
      <h2>Мой профиль</h2>
      <button @click="logout" class="logout-btn">Выйти</button>
    </div>

    <div class="profile-info">
      <p><strong>Имя пользователя:</strong> {{ name }}</p>
      <p><strong>Email:</strong> {{ email }}</p>
    </div>

    <div class="trainings-section">
      <h3>Мои записи</h3>
      <ul v-if="trainings.length" class="trainings-list">
        <li v-for="t in trainings" :key="t.id" class="training-item">
          <div class="training-details">
            <span class="training-title">{{ t.title }}</span>
            <span class="training-meta"
              >{{ formatDate(t.date) }} {{ formatTime(t.time) }} |
              {{ t.trainer }}</span
            >
          </div>
          <button @click="cancel(t.id)" class="cancel-btn">Отменить</button>
        </li>
      </ul>
      <p v-else class="no-trainings">У вас нет записей</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: "",
      email: "",
      trainings: [],
    };
  },
  async mounted() {
    const email = localStorage.getItem("userEmail");
    const name = localStorage.getItem("name");
    if (!email) {
      this.$router.push("/login");
      return;
    }
    this.name = name;
    this.email = email;

    try {
      const res = await fetch(
        `http://localhost:8080/api/trainings/my/${email}`
      );
      const data = await res.json();
      this.trainings = data;
    } catch (err) {
      console.error("Ошибка при загрузке записей:", err);
    }
  },
  methods: {
    logout() {
      localStorage.removeItem("userEmail");
      this.$router.push("/login");
    },
    async cancel(id) {
      const userEmail = localStorage.getItem("userEmail");
      if (!userEmail) {
        alert("Вы не авторизованы");
        return;
      }

      const confirmDelete = confirm("Вы точно хотите отменить запись?");
      if (!confirmDelete) return;

      try {
        const res = await fetch(
          `http://localhost:8080/api/trainings/${id}/unbook`,
          {
            method: "DELETE",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ userEmail }),
          }
        );

        const data = await res.json();

        if (res.ok) {
          alert(data.message);
          this.trainings = this.trainings.filter((t) => t.id !== id);
        } else {
          alert("Ошибка: " + data.message);
        }
      } catch (err) {
        console.error(err);
        alert("Ошибка соединения с сервером");
      }
    },
    formatDate(dateString) {
      const options = { weekday: "short", day: "numeric", month: "long" };
      return new Date(dateString).toLocaleDateString("ru-RU", options);
    },
    formatTime(timeString) {
      return timeString.slice(0, 5);
    },
  },
};
</script>

<style scoped>
.profile-container {
  max-width: 800px;
  margin: 30px auto;
  padding: 20px;
  background-color: #f8fbff;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.profile-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px solid #d4e3ff;
}

h2 {
  color: #2c3e50;
  font-size: 24px;
}

h3 {
  color: #2c3e50;
  margin: 20px 0 15px;
  font-size: 20px;
}

.profile-info {
  background-color: #e6f2ff;
  padding: 15px;
  border-radius: 10px;
  margin-bottom: 20px;
  text-align: left;
}

.profile-info p {
  margin: 0;
  color: #2c3e50;
  font-size: 16px;
}
.trainings-section {
  text-align: left;
}
.trainings-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.training-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px;
  margin-bottom: 10px;
  background-color: white;
  border-radius: 10px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.training-item:hover {
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}

.training-details {
  display: flex;
  flex-direction: column;
}

.training-title {
  font-weight: 600;
  color: #2c3e50;
  margin-bottom: 5px;
}

.training-meta {
  color: #7f8c8d;
  font-size: 14px;
}

.no-trainings {
  color: #7f8c8d;
  text-align: center;
  padding: 20px;
}

.logout-btn,
.cancel-btn {
  padding: 8px 16px;
  border: none;
  border-radius: 7px;
  cursor: pointer;
  font-weight: 500;
  transition: all 0.3s ease;
}

.logout-btn {
  background-color: #e6f2ff;
  color: #1a73e8;
  border: 1px solid #1a73e8;
}

.logout-btn:hover {
  background-color: #1a73e8;
  color: white;
}

.cancel-btn {
  background-color: #ffe6e6;
  color: #e74c3c;
  border: 1px solid #e74c3c;
}

.cancel-btn:hover {
  background-color: #e74c3c;
  color: white;
}

@media (max-width: 768px) {
  .profile-container {
    padding: 15px;
    margin: 15px;
  }

  .training-item {
    flex-direction: column;
    align-items: flex-start;
  }

  .cancel-btn {
    margin-top: 10px;
    align-self: flex-end;
  }
}
</style>
