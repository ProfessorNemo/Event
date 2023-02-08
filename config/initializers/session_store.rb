# Use safe SameSite cookies. HttpOnly is already the default.
Rails.application.config.session_store :cookie_store, same_site: :strict
