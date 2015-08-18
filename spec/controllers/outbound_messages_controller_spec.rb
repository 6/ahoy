describe OutboundMessagesController do
  describe "#create" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:organization) { FactoryGirl.create(:organization, users: [user]) }
    before(:each) { stub_logged_in!(user) }

    context "with valid params" do
      let(:params) do
        {
          outbound_message: {
            to_phone: "647-123-4567",
            body: "Hola",
          },
        }
      end
      before(:each) do
        allow(subject.twilio_client).to receive_message_chain(:account, :messages, :create) do
          double(sid: "unique_twilio_id")
        end
      end

      it "creates a new OutboundMessage with the correct attributes" do
        expect { post :create, params }.to change(organization.outbound_messages, :count).by(1)

        message = OutboundMessage.last
        expect(message.to_phone).to eq("647-123-4567")
        expect(message.body).to eq("Hola")
        expect(message.twilio_message_id).to eq("unique_twilio_id")
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          outbound_message: {
            body: "Hola",
          },
        }
      end

      it "does not create a new OutboundMessage" do
        post :create, params rescue
        expect(OutboundMessage.count).to eq(0)
      end
    end
  end
end
