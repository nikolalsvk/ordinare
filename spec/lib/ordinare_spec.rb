require "spec_helper"

describe Ordinare do
  describe "hi"  do
    it "says hi in italian" do
      expect Ordinare.hi .to eq "Ciao, sono Ordinare"
    end
  end
end
