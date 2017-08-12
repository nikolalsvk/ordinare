require "spec_helper"
require "fileutils"

describe Ordinare::Sort do
  describe "#sort_gemfile" do
    context "no Gemfile found" do
      it "aborts with message" do
        expect {
          Ordinare::Sort.sort_gemfile(false, "spec/fixtures/no_gemfile")
        }.to raise_error(SystemExit)
      end
    end

    context "Gemfile found" do
      it "sorts basic Gemfile" do
        basic_gemfile = "spec/fixtures/basic_gemfile/Gemfile"
        Ordinare::Sort.sort_gemfile(false, basic_gemfile)

        same_files = FileUtils.identical?("#{basic_gemfile}.ordered", "#{basic_gemfile}.ordinare")
        expect(same_files).to be_truthy
      end

      it "sorts Gemfile with groups" do
        group_gemfile = "spec/fixtures/group_gemfile/Gemfile"
        Ordinare::Sort.sort_gemfile(false, group_gemfile)

        same_files = FileUtils.identical?("#{group_gemfile}.ordered", "#{group_gemfile}.ordinare")
        expect(same_files).to be_truthy
      end

      it "sorts complicated Gemfile" do
        complex_gemfile = "spec/fixtures/complex_gemfile/Gemfile"
        Ordinare::Sort.sort_gemfile(false, complex_gemfile)

        same_files = FileUtils.identical?("#{complex_gemfile}.ordered", "#{complex_gemfile}.ordinare")
        expect(same_files).to be_truthy
      end
    end
  end
end
