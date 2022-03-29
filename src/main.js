import * as bootstrap from 'bootstrap'
import 'bootstrap/scss/bootstrap.scss'
import 'bootstrap-icons/font/bootstrap-icons.css'

// Setup Vue components
import { createApp } from "vue";
// import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router/router.js";

const app = createApp(App);

// app.use(createPinia());
app.use(router);

app.mount("#app");
