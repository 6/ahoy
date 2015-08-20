describe Organization do
  subject { FactoryGirl.build(:organization) }

  its(:token) { is_expected.to be_present }
end
