module <%= appName %>
  class Account
    include ::MongoMapper::Document

    <% if (availability == 'stripe') { %># Purchase data
    key :stripe_email, String
    key :stripe_customer_id, String
    key :stripe_token, String
    key :stripe_charged, Integer<% } %>

    # Does the user actually have the plugin installed?
    key :hipchat_installed, Boolean

    # The oauth client to interface with Hipchat
    key :hipchat_oauth_id, String
    key :hipchat_oauth_secret, String
    key :hipchat_oauth_issued_at, String
    key :hipchat_oauth_token, String

    # The currently logged in user's ID
    key :hipchat_user_id, String

    # A map of extra context information, such as the user's preferred timezone
    key :hipchat_config_context, Object

    key :hipchat_capabilities_url, String

    timestamps!
  end
end
