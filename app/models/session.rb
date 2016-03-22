require 'securerandom'
class Session < ActiveRecord::Base
    before_create :set_auth_token

    private
    def set_auth_token
        return if token.present?
        self.token = generate_auth_token
    end

    def generate_auth_token
        SecureRandom.uuid.gsub(/\-/,'')
    end

end
