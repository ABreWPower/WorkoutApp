<template id="NavBar">
  <div>
    <v-ons-splitter>
      <v-ons-splitter-side
        swipeable
        width="33%"
        collapse=""
        side="right"
        :open.sync="openSide"
      >
        <v-ons-page>
          <v-ons-list>
            <v-ons-list-item
              v-for="page in pages"
              tappable
              :key="page"
              @click="
                sendPage(page);
                openSide = false;
              "
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
          <p style="text-align: center">
            <slot></slot>
          </p>
        </v-ons-page>
      </v-ons-splitter-content>
    </v-ons-splitter>
  </div>
</template>

<script>
export default {
  name: 'NavBar',
  props: {
    title: String,
    page: String,
    pages: Array
  },
  data: function() {
    return {
      openSide: false
    }
  },
  methods: {
    menuAction: function() {
      this.openSide = !this.openSide
    },
    sendPage: function(newPage) {
      console.log(newPage)
      this.$emit('newPage', newPage)
    }
  }
}
</script>

<style scoped>
</style>
