class Art < ActiveRecord::Base
    belongs_to :artist

    extend FriendlyId

    validates_presence_of :title, :image

    validates_length_of :title, minimum: 2

    has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", small: "150x150>", thumb: "100x100>" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    friendly_id :title, use: [:slugged, :history]

    def self.search(query)
        if query.present?
            where(['title LIKE :query', query: "%#{query}%"])
        else
            all
        end
    end
end
