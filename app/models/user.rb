class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable
         # , :omniauthable

  has_one :library
  has_one :wanted_list
  before_create :prepare_user

  def prepare_user
    self.library = Library.create
    self.wanted_list = WantedList.create
    # self.location = params[:user][:location]
    # puts "================================"
    # puts "================================"
    # puts self.location
    # puts "================================"
    # puts "================================"
    # self.
  end

  def add_to_library(item)
    self.library.add(item)
  end

  def add_to_wanted_list(item)
    self.wanted_list.add(item)
  end
end
