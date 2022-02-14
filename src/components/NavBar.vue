<template id="NavBar">
  <div>
    <v-ons-splitter>
      <v-ons-splitter-side
        swipeable
        width="150px"
        collapse=""
        side="right"
        :open.sync="openSide"
      >
        <v-ons-page>
          <v-ons-list>
            <v-ons-list-item
              v-for="page in pages"
              tappable
              modifier="chevron"
              :key="page"
            >
              <div class="center">{{ page }}</div>
            </v-ons-list-item>
          </v-ons-list>
        </v-ons-page>
      </v-ons-splitter-side>

      <v-ons-splitter-content>
        <v-ons-page>
          <v-ons-toolbar>
            <div class="left">
              <v-ons-toolbar-button>
                <v-ons-icon icon="md-arrow-left"></v-ons-icon>
              </v-ons-toolbar-button>
            </div>
            <div class="center">{{ title }}</div>
            <div class="right">
              <v-ons-toolbar-button>
                <v-ons-icon icon="md-menu" @click="menuAction()"></v-ons-icon>
              </v-ons-toolbar-button>
            </div>
          </v-ons-toolbar>
          <p style="text-align:center">
            <slot></slot>
          </p>
        </v-ons-page>
      </v-ons-splitter-content>
    </v-ons-splitter>
  </div>
</template>

<script>

export default {
  name: "NavBar",
  props: {
    title: String,
  },
  data: function () {
    return {
      page: "Page one",
      pages: ["Page one", "Page two", "Page three"],
      openSide: false,
    };
  },
  methods: {
    menuAction: function () {
      this.openSide = !this.openSide;
    },
  }
};
</script>

<style scoped>
</style>
