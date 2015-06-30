class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :member
  belongs_to :role
  has_many :posts
  has_many :contacts
  has_many :groups, :through => :member_groups
  has_many :member_groups
  has_many :requests

  scope :admins, -> { where('role_id in (?)', Role.admin_roles) }

  def is_all_admin?
  	role.is_all_admin?
  end

  def full_name
    member.full_name
  end 

  def is_group_admin?
    role.is_group_admin?
  end
  
  def visible_posts
    Post.active.approved.where("public = ? or group_id in (?)", true, groups.map(&:id))
  end

  def older_posts
    Post.notactive.approved.where("public = ? or group_id in (?)", true, groups.map(&:id)).limit(10)
  end

  def is_admin_of?(group)
    if group.instance_of? Group
      group.admins.include?(self)
    else
      false
    end
  end

  def is_member_of?(group)
    if group.instance_of? Group
      group.members.include?(self)
    else
      false
    end
  end

  #devise --deactivated account check
  def active_for_authentication?
    super && !self.deactivated # i.e. super && self.is_active
  end

  def inactive_message
    "Sorry, this account has been deactivated."
  end

  def verified?
    member.verified?
  end
end
