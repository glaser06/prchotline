class ItemDatatable < AjaxDatatablesRails::Base

  def_delegator :@view, :link_to
  def_delegator :@view, :item_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Item.name','Item.description']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Item.name']
  end

  private

  def data

    records.map do |record|
      activeString = ""
      if record.active
        activeString = "Open"
      else
        activeString = "Closed"
      end
      [
        link_to(record.name, item_path(record), :target => :_blank),
        record.description,
        activeString
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
