require "rails_helper"

RSpec.describe JwtService, type: :service do
  let(:data) { { data: "test" } }

  describe ".encode" do
    it "returns an encoded string" do
      expect(described_class.encode(data)).to match(/^\S*$/)
    end
  end

  describe ".decode" do
    context "without a valid token" do
      it "returns nil" do
        expect(described_class.decode("rndTkn")).to be_nil
      end
    end

    context "with a token" do
      subject(:decoded_token) { described_class.decode(token) }

      context "when it is expired" do
        let(:token) { described_class.encode(data, 1.second.ago) }

        before do
          sleep 0.1
        end

        it { is_expected.to be_nil }
      end

      context "when it is valid" do
        let(:token) { described_class.encode(data) }

        it "returns a hash" do
          expect(decoded_token.keys).to eq(%w[data exp])
          expect(decoded_token["data"]).to eq("test")
        end
      end
    end
  end
end
