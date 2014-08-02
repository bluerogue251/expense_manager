require 'spec_helper'

describe 'Dashboard' do
  it 'Is the root page' do
    visit root_path
    expect(page).to have_selector 'h1', text: 'Expenses dashboard'
  end
end
