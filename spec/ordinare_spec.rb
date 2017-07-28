require "spec_helper"

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
      it "doesn't abort with message" do
        expect { Ordinare.sort("spec/fixtures/Gemfile") }.not_to raise_error(SystemExit)
      end
    end
  end
end
