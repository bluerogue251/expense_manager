module DatatablesHelper

  def page
    params[:iDisplayStart].to_i/per + 1
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

  def as_json(options={})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: total_record_count,
      iTotalDisplayRecords: @display_records.total,
      aaData: data
    }
  end
end
