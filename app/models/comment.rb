class Comment < ApplicationRecord
    validates_presence_of :content

    belongs_to :blog
    belongs_to :user
  

end
