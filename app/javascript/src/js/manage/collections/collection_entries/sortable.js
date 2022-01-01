import axios from 'axios'
import Sortable from 'sortablejs'
// import toastr from 'toastr'

import { metaCsrfToken } from '../../../common/modules/meta/csrf_token'

function collectionEntryRepositionAjax (updatedPositions) {
  const repositionUrl = window.location.pathname + '/reposition'
  const repositionData = {
    collection_entry: { positions: updatedPositions }
  }
  const repositionConfig = {
    headers: { 'X-CSRF-TOKEN': metaCsrfToken() },
    responseType: 'json'
  }

  axios.post(repositionUrl, repositionData, repositionConfig)
    .then((response) => {
      const message = response.data.message

      // toastr.success(message)
      console.log('success')
      console.log(message)
    })
    .catch((error) => {
      // toastr.error(error)
      console.log('error')
      console.log(error)
    })
}

function initializeSortableOnCollectionEntries () {
  const sortableItems = document.querySelectorAll('tbody.sortable-collection-entries.sortable-active')

  sortableItems.forEach((sortableItem) => {
    const sortableObj = Sortable.create(sortableItem, {
      ghostClass: 'sortable-ghost',
      handle: 'tr',
      onUpdate: function () {
        const updatedPositions = sortableObj.toArray()

        collectionEntryRepositionAjax(updatedPositions)
      }
    })
  })
}

document.addEventListener('turbolinks:load', () => {
  initializeSortableOnCollectionEntries()
})
