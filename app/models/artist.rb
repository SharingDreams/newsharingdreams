class Artist < ActiveRecord::Base
    has_many :arts

    extend FriendlyId

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_BIRTHDAY_REGEX = /[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}/

    validates_presence_of :username, :email, :country, :birthday, :full_name
    validates_presence_of :about, allow_blank: true

    validates_length_of :username, minimum: 2

    validates_format_of :email, with: VALID_EMAIL_REGEX
    validates_format_of :birthday, with: VALID_BIRTHDAY_REGEX

    validates_uniqueness_of :username
    validates_uniqueness_of :email

    validates :password, :presence => true, :confirmation => true, length: {minimum: 4}, :if => :password

    has_secure_password

    validate :date_of_birthday

    has_attached_file :photo, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }
    validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

    friendly_id :username, use: [:slugged, :history]

    before_create do |artist|
        artist.confirmation_token = SecureRandom.urlsafe_base64
    end

    def confirm!
        return if confirmed_at.present?

        self.confirmed_at = Time.current
        self.confirmation_token = ''

        save!
    end

    def date_of_birthday
        if self.birthday
            begin
                Date.parse(self.birthday)

                if self.birthday.to_date < 18.years.ago.to_date
                    errors.add(:birthday, "Você tem que ter menos de 18 anos.")
                elsif self.birthday.to_date > 13.years.ago.to_date
                    errors.add(:birthday, "Você tem que ter mais de 13 anos.")
                end
            rescue
                errors.add(:birthday, "Insira uma data correta.")
            end
        end
    end

    def self.authenticate(username, password)
        artist = find_by(username: username)

        if artist.present?
            artist.authenticate(password)
        end
    end

    def custom_update_attributes(params)
        if params[:password].blank?
            params.delete :password
            params.delete :password_confirmation
            update_attributes params
        end
  end

    def send_password_reset
        generate_token(:password_reset_token)
        self.password_reset_sent_at = Time.current

        save

        PasswordResetMailer.password_reset(self).deliver
    end

    def generate_token(column)
        begin
            self[column] = SecureRandom.urlsafe_base64
        end while Artist.exists?(column => self[column])
    end
end
