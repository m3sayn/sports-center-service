<template>
  <div class="admin-panel">
    <h2 class="panel-title">Добавить тренировку</h2>

    <form @submit.prevent="submitForm" class="training-form">
      <div class="form-group">
        <label>Название тренировки</label>
        <input
          v-model="title"
          placeholder="Название"
          required
          class="form-input"
        />
      </div>

      <div class="form-group">
        <label>Тренер</label>
        <input
          v-model="trainer"
          placeholder="ФИО тренера"
          required
          class="form-input"
        />
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Дата</label>
          <input v-model="date" type="date" required class="form-input" />
        </div>

        <div class="form-group">
          <label>Время</label>
          <input v-model="time" type="time" required class="form-input" />
        </div>

        <div class="form-group">
          <label>Количество мест</label>
          <input
            v-model="slots"
            type="number"
            min="1"
            placeholder="10"
            required
            class="form-input"
          />
        </div>
      </div>

      <div class="btn-center">
        <button type="submit" class="submit-btn">Добавить тренировку</button>
      </div>

      <p v-if="message" :class="['message', resOk ? 'success' : 'error']">
        {{ message }}
      </p>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      title: "",
      trainer: "",
      date: "",
      time: "",
      slots: "",
      message: "",
      resOk: false,
    };
  },
  methods: {
    async submitForm() {
      try {
        const res = await fetch("http://localhost:8080/api/trainings", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            title: this.title,
            trainer: this.trainer,
            date: this.date,
            time: this.time,
            slots: this.slots,
          }),
        });

        const data = await res.json();
        this.resOk = res.ok;

        if (this.resOk) {
          this.message = "Тренировка успешно добавлена!";
          this.resetForm();
        } else {
          this.message = "Ошибка: " + (data.message || "неизвестная ошибка");
        }
      } catch (err) {
        console.error(err);
        this.message = "Ошибка соединения с сервером";
        this.resOk = false;
      }
    },
    resetForm() {
      this.title = "";
      this.trainer = "";
      this.date = "";
      this.time = "";
      this.slots = "";
    },
  },
};
</script>

<style scoped>
.admin-panel {
  max-width: 800px;
  margin: 30px auto;
  padding: 25px;
  background-color: #f8fbff;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.panel-title {
  color: #2c3e50;
  text-align: left;
  margin-bottom: 25px;
  font-size: 24px;
}

.training-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-row {
  display: flex;
  gap: 20px;
}

.form-group {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
  text-align: left;
}

.form-group label {
  color: #2c3e50;
  font-weight: 500;
  font-size: 14px;
}

.form-input {
  padding: 12px 15px;
  border: 1px solid #d4e3ff;
  border-radius: 6px;
  background-color: white;
  font-size: 16px;
  transition: all 0.3s ease;
}

.form-input:focus {
  border-color: #1a73e8;
  box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.1);
  outline: none;
}

.form-input::placeholder {
  color: #b3c5e5;
}
.btn-center {
  justify-content: center;
}
.submit-btn {
  background-color: #1a73e8;
  color: white;
  width: 200px;
  border: none;
  padding: 12px 20px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-top: 10px;
}

.submit-btn:hover {
  background-color: #0d47a1;
  transform: translateY(-2px);
}

.submit-btn:active {
  transform: translateY(0);
}

.message {
  position: relative;
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
  width: fit-content;
  max-width: 80%;
  padding: 12px 20px;
  border-radius: 6px;
  margin: 20px 0;
  box-sizing: border-box;
  display: inline-block;
}

.message.success {
  background-color: #e6f7e6;
  color: #2e7d32;
  border: 1px solid #a5d6a7;
}

.message.error {
  background-color: #ffebee;
  color: #c62828;
  border: 1px solid #ef9a9a;
}

@media (max-width: 768px) {
  .form-row {
    flex-direction: column;
    gap: 15px;
  }

  .admin-panel {
    padding: 20px 15px;
    margin: 15px;
  }

  .panel-title {
    font-size: 20px;
  }
}
</style>
