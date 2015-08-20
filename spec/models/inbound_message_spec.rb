describe InboundMessage do
  subject { FactoryGirl.build(:inbound_message, from_phone: "123-333-4444", to_phone: "444-333-1234") }

  it { is_expected.to be_inbound }
  it { is_expected.not_to be_outbound }
  it { is_expected.to be_delivered }
  its(:customer_phone) { is_expected.to eq("123-333-4444") }
end
