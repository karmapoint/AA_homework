# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  song       :string           not null
#  track_type :string           not null
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  TRACK_TYPES = %w(bonus regular)
  validates :album_id, :song, presence: true
  validates :track_type, inclusion: TRACK_TYPES
  belongs_to :album
  has_one :band
end
