module DatatablesHelper

  def page
    params[:iDisplayStart].to_i/per + 1
  end

  def per
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def sort_column(columns)
    columns[params[:iSortCol_0].to_i]
  end

  def get_records
    records = @scope
    records = records.order("#{sort_column(@columns)} #{sort_direction}")
    records = records.search("#{params[:sSearch]}") if params[:sSearch].present?
    return records
  end

  def paginated_records
    get_records.page(page).per(per)
  end

  def as_json(options={})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @scope.count,
      iTotalDisplayRecords: get_records.count,
      aaData: data
    }
  end
end
