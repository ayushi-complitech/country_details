// countries.js

jQuery(document).ready(function() {
  $('#countries-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      "url": $('#countries-datatable').data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      {"data": "name"},
      {"data": "is_active"},
      {"data": "actions"},
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
});