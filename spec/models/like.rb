
require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:blog) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:user_id).scoped_to(:blog_id) }
  end
end