class Datatable
  attr_reader :total_record_count

  def initialize(params, search, columns)
    @params = params
    @total_record_count = search.execute.total
    @search = search
    @columns = columns
  end

  def s_echo
    params[:sEcho].to_i
  end

  def filtered_search
    @filtered_search ||= @search.build do
      fulltext params[:sSearch]
      order_by(sort_column, sort_direction)
      paginate page: page, per_page: per
    end.execute
  end

  def filtered_record_count
    filtered_search.total
  end

  def data
    filtered_search.results
  end

  private

  attr_reader :params, :columns

  def page
    (params[:iDisplayStart].to_i / per) + 1
  end

  def per
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? :desc : :asc
  end

  def sort_column
    columns[params[:iSortCol_0].to_i]
  end
end
