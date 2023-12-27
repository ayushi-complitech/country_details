
jQuery(document).ready(function() {
  $('#cities-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      "url": $('#cities-datatable').data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      {"data": "name"},
      {"data": "country"},
      {"data": "state"},
      {"data": "is_active"},
      {"data": "actions"},
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
});