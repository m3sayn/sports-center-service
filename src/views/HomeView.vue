<template>
  <div class="home-page">
    <section class="hero-banner">
      <div class="hero-content">
        <h1>Добро пожаловать в SportLife</h1>
        <p class="hero-text">
          Премиальный фитнес-клуб с индивидуальным подходом к каждому клиенту
        </p>
        <router-link v-if="!userEmail" to="/signup" class="cta-button"
          >Начать тренировки</router-link
        >
      </div>
    </section>

    <section class="advantages-section">
      <h2>Почему выбирают нас</h2>
      <div class="advantages-grid">
        <div class="advantage-card">
          <i class="bi bi-people-fill"></i>
          <h3>Профессиональные тренеры</h3>
          <p>Наши сертифицированные специалисты помогут достичь любых целей</p>
        </div>
        <div class="advantage-card">
          <i class="bi bi-heart-pulse"></i>
          <h3>Современное оборудование</h3>
          <p>Тренажеры последнего поколения от ведущих мировых брендов</p>
        </div>
        <div class="advantage-card">
          <i class="bi bi-calendar-check"></i>
          <h3>Гибкий график</h3>
          <p>Возможность заниматься в любое удобное время с 7:00 до 23:00</p>
        </div>
      </div>
    </section>

    <section class="popular-trainings">
      <h2>Популярные направления</h2>
      <div class="trainings-grid">
        <div class="training-card">
          <img src="@/assets/yoga.png" alt="Йога" />
          <h3>Йога</h3>
          <p>Гармония тела и духа через древние практики</p>
        </div>
        <div class="training-card">
          <img src="@/assets/pilates.png" alt="Пилатес" />
          <h3>Пилатес</h3>
          <p>Укрепление мышечного корсета и развитие гибкости</p>
        </div>
      </div>
      <router-link to="/trainings" class="view-all-link"
        >Все тренировки →</router-link
      >
    </section>

    <section class="cta-section">
      <p>Запишитесь на первую тренировку прямо сейчас</p>
      <router-link to="/trainings" class="cta-button">Записаться</router-link>
    </section>
  </div>
</template>

<script>
export default {
  computed: {
    userEmail() {
      return localStorage.getItem("userEmail");
    },
  },
};
</script>

<style scoped>
.home-page {
  font-family: "Arial", sans-serif;
  color: #2c3e50;
  line-height: 1.6;
}

.hero-banner {
  background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
    url("@/assets/gym-banner.png");
  background-size: cover;
  background-position: center;
  height: 500px;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  color: white;
  padding: 0 20px;
}

.hero-content h1 {
  font-size: 3rem;
  margin-bottom: 20px;
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
}

.hero-text {
  font-size: 1.5rem;
  margin-bottom: 30px;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}

.advantages-section {
  padding: 80px 20px;
}

.advantages-grid {
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
  gap: 30px;
  max-width: 1200px;
  margin: 0 auto;
  margin-top: 50px;
}

.advantage-card {
  flex: 1;
  min-width: 250px;
  max-width: 300px;
  text-align: center;
  padding: 30px 20px;
  background: white;
  border-radius: 10px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.advantage-card i {
  font-size: 3.5rem;
  color: #1a73e8;
  margin-bottom: 20px;
  display: block;
}

.advantage-card h3 {
  font-size: 1.3rem;
  margin-bottom: 15px;
  color: #2c3e50;
}

.popular-trainings {
  padding: 80px 20px;
}

.trainings-grid {
  display: flex;
  flex-direction: column;
  gap: 40px;
  max-width: 1000px;
  margin: 0 auto;
}

.training-card {
  display: flex;
  align-items: center;
  gap: 40px;
  background: white;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
  margin-top: 50px;
}

.training-card:nth-child(even) {
  flex-direction: row-reverse;
}

.training-card img {
  width: 400px;
  height: 250px;
  object-fit: cover;
  flex-shrink: 0;
}

.training-card-content {
  padding: 30px;
  flex-grow: 1;
}

.training-card h3 {
  font-size: 1.5rem;
  color: #1a73e8;
  margin-bottom: 15px;
}

.training-card p {
  font-size: 1.1rem;
  color: #555;
}

.view-all-link {
  display: block;
  text-align: center;
  margin-top: 40px;
  color: #1a73e8;
  font-weight: bold;
  text-decoration: none;
  font-size: 1.1rem;
}

.view-all-link:hover {
  text-decoration: underline;
}

.cta-button {
  display: inline-block;
  background-color: #1a73e8;
  color: white;
  padding: 12px 30px;
  border-radius: 10px;
  text-decoration: none;
  font-weight: bold;
  transition: all 0.3s ease;
  font-size: 1.1rem;
  border: none;
  cursor: pointer;
}

.cta-button:hover {
  background-color: #0d47a1;
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(26, 115, 232, 0.3);
}

@media (max-width: 900px) {
  .training-card {
    flex-direction: column;
    gap: 0;
  }

  .training-card:nth-child(even) {
    flex-direction: column;
  }

  .training-card img {
    width: 100%;
    height: 200px;
  }
}

@media (max-width: 768px) {
  .hero-content h1 {
    font-size: 2.5rem;
  }

  .hero-text {
    font-size: 1.2rem;
  }

  .advantage-card {
    min-width: 100%;
  }

  .advantage-card i {
    font-size: 3rem;
  }
}
</style>
