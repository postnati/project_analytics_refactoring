# frozen_string_literal: true

require 'rails_helper'

feature 'Productivity Report' do
  before do
    seed_database
  end

  scenario 'Defaults' do
    visit productivity_url
    expect(page).to have_content 'Productivity Report'
  end
end
