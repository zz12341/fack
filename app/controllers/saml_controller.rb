class SamlController < ApplicationController
  skip_before_action :verify_authenticity_token
  def init
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings), allow_other_host: true)
  end

  def consume
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse])
    request = OneLogin::RubySaml::Authrequest.new
    response.settings = saml_settings
    if response.is_valid?
      puts response.inspect
      session[:authenticated] = true
      redirect_to root_path
    else
      redirect_to(request.create(saml_settings))
    end
  end

  def metadata
    settings = saml_settings
    meta = OneLogin::RubySaml::Metadata.new
    render xml: meta.generate(settings), content_type: 'application/samlmetadata+xml'
  end

  private

  def saml_settings
    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
    # Returns OneLogin::RubySaml::Settings pre-populated with IdP metadata
    # TODO - Cache This
    settings = idp_metadata_parser.parse_remote(ENV['SSO_METADATA_URL'])

    settings.assertion_consumer_service_url = "https://#{request.host}/auth/saml/consume"
    settings.sp_entity_id                   = "https://#{request.host}/auth/saml/metadata"

    settings
  end
end
