describe MessageDeliveryStatusesController do
  let!(:organization) { FactoryGirl.create(:organization) }
  let!(:outbound_message) { FactoryGirl.create(:outbound_message, organization: organization, twilio_message_id: "abc123") }

  describe "GET #create" do
    let(:params) do
      {
        organization_token: organization.token,
        MessageSid: outbound_message.twilio_message_id,
        MessageStatus: "delivered",
      }
    end

    it "returns OK with empty TwiML response" do
      get :create, params
      expect(response).to be_ok
      expect(response.body).to eq(empty_twiml_response_body)
    end

    it "updates message status" do
      expect(outbound_message).not_to be_delivered

      get :create, params
      expect(outbound_message.reload).to be_delivered
    end
  end
end
