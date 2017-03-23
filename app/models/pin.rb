class Pin < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  include PgSearch

  pg_search_scope :search_full_text,
  :using => {
    :tsearch => { :any_word => true }
  },
  :against => {
    :title => 'A',
    :description => 'B'
  }

end
