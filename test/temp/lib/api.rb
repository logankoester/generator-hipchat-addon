module testApp
  class API < ::Grape::API
    version 'v1', using: :header, vendor: ''
    format :json

    resource :hipchat do
      desc 'Describes the add-on and what its capabilities are'
      params do
        requires :account_id, type: String,
          desc: 'The account this add-on will be installed to'
      end
      get 'capabilities/:account_id' do
        {
          name: 'testApp',
          description: '',
          key: '',
          links: {
            homepage: ENV['BASE_URI'],
            self: "#{ENV['BASE_URI']}/hipchat/capabilities/#{params[:account_id]}"
          },
          vendor: {
            url: '',
            name: ''
          },
          capabilities: {
            hipchatApiConsumer: {
              scopes: ENV['HIPCHAT_SCOPES'].split(' ')
            },
            configurable: {
              url: "#{ENV['BASE_URI']}/hipchat/configure/#{params[:account_id]}"
            },
            installable: {
              callbackUrl: "#{ENV['BASE_URI']}/hipchat/install/#{params[:account_id]}"
            }
          }
        }
      end

      desc 'Receive installation notification'
      params do
        requires :account_id, type: String,
          desc: 'Account that has installed the add-on'
      end
      post 'install/:account_id' do
        if account = Account.find(params[:account_id])
          # Update account
          account.hipchat_oauth_id = params[:oauthId]
          account.hipchat_oauth_secret = params[:oauthSecret]
          account.hipchat_installed = true
          account.hipchat_capabilities_url = params[:capabilitiesUrl]

          # Verify capabilities
          response = open(URI.parse(params[:capabilitiesUrl]))
          capabilities = JSON.parse(response.read)
          raise UnexpectedApplicationError if capabilities['name'] != 'HipChat'

          # Request an OAuth token
          token_url = capabilities['capabilities']['oauth2Provider']['tokenUrl']
          authorization_url = capabilities['capabilities']['oauth2Provider']['authorizationUrl']

          client = OAuth2::Client.new(
            account.hipchat_oauth_id,
            account.hipchat_oauth_secret,
            site: token_url,
            scope: ENV['HIPCHAT_SCOPES'].split(' '),
            token_url: token_url,
            authorization_url: authorization_url
          )

          token = client.client_credentials.get_token.token
          account.hipchat_oauth_token = token

          account.save
          200
        else
          # Responding with error status will cause the installation to fail
          raise NoAccountError
        end
      end

      desc 'Receive uninstallation notification'
      params do
        requires :account_id, type: String,
          desc: 'Account that has removed the add-on'
        requires :oauth_id, type: String,
          desc: 'OAuth ID value for the installation'
      end
      delete 'install/:account_id/:oauth_id' do
        if account = Account.find(params[:account_id])
          account.hipchat_installed = false
          account.save
        else
          # Uninstallation will continue anyway, we just can't
          # track it to an account.
          raise NoAccountError
        end
      end
    end

  end
end
