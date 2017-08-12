require "spec_helper"

describe Ordinare::Check do
  describe "#gemfile_sorted?" do
    context "no Gemfile found" do
      it "aborts with message" do
        expect {
          described_class.gemfile_sorted?("spec/fixtures/no_gemfile")
        }.to raise_error(SystemExit)
      end
    end

    context "Gemfile is sorted properly" do
      it "returns true" do
        gemfile_sorted = described_class.gemfile_sorted?("spec/fixtures/ordered_gemfile/Gemfile")

        expect(gemfile_sorted).to be_truthy
      end
    end

    context "Gemfile is not sorted properly" do
      it "raises an exception" do
        expect {
          described_class.gemfile_sorted?("spec/fixtures/complex_gemfile/Gemfile")
        }.to raise_error(SystemExit)
      end
    end
  end
end
