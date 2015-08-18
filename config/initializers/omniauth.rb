Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_oauth2.fetch("client_id"), Rails.application.secrets.google_oauth2.fetch("client_secret"), {
    name: "google",
    scope: "email,profile",
  }
end

OmniAuth.config.on_failure = SessionsController.action(:failure)
