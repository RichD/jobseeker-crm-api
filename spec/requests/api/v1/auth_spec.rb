require "rails_helper"

RSpec.describe "Api::V1::Auths", type: :request do
  describe "POST /api/v1/auth/signup" do
    before do
      post api_v1_auth_signup_path,
           params: { email: email, password: password }
    end

    context "with valid email/password" do
      let(:email) { "test@example.com" }
      let(:password) { "password123" }

      it "returns 201" do
        expect(response).to have_http_status(:created)
      end

      it "returns user + JWT token" do
        expect(json_response.dig("user", "email")).to eq("test@example.com")
        expect(json_response["token"]).to be_present
      end
    end

    context "with invalid email" do
      let(:email) { "test_example.com" }
      let(:password) { "password123" }

      it "returns 422" do
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "returns an error" do
        expect(json_response.dig("errors", "email").first)
          .to include("invalid")
      end
    end

    context "with short password" do
      let(:email) { "test@example.com" }
      let(:password) { "pw123" }

      it "returns 422" do
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "returns an error" do
        expect(json_response.dig("errors", "password").first)
          .to include("too short")
      end
    end

    context "with duplicate email" do
      let(:password) { "password123" }
      let!(:existing_user) { create(:user, password: password) }
      let(:email) { existing_user.email }

      it "returns 422" do
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "returns an error" do
        expect(json_response.dig("errors", "email").first)
          .to include("has already been taken")
      end
    end
  end

  describe "POST /api/v1/auth/login" do
    let!(:user) do
      create(
        :user,
        email: "existing@example.com",
        password: "CorrectPassword123"
      )
    end

    before do
      post api_v1_auth_login_path, params: { email: email, password: password }
    end

    context "with correct credentials" do
      let(:email) { user.email }
      let(:password) { "CorrectPassword123" }

      it "returns 200, returns user + JWT token" do
        expect(response).to have_http_status(:ok)
      end

      it "returns user + JWT token" do
        expect(json_response.dig("user", "email")).to eq(user.email)
        expect(json_response["token"]).to be_present
      end
    end

    context "with wrong password" do
      let(:email) { user.email }
      let(:password) { "WrongPassword123" }

      it "returns 401" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error" do
        expect(json_response["error"]).to be_present
      end
    end

    context "with non-existent email" do
      let(:email) { "nonexistent@example.com" }
      let(:password) { "AnyPassword123" }

      it "returns 401" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error" do
        expect(json_response["error"]).to be_present
      end
    end
  end

  describe "GET /api/v1/auth/me" do
    let!(:user) { create(:user, password: "ValidPassword123") }

    before do
      get api_v1_auth_me_path, headers: headers
    end

    context "with valid JWT in Authorization header" do
      let(:token) { JwtService.encode(user_id: user.id) }
      let(:headers) { { "Authorization" => "Bearer #{token}" } }

      it "returns 200, returns current user" do
        expect(response).to have_http_status(:ok)
      end

      it "returns current user" do
        expect(json_response["user"]["email"]).to eq(user.email)
      end
    end

    context "with missing token" do
      let(:headers) { {} }

      it "returns 401" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error" do
        expect(json_response["error"]).to be_present
      end
    end

    context "with invalid token" do
      let(:headers) { { "Authorization" => "Bearer InvalidToken123" } }

      it "returns 401" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error" do
        expect(json_response["error"]).to be_present
      end
    end

    context "with expired token" do
      let(:expired_token) do
        JwtService.encode({ user_id: user.id }, 1.hour.ago.to_i)
      end

      let(:headers) { { "Authorization" => "Bearer #{expired_token}" } }

      it "returns 401" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error" do
        expect(json_response["error"]).to be_present
      end
    end
  end
end
