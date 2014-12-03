OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
    :idp_sso_target_url => 'https://thoughtworks.oktapreview.com/home/template_saml_2_0/0oaosws1uSGSAUTDWQCU/1541',
    :idp_cert_fingerprint => 'B8:53:D4:A7:E6:1B:86:FF:4E:91:F6:2D:34:EB:A6:A2:8F:89:9E:6F',
    :name_identifier_format => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    :idp_sso_target_url_runtime_params => { :redirectUrl => :RelayState }
end
