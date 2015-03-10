#created for fb authentication login

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '858937580837474', '4bd30ea09542428f70c5708ceef81ecb', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end