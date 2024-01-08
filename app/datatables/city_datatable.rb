class CityDatatable < AjaxDatatablesRails::ActiveRecord

  extend Forwardable
   def_delegator :@view, :city_path
   def_delegator :@view, :edit_city_path
   self.nulls_last = true

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
    name:     { source: "City.name", cond: :like, searchable: true, orderable: true },
    country: { source: "@city.country.name", cond: :eq },
    state: { source: "@city.state.name", cond: :eq },
    is_active:   { source: "City.is_active",  cond: :like, nulls_last: true },
    actions:  { source: "", searchable: false, orderable: false  },
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        country: record.country.name,
        state: record.state.name,
        is_active: record.is_active,
        actions: action(record),
      }
    end
  end

  def get_raw_records
    # insert query here
    City.all
  end

  def action(record)
   html = <<-HTML
   <div class="text-center">
   <div class="d-inline-flex">
   <div class="dropdown">
    <a href="#" class="text-body" data-bs-toggle="dropdown">
      <i class="ph-list"></i>
    </a>
    <div class="dropdown-menu dropdown-menu-end">
      <a href="#{city_path(record)}" class="dropdown-item">Show</a>
      <a href="#{edit_city_path(record)}" class="dropdown-item">Edit</a>
      <a href="#{city_path(record)}" class="dropdown-item" onclick="return confirm('Are you sure?');" data-turbo-confirm="Are you sure?" data-turbo-method="delete" data-method="delete">Destroy</a>
    </div>
   </div>
   </div>
 </div>
    HTML
    html.html_safe
  end

end
