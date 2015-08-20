describe User do
  describe "#email_domain" do
    subject { FactoryGirl.build(:user, email: "peter@abc-123.com") }

    its(:email_domain) { is_expected.to eq("abc-123.com") }
  end

  describe "#full_name" do
    subject { FactoryGirl.build(:user, given_name: "John", surname: "Smith") }

    its(:full_name) { is_expected.to eq("John Smith") }
  end

  describe "#gravatar_url" do
    subject { FactoryGirl.build(:user) }

    its(:gravatar_url) { is_expected.to be_a(String) }
    its(:gravatar_url) { is_expected.to include("gravatar.com") }
  end

  describe "after create" do
    let(:user) { FactoryGirl.build(:user, email: "peter@abcdef.io") }

    context "an organization already exists for the user's email domain" do
      let!(:organization) { FactoryGirl.create(:organization, email_domain: "abcdef.io") }
      subject { user.tap(:save!) }

      its(:organization) { is_expected.to eq(organization) }
    end

    context "an organization does not yet exist for the user's email domain" do
      subject { user.tap(:save!) }

      its(:organization) { is_expected.to be_nil }
    end
  end
end
