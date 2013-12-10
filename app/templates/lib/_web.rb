module <%= appName %>
  class Web < ::Sinatra::Base

    get '/' do
      <% if (availability == 'free') { %>
        account = Account.new
        account.save
        @account_id = account.id
      <% } %>
      erb :index
    end

    get '/support' do
      erb :support
    end

    <% if (availability == 'stripe') { %>post '/charge' do
      money = ::Money.new(settings.charge_amount, settings.charge_currency)
      logger.info "Attempting to charging #{money.format}"

      customer = ::Stripe::Customer.create(
        :email => params[:stripeEmail],
        :card => params[:stripeToken]
      )

      charge = ::Stripe::Charge.create(
        :amount      => settings.charge_amount,
        :description => settings.charge_description,
        :currency    => settings.charge_currency,
        :customer    => customer.id
      )

      account = Account.new
      account.stripe_email = params[:stripeEmail]
      account.stripe_token = params[:stripeToken]
      account.stripe_customer_id = customer.id
      account.stripe_charged = settings.charge_amount
      account.save

      @account_id = account.id

      flash[:notice] = "Thanks, you paid #{money.format}"
      erb :charge
    end<% } %>

    get '/hipchat/configure/:account_id' do
      if account = Account.find(params[:account_id])
        token = ::JWT.decode params['signed_request'], nil, nil
        account.hipchat_oauth_id = token['iss']
        account.hipchat_oauth_issued_at = token['iat']
        account.hipchat_user_id = token['prn']
        account.hipchat_config_context = token['context']
        account.save
      else
        raise NoAccountError
      end
      erb :configure
    end

    get '/thanks' do
      erb :thanks
    end

    error NoAccountError do
      flash[:error] = 'We couldn\'t find your account, please contact support.'
      redirect to('/support')
    end

    <% if (availability == 'stripe') { %>
    error ::Stripe::CardError do
      flash[:error] = env['sinatra.error'].message
      redirect to('/support')
    end
    <% } %>

  end
end
