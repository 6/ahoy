describe OutboundMessage do
  subject { FactoryGirl.build(:outbound_message, from_phone: "123-333-4444", to_phone: "444-333-1234") }

  it { is_expected.not_to be_inbound }
  it { is_expected.to be_outbound }
  it { is_expected.not_to be_delivered }
  its(:customer_phone) { is_expected.to eq("444-333-1234") }

  context "delivered_at is set" do
    subject { FactoryGirl.build(:outbound_message, delivered_at: 1.second.ago) }

    it { is_expected.to be_delivered }
  end
end
