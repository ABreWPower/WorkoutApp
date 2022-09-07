<script setup>
import { watch, ref, toRef } from "vue"

const props = defineProps({
  type: {
    type: String,
    required: true,
  },
  populateList: {
    type: Array,
    required: true,
  },
  checkedList: {
    type: Array,
    required: true,
  }
})

const populateListFiltered = ref([])

// Debounce and search function for exercises and the data returned from the database
let timerId
function debounce(functionName, delay, ...args) {
  clearTimeout(timerId)
  timerId = setTimeout(() => {functionName.apply(null, args)}, delay)
}

function search(searchFor) {
  // console.log("we are seearching ", searchFor)
  populateListFiltered.value = props.populateList.filter(function(element) {
    // console.log("elelemtn", element.name, element.name == searchFor)
    let name = element.name.toLowerCase().includes(searchFor.toLowerCase())
    return name
  })
}

let searchValue = ref("")
watch(searchValue, () => {
  // console.log("my watcher changed")
  debounce(search, 1000, searchValue.value)
})

// Need to refresh this each time as it doesn't get data the first time as we are waiting on the GQL to come back
watch(props.populateList, (newValue, oldValue) => {
    debounce(search, 1000, searchValue.value)
})

</script>

<template>
  <div>
    <div style="padding-bottom: 10px">
      <button class="btn btn-secondary" type="button" :id="type.replace(/\s/g, '') + 'Button'" data-bs-toggle="modal" :data-bs-target="'#' + type.replace(/\s/g, '') + 'form'">Select {{ props.type }}</button>
    </div>
    <!-- TODO should we only save if they click a save button?  currently we save and update as soon as they click on an object -->
    <div class="modal fade" :id="type.replace(/\s/g, '') + 'form'" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Select {{ props.type }}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form class="d-flex">
              <input class="form-control me-2" type="search" placeholder="Search" v-model="searchValue" />
            </form>
            <div v-for="populate in populateListFiltered" :key="populate.id">
              <input type="checkbox" class="custom-control-input" :id="populate.id" @input="$emit('checked', populate.id)" :checked="props.checkedList.find((el) => el == populate.id) != undefined" />
              <label class="custom-control-label" :for="populate.id" style="padding-bottom: 5px; padding-left: 10px"> {{ populate.name }} </label>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
</style>
