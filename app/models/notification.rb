class Notification < ActiveRecord::Base
  belongs_to :recipient, :class_name => "User"
  belongs_to :target, :polymorphic => :true
  default_scope order("created_at desc")
end

# == Schema Information
#
# Table name: notifications
#
#  id           :integer(4)      not null, primary key
#  recipient_id :integer(4)      not null
#  target_id    :integer(4)      not null
#  target_type  :string(255)     not null
#  unread       :integer(4)      default(1)
#  type         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

