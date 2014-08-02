require 'spec_helper'

describe 'Dashboard' do
  it 'Is the root page' do
    user = create(:user)
    visit root_path(as: user)
    expect(page).to have_selector 'h1', text: 'Expenses dashboard'
  end
end
