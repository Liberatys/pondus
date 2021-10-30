require "spec_helper"

RSpec.describe "Pondus scopes" do
  before(:each) do
    connect_db
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Schema.define do
      create_table(:bars) do |t|
        t.string :title
      end

      create_table(:foos) do |t|
        t.boolean :is_main
      end

      create_table(:foo_bars) do |t|
        t.string :title
        t.boolean :is_main
      end
    end
  end

  describe ".scored" do
    context "when score_by attributes are defined" do
      describe "#string_matcher" do
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
          expect(scored_sorted_collection.first.pondus_score).to eq(40)
          expect(scored_sorted_collection.last.pondus_score).to eq(0)
        end
      end

      describe "#boolean_matcher" do
        context "without expected_value" do
          class Foo < ActiveRecord::Base
            extend Pondus

            scored_by :is_main, strategy: :boolean
          end

          let!(:bars) do
            [
              Foo.create(is_main: false),
              Foo.create(is_main: true),
              Foo.create(is_main: false)
            ]
          end

          it "defaults to true for sorting" do
            expect(Foo.all.pluck(:is_main)).to eq([false, true, false])
            scored_sorted_collection = Foo.scored
            expect(scored_sorted_collection.map(&:is_main)).to eq([true, false, false])
          end
        end
      end

      describe "#mixed-matchers" do
        class FooBar < ActiveRecord::Base
          extend Pondus

          scored_by :is_main, strategy: :boolean
        end
      end
    end
  end
end
