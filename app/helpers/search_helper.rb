module SearchHelper

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def sort_column
    @columns[params[:iSortCol_0].to_i]
  end

  def get_records
    records = @scope
    records = records.order("#{sort_column} #{sort_direction}")
    records = records.search("#{params[:sSearch]}") if params[:sSearch].present?
    return records
  end

end
