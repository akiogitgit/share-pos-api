# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # このURLからのアクセスを許可する
    origins ["http://localhost:3000","https://share-pos.vercel.app" ]

    # resource: 許可するcontrollder (api/v1/*)とか
    resource "*",
      headers: :any,
      :expose => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true # フロントのCookieいじる設定
  end
end
