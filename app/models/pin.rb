class Pin < ApplicationRecord
  belongs_to :user
  mount_uploaders :photo, PhotoUploader


end
