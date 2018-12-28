# frozen_string_literal: true

require 'spec_helper'

describe 'ProductivityQueryService' do
  describe '#query_productivity' do
    before do
      week_ending_at = DateTime.now.at_beginning_of_week - ((5 * 7) + 1).days
      while week_ending_at <= DateTime.now
        create(:effort_week, ended_at: week_ending_at)
        week_ending_at += 7.days
      end
    end

    it 'returns all productivity data' do
      productivity_data = double('ProdData')
      expect(ProductivityDataService).to receive(:new).with('the_grouping').and_return(productivity_data)
      expect(productivity_data).to receive(:oldest_group_ended_at).and_return('oldest')
      expect(ProductivityQueryService).to receive(:add_week_project_effort).exactly(6).times

      ProductivityQueryService.query_productivity('the_grouping')
    end
  end

  describe '#add_week_project_effort' do
    skip 'updates current group if data already exists' do
    end

    skip 'adds default group and addes to it if data is new' do
    end
  end
end
