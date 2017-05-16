class User < ActiveRecord::Base

    has_secure_password
    has_many :reviews

    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false } 
    validates :password_digest, presence: true
    validates_length_of :password, minimum: 6 
    validate :must_have_first_and_last_name


    def must_have_first_and_last_name 
      if self.name && self.name.split(" ").length < 2
        errors.add(:name, "must contain both a first name and last name")
      end
    end

    def self.authenticate_with_credentials(email, password)
        user = User.where("lower(email) = ?", email.downcase.strip).first
        if user && user.authenticate(password)
            return user
        else
            nil
        end
    end

end
