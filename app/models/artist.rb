class Artist < ActiveRecord::Base
    has_many :arts

    extend FriendlyId

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_BIRTHDAY_REGEX = /[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}/

    validates_presence_of :username, :email, :country, :birthday
    validates_presence_of :about, allow_blank: true

    validates_length_of :username, minimum: 2

    validates_format_of :email, with: VALID_EMAIL_REGEX
    validates_format_of :birthday, with: VALID_BIRTHDAY_REGEX

    validates_uniqueness_of :username
    validates_uniqueness_of :email

    validates :password, presence: true

    has_secure_password

    validate :date_of_birthday

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

end
