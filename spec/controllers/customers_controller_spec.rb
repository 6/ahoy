describe CustomersController do
  let!(:organization) { FactoryGirl.create(:organization) }
  let!(:user) { FactoryGirl.create(:user, organization: organization) }
  before(:each) { stub_logged_in!(user) }

  describe "GET #index" do
    let!(:customer) { FactoryGirl.create(:customer, organization: organization) }
    let!(:other_org_customer) { FactoryGirl.create(:customer) }

    it "returns OK" do
      get :index
      expect(response).to be_ok
      expect(response.body).to include(customer.phone)
      expect(response.body).not_to include(other_org_customer.phone)
    end
  end

  describe "GET #show" do
    let!(:customer) { FactoryGirl.create(:customer, organization: organization) }

    it "returns OK" do
      get :show, id: customer.id
      expect(response).to be_ok
      expect(response.body).to include(customer.phone)
    end
  end

  describe "PUT #update" do
    let!(:customer) { FactoryGirl.create(:customer, organization: organization) }

    it "updates name and email" do
      expect(customer.name).to be_nil
      expect(customer.email).to be_nil

      put :update, id: customer.id, customer: {name: "Peter G", email: "peter@example.com"}
      customer.reload
      expect(customer.name).to eq("Peter G")
      expect(customer.email).to eq("peter@example.com")
    end
  end
end
