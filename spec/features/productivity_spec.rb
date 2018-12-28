# frozen_string_literal: true

require 'rails_helper'

feature 'Productivity Report' do
  before do
    build(:user)
  end

  scenario 'User views with defaults' do
    visit productivity_url
    expect(page).to have_content 'Weekly Productivity for [dev] in [Minneapolis]'
  end
end
