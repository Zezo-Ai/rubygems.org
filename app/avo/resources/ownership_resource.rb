class OwnershipResource < Avo::BaseResource
  self.title = :cache_key
  self.includes = []

  class ConfirmedFilter < ScopeBooleanFilter; end
  filter ConfirmedFilter, arguments: { default: { confirmed: true, unconfirmed: true } }

  field :id, as: :id, link_to_resource: true

  field :user, as: :belongs_to
  field :rubygem, as: :belongs_to

  heading "Token"

  field :token, as: :text, visible: ->(_) { false }
  field :token_expires_at, as: :date_time
  field :api_key_rubygem_scopes, as: :has_many

  heading "Notifications"

  field :push_notifier, as: :boolean
  field :owner_notifier, as: :boolean
  field :ownership_request_notifier, as: :boolean

  heading "Authorization"

  field :authorizer, as: :belongs_to
  field :confirmed_at, as: :date_time
  field :role, as: :select, enum: Ownership.roles
end
