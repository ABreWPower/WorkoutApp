<script setup>
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

// const emit = defineEmits['checked']

console.log("checked : ", props.checkedList)

// // **********************
// // Array Removal Function
// // **********************
// function arrayRemove(arr, value) { 
//     return arr.filter( function(element) {
//         return element != value; 
//     })
// }

// // Add each clicked item to the exercise.musclegroups
// function muscleGroupCheckChange(changelist) {
//   if (props.checkListObj.includes(changelist)) {
//     // Remove the muscle group from the exercise
//     props.checkListObj = arrayRemove(props.checkListObj, changelist)
//   }
//   else {
//     // Add the muscle group to the exercise
//     props.checkListObj.push(changelist)
//   }
// }

// function testing(populate) {
//   console.log("Model")
//   console.log(populate)
//   console.log(props.checkListObj)
//   props.checkListObj.findIndex((el) => el.id == populate.id) != -1
// }

</script>

<template>
  <div>
    <div style="padding-bottom: 10px">
      <button class="btn btn-secondary" type="button" id="exerciseModalButton" data-bs-toggle="modal" data-bs-target="#exerciseModalForm">Select {{ props.type }}</button>
    </div>
    <!-- TODO should we only save if they click a save button?  currently we save and update as soon as they click on an object -->
    <div class="modal fade" id="exerciseModalForm" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Select {{ props.type }}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div v-for="populate in populateList" :key="populate.id">
              <!-- <input type="checkbox" class="custom-control-input" :id="populate.id" :checked="props.checkListObj.findIndex((el) => el.id == populate.id) != -1" /> -->
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
