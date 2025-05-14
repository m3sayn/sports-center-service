<template>
  <div class="login-container">
    <form @submit.prevent="submitForm" class="login-form">
      <h3 class="form-title">Вход в систему</h3>
      <div class="form-group">
        <input
          v-model="email"
          placeholder="Email"
          type="email"
          class="form-input"
          required
        />
      </div>
      <div class="form-group">
        <input
          v-model="password"
          placeholder="Пароль"
          type="password"
          class="form-input"
          required
        />
      </div>
      <div class="btn-center">
        <button type="submit" class="submit-btn">Войти</button>
      </div>
      <p v-if="error" class="error-message">{{ error }}</p>

      <div class="register-link">
        Нет аккаунта?
        <router-link to="/signup">Зарегистрируйтесь</router-link>
      </div>
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
      if (!this.email || !this.password) {
        this.error = "Пожалуйста, заполните все поля.";
        return;
      }

      try {
        const res = await fetch("http://localhost:8080/api/auth/login", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ email: this.email, password: this.password }),
        });

        const data = await res.json();

        if (res.ok) {
          localStorage.setItem("name", data.user.name);
          localStorage.setItem("userEmail", this.email);
          alert("Вход успешен: " + data.user.name);
          this.$router.push("/");
        } else {
          this.error = data.message;
        }
      } catch (err) {
        this.error = "Ошибка подключения к серверу";
      }
    },
  },
};
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 80vh;
  padding: 20px;
}

.login-form {
  width: 100%;
  max-width: 400px;
  padding: 40px 30px;
  border-radius: 12px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
  background-color: white;
}

.form-title {
  text-align: center;
  color: #2c3e50;
  margin-bottom: 30px;
  font-size: 24px;
}

.form-group {
  margin-bottom: 20px;
}

.form-input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid #d4e3ff;
  border-radius: 8px;
  font-size: 15px;
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
  width: 100%;
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
  width: 100px;
}

.submit-btn:hover {
  background-color: #0d47a1;
}

.error-message {
  color: #e74c3c;
  text-align: center;
  margin: 15px 0;
  font-size: 14px;
}

.register-link {
  text-align: center;
  margin-top: 20px;
  color: #7f8c8d;
  font-size: 14px;
}

.register-link a {
  color: #1a73e8;
  text-decoration: none;
  font-weight: 500;
}

.register-link a:hover {
  text-decoration: underline;
}

@media (max-width: 480px) {
  .login-form {
    padding: 30px 20px;
  }

  .form-title {
    font-size: 22px;
    margin-bottom: 25px;
  }

  .form-input {
    padding: 10px 14px;
  }
}
</style>
