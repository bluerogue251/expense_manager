require 'spec_helper'

describe ExpensesController, search: true do
  render_views

  it "Differentiates total records vs. those displayed that match the search" do
    sign_in
    create(:expense, description: "Office supplies")
    create(:expense, description: "Travel subsidies")
    Sunspot.commit
    get :index, format: :json, sSearch: "Office supplies"
    json = JSON.parse(response.body)
    expect(json.fetch("iTotalDisplayRecords")).to eq 1
    expect(json.fetch("iTotalRecords")).to eq 2
  end
end
