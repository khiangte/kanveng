class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :member
  belongs_to :role
  has_many :posts
  has_many :groups, :through => :member_groups
  has_many :member_groups

  scope :admins, -> { where('role_id in (?)', Role.admin_roles) }

  def is_all_admin?
  	role.is_all_admin?
  end

end
