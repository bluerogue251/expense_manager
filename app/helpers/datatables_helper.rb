module DatatablesHelper

  def page
    params[:iDisplayStart].to_i/per + 1
  end

  def per
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def paginated_records
    searched_records.page(page).per(per)
  end

  def as_json(options={})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @all_records.count,
      iTotalDisplayRecords: searched_records.count,
      aaData: data
    }
  end
end
