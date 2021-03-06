# Inspired by http://railscasts.com/episodes/340-datatables
#
# This implementation expands on that basic idea by injecting a dependency on
# Sunspot for full text search and ordering, rather than using database level
# solutions such as "LIKE '%..%'" clauses.

class Datatable
  attr_reader :total_record_count

  def initialize(params, input)
    @params = params
    @total_record_count = input.search.execute.total
    @search = input.search
    @columns = input.columns
  end

  def s_echo
    params[:sEcho].to_i
  end

  def filtered_record_count
    filtered_search.total
  end

  def data
    filtered_search.results
  end

  private

  attr_reader :params, :columns

  def filtered_search
    @filtered_search ||= @search.build do
      fulltext params[:sSearch]
      order_by(sort_column, sort_direction)
      paginate page: page, per_page: per
    end.execute
  end

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
