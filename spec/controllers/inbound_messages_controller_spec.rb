describe InboundMessagesController do
  describe "#create" do
    let!(:organization) { FactoryGirl.create(:organization) }

    context "with valid params" do
      let(:params) do
        {
          organization_token: organization.token,
          From: "647-123-4567",
          To: "617-543-2121",
          Body: "Hola",
          MessageSid: "abc123",
        }
      end

      it "creates a new InboundMessage with the correct attributes" do
        expect { post :create, params }.to change(organization.inbound_messages, :count).by(1)

        message = InboundMessage.last
        expect(message.from_phone).to eq("647-123-4567")
        expect(message.to_phone).to eq("617-543-2121")
        expect(message.body).to eq("Hola")
        expect(message.twilio_message_id).to eq("abc123")
        expect(message.twilio_data).to be_present
      end

      it "returns OK with an empty TwiML response" do
        post :create, params

        expect(response).to be_ok
        expect(response.body).to eq(empty_twiml_response_body)
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          organization_token: "not valid",
          From: "647-123-4567",
          To: "617-543-2121",
          Body: "Hola",
          MessageSid: "abc123",
        }
      end

      it "does not create a new InboundMessage" do
        post :create, params rescue
        expect(InboundMessage.count).to eq(0)
      end
    end
  end
end
