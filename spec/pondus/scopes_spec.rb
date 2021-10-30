require "spec_helper"

RSpec.describe "Pondus scopes" do
  before(:each) do
    connect_db
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Schema.define do
      create_table(:bars) do |t|
        t.string :title
        t.string :description
        t.boolean :is_main
      end
    end
  end

  describe ".scored" do
    context "when no score_by attributes are defined" do
      class Bar < ActiveRecord::Base
        extend Pondus
      end

      context "when there are no records" do
        it "returns empty collection" do
          expect(Bar.scored.count).to eq(0)
        end
      end

      context "when there are multiple records" do
        let!(:bars) do
          [
            Bar.create(title: "First"),
            Bar.create(title: "Second"),
            Bar.create(title: "Third")
          ]
        end

        it "returns all elements without special sorting" do
          expect(Bar.scored).to eq(bars)
        end
      end
    end

    context "when score_by attributes are defined" do
      class Bar < ActiveRecord::Base
        extend Pondus

        scored_by :title, strategy: :string_match
      end

      let!(:bars) do
        [
          Bar.create(title: "Second"),
          Bar.create(title: "Third"),
          Bar.create(title: "First")
        ]
      end

      let(:sort_term) { "Fi" }

      it "returns a score sorted array" do
        expect(Bar.all.first.title).to eq("Second")
        scored_sorted_collection = Bar.scored({title: sort_term})
        expect(scored_sorted_collection.first.title).to eq("First")
        expect(scored_sorted_collection.first.pondus_score).to eq(100)
        expect(scored_sorted_collection.last.pondus_score).to eq(0)
      end
    end
  end
end
