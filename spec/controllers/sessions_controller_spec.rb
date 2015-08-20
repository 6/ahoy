describe SessionsController do
  describe "GET #new" do
    it "returns OK" do
      get :new
      expect(response).to be_ok
    end
  end

  describe "GET #create" do
    context "user signed in with work address" do
      before(:each) do
        OmniAuth.config.add_mock(:google, {info: {email: "user@company.com", first_name: "Peter", last_name: "G"}, credentials: {token: "abc", expires_at: 2.days.from_now}})
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
      end

      it "logs the user in" do
        expect(subject).not_to be_logged_in

        get :create, provider: "google"
        expect(subject).to be_logged_in
      end
    end

    context "user signed in with a gmail.com address" do
      before(:each) do
        OmniAuth.config.add_mock(:google, {info: {email: "user@gmail.com", first_name: "Peter", last_name: "G"}, credentials: {token: "abc", expires_at: 2.days.from_now}})
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
      end

      it "does not log in the user" do
        expect(subject).not_to be_logged_in

        get :create, provider: "google"
        expect(subject).not_to be_logged_in
      end

      it "redirects to new_session_path" do
        get :create, provider: "google"
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe "GET #destroy" do
    before(:each) { stub_logged_in! }

    it "logs out the user" do
      expect(subject).to be_logged_in

      get :destroy
      expect(subject).not_to be_logged_in
    end

    it "redirects to new_session_path" do
      get :destroy
      expect(response).to redirect_to(new_session_path)
    end
  end
end
