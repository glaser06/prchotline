class ItemDatatable < AjaxDatatablesRails::Base
# https://github.com/antillas21/ajax-datatables-rails
  def_delegator :@view, :link_to
  def_delegator :@view, :item_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Item.name']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Item.name']
  end

  private

  def data

    records.map do |record|
      alises = []
      record.aliases.each do | alis |
        alises.push(" " + alis.name.titleize)
      end
      [
        link_to(record.name.titleize, item_path(record)),
        record.description,
        alises
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    Item.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
