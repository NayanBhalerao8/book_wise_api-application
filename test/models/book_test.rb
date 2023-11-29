require "test_helper"

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  validates :title, presence: true, length: {minimum:3}
  validates :author, presence: true, length: {minimum:3}
end
