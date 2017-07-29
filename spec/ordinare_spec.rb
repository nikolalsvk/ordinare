require "spec_helper"
require "fileutils"

describe Ordinare do
  describe "hi"  do
    it "says hi in italian" do
      expect(Ordinare.hi).to eq "Ciao, sono Ordinare"
    end
  end

  describe "sort" do
    context "no Gemfile found" do
      it "aborts with message" do
        expect { Ordinare.sort("spec/fixtures/no_gemfile") }.to raise_error(SystemExit)
      end
    end

    context "Gemfile found" do
      it "sorts basic Gemfile" do
        basic_gemfile = "spec/fixtures/basic_gemfile/Gemfile"
        Ordinare.sort(basic_gemfile)

        same_files = FileUtils.identical?("#{basic_gemfile}.ordered", "#{basic_gemfile}.ordinare")
        expect(same_files).to be_truthy
      end

      it "sorts Gemfile with groups" do
        group_gemfile = "spec/fixtures/group_gemfile/Gemfile"
        Ordinare.sort(group_gemfile)

        same_files = FileUtils.identical?("#{group_gemfile}.ordered", "#{group_gemfile}.ordinare")
        expect(same_files).to be_truthy
      end
    end
  end
end
