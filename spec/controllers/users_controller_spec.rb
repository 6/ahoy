describe UsersController do
  let!(:user) { FactoryGirl.create(:user, given_name: "John", surname: "Smith") }
  before(:each) { stub_logged_in!(user) }

  describe "GET #edit" do
    it "returns OK" do
      get :edit
      expect(response).to be_ok
    end
  end

  describe "PUT #update" do
    it "updates name" do
      expect(user.full_name).to eq("John Smith")

      put :update, user: {given_name: "Jane", surname: "Doe"}
      expect(user.reload.full_name).to eq("Jane Doe")
    end
  end
end
