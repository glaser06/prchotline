class CountyDatatable < AjaxDatatablesRails::Base
  # https://github.com/antillas21/ajax-datatables-rails
  def_delegator :@view, :link_to
  def_delegator :@view, :county_path
  def_delegator :@view, :edit_county_path


  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['County.name','County.coordinator']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['County.name','County.coordinator']
  end

  private

  def data
    records.map do |record|

      [
        link_to(record.name, county_path(record)),
        record.coordinator,
        [record.phone, link_to("#{record.website}", record.website, :target => "_blank")],

        link_to("Edit", edit_county_path(record),:target => :_blank)
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    County.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
