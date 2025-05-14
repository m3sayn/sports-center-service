<template>
  <div class="trainings-container">
    <h2 class="page-title">Расписание тренировок</h2>

    <div class="table-responsive">
      <table class="trainings-table">
        <thead>
          <tr>
            <th>Тип тренировки</th>
            <th>Тренер</th>
            <th>Дата</th>
            <th>Время</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="training in trainings" :key="training.id">
            <td>
              <strong>{{ training.title }}</strong>
            </td>
            <td>{{ training.trainer }}</td>
            <td>{{ formatDate(training.date) }}</td>
            <td>{{ formatTime(training.time) }}</td>
            <td>
              <button @click="book(training.id)" class="book-btn">
                Записаться
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      trainings: [],
    };
  },
  async mounted() {
    try {
      const res = await fetch("http://localhost:8080/api/trainings");
      const data = await res.json();
      this.trainings = data;
    } catch (err) {
      console.error("Ошибка при загрузке расписания:", err);
    }
  },
  methods: {
    async book(id) {
      const userEmail = localStorage.getItem("userEmail");

      if (!userEmail) {
        alert("Вы не авторизованы. Сначала войдите в систему.");
        return;
      }

      try {
        const res = await fetch(
          `http://localhost:8080/api/trainings/${id}/book`,
          {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ userEmail }),
          }
        );

        const data = await res.json();

        if (res.ok) {
          alert(data.message);
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
.trainings-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.page-title {
  color: #2c3e50;
  text-align: center;
  margin-bottom: 25px;
}

.table-responsive {
  overflow-x: auto;
}

.trainings-table {
  width: 100%;
  border-collapse: collapse;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
  overflow: hidden;
  text-align: left;
}

.trainings-table th {
  background-color: #1a73e8;
  color: white;
  padding: 12px 15px;
  text-align: left;
}

.trainings-table td {
  padding: 12px 15px;
  border-bottom: 1px solid #e0e0e0;
}

.trainings-table tr:last-child td {
  border-bottom: none;
}

.trainings-table tr:hover {
  background-color: #f5f9ff;
}

.book-btn {
  background-color: #1a73e8;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 7px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.book-btn:hover {
  background-color: #0d47a1;
  transform: translateY(-1px);
}

@media (max-width: 768px) {
  .trainings-table {
    font-size: 14px;
  }

  .trainings-table th,
  .trainings-table td {
    padding: 8px 10px;
  }

  .book-btn {
    padding: 6px 12px;
  }
}
</style>
