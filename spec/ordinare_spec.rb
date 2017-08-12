require "spec_helper"

describe Ordinare do
  describe "#hi"  do
    it "says hi in italian" do
      expect(Ordinare.hi).to eq "Ciao, sono Ordinare"
    end
  end

  describe "#parse_args" do
    context "path to Gemfile is passed" do
      context "using -p" do
        before { ARGV = ["-p spec/fixtures/Gemfile"] }

        it "calls sort_gemfile" do
          expect(Ordinare::Sort).to receive(:sort_gemfile).with(true, " spec/fixtures/Gemfile")

          Ordinare.parse_args
        end
      end

      context "using --path" do
        before do
          ARGV = ["--path=spec/fixtures/Gemfile"]
        end

        it "calls sort_gemfile" do
          expect(Ordinare::Sort).to receive(:sort_gemfile).with(true, "spec/fixtures/Gemfile")

          Ordinare.parse_args
        end
      end
    end

    context "no overwrite option is passed" do
      context "using -n" do
        before { ARGV = ["-n"] }

        it "calls sort_gemfile" do
          expect(Ordinare::Sort).to receive(:sort_gemfile).with(false, "Gemfile")

          Ordinare.parse_args
        end
      end

      context "using --no-overwrite" do
        before { ARGV = ["--no-overwrite"] }

        it "calls sort_gemfile" do
          expect(Ordinare::Sort).to receive(:sort_gemfile).with(false, "Gemfile")

          Ordinare.parse_args
        end
      end
    end

    context "check if Gemfile is sorted properly" do
      context "using -c" do
        before { ARGV = ["-c"] }

        it "calls gemfile_sorted?" do
          expect(Ordinare::Check).to receive(:gemfile_sorted?).with("Gemfile")

          Ordinare.parse_args
        end
      end

      context "using --check" do
        before { ARGV = ["--check"] }

        it "calls gemfile_sorted?" do
          expect(Ordinare::Check).to receive(:gemfile_sorted?).with("Gemfile")

          Ordinare.parse_args
        end
      end
    end

    context "get Ordinare version" do
      context "using -v" do
        before { ARGV = ["-v"] }

        it "doesn't call gemfile_sorted" do
          expect(Ordinare::Check).not_to receive(:gemfile_sorted?)

          Ordinare.parse_args
        end

        it "doesn't call sort_gemfile" do
          expect(Ordinare::Sort).not_to receive(:sort_gemfile)

          Ordinare.parse_args
        end
      end

      context "using --version" do
        before { ARGV = ["--version"] }

        it "doesn't call gemfile_sorted" do
          expect(Ordinare::Check).not_to receive(:gemfile_sorted?)

          Ordinare.parse_args
        end

        it "doesn't call sort_gemfile" do
          expect(Ordinare::Sort).not_to receive(:sort_gemfile)

          Ordinare.parse_args
        end
      end
    end

    context "get help" do
      context "using -h" do
        before { ARGV = ["-h"] }

        it "doesn't call gemfile_sorted" do
          expect(Ordinare::Check).not_to receive(:gemfile_sorted?)

          Ordinare.parse_args
        end

        it "doesn't call sort_gemfile" do
          expect(Ordinare::Sort).not_to receive(:sort_gemfile)

          Ordinare.parse_args
        end
      end

      context "using --help" do
        before { ARGV = ["--help"] }

        it "doesn't call gemfile_sorted" do
          expect(Ordinare::Check).not_to receive(:gemfile_sorted?)

          Ordinare.parse_args
        end

        it "doesn't call sort_gemfile" do
          expect(Ordinare::Sort).not_to receive(:sort_gemfile)

          Ordinare.parse_args
        end
      end
    end
  end
end
