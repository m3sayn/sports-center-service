<template>
  <div>
    <h2>Мои записи</h2>
    <ul v-if="trainings.length">
      <li v-for="t in trainings" :key="t.id">
        {{ t.title }} — {{ t.trainer }} — {{ t.date }} в {{ t.time }}
        <button @click="cancel(t.id)">Отменить</button>
      </li>
    </ul>
    <p v-else>У вас нет записей</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      trainings: [],
    };
  },
  async mounted() {
    const email = localStorage.getItem("userEmail");
    if (!email) {
      this.$router.push("/login");
      return;
    }

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
  methods: {
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
