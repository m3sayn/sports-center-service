<template>
  <div class="register-container">
    <form @submit.prevent="submitForm" class="register-form">
      <h3 class="form-title">Регистрация</h3>
      <input v-model="name" placeholder="Имя" class="form-input" />
      <input
        v-model="email"
        placeholder="Email"
        type="email"
        class="form-input"
      />
      <input
        v-model="password"
        placeholder="Пароль"
        type="password"
        class="form-input"
      />
      <input
        v-model="confirmPassword"
        placeholder="Подтвердите пароль"
        type="password"
        class="form-input"
      />
      <div class="btn-center">
        <button type="submit" class="submit-btn">Зарегистрироваться</button>
      </div>
      <p v-if="error" class="error-message">{{ error }}</p>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: "",
      email: "",
      password: "",
      confirmPassword: "",
      error: "",
    };
  },
  methods: {
    async submitForm() {
      if (
        !this.name ||
        !this.email ||
        !this.password ||
        !this.confirmPassword
      ) {
        this.error = "Пожалуйста, заполните все поля.";
        return;
      }

      if (this.password !== this.confirmPassword) {
        this.error = "Пароли не совпадают.";
        return;
      }

      this.error = "";

      try {
        const res = await fetch("http://localhost:8080/api/auth/register", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            name: this.name,
            email: this.email,
            password: this.password,
          }),
        });

        const data = await res.json();
        console.log(data);

        if (res.ok) {
          localStorage.setItem("name", this.name);
          localStorage.setItem("userEmail", this.email);
          alert("Регистрация успешна!");
          this.name = "";
          this.email = "";
          this.password = "";
          this.confirmPassword = "";
          this.$router.push("/");
        } else {
          console.log("Сервер вернул ошибку:", data);
          this.error = data.message;
        }
      } catch (err) {
        console.error("Ошибка запроса:", err);
        this.error = "Ошибка соединения с сервером";
      }
    },
  },
};
</script>

<style scoped>
.register-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 80vh;
  padding: 20px;
}

.register-form {
  width: 100%;
  max-width: 400px;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  background-color: #fff;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-title {
  text-align: center;
  color: #2c3e50;
  margin-bottom: 10px;
  font-size: 24px;
}

.form-input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid #d4e3ff;
  border-radius: 8px;
  font-size: 14px;
  transition: all 0.3s ease;
}

.form-input:focus {
  border-color: #1a73e8;
  box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.1);
  outline: none;
}

.btn-center {
  justify-content: center;
}

.submit-btn {
  background-color: #1a73e8;
  color: white;
  border: none;
  padding: 12px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-top: 10px;
  width: 180px;
}

.submit-btn:hover {
  background-color: #0d47a1;
}

.error-message {
  color: #e74c3c;
  text-align: center;
  margin-top: 10px;
  font-size: 14px;
}

@media (max-width: 480px) {
  .register-form {
    padding: 25px 20px;
    max-width: 340px;
  }

  .form-title {
    font-size: 22px;
  }

  .form-input {
    padding: 10px 14px;
  }

  .submit-btn {
    padding: 10px;
  }
}
</style>
