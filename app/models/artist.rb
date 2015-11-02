class Artist < ActiveRecord::Base
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_BIRTHDAY_REGEX = /[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}/

    validates_presence_of :username, :email, :country, :about, :birthday

    validates_length_of :username, minimum: 2
    validates_length_of :about, minimum: 5

    validates_format_of :email, with: VALID_EMAIL_REGEX
    validates_format_of :birthday, with: VALID_BIRTHDAY_REGEX

    validates_uniqueness_of :username, :email

    has_secure_password

    def date_of_birthday
        if self.birthday
            begin
                Date.parse(self.birthday)

                if self.birthday.to_date >= 18.years.ago.to_date
                    errors.add(:birthday, "Você tem que ter menos de 18 anos.")
                end
            rescue
                errors.add(:birthday, "Insira uma data correta.")
            end
        end
    end

end
