OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
    :idp_sso_target_url => ENV['IDP_SSO_TARGET_URL'],
    :idp_cert_fingerprint => ENV['IPD_CERT_FINGERPRINT'],
    :name_identifier_format => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    :idp_sso_target_url_runtime_params => { :redirectUrl => :RelayState }
end
