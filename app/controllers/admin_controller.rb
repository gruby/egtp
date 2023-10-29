class AdminController < ApplicationController
  before_action :admin_only
  def index
    
  end

  def import_user
    if params[:query].present?
      require 'csv'
      old_users = CSV.parse(File.read("#{Rails.root}/storage/old.csv"), headers: true)
      emails = old_users.by_col[1]
      searched_email = params[:query].strip.downcase
      if emails.include?(searched_email)
        require 'json'
        languages = JSON.parse(File.read("#{Rails.root}/storage/global_languages.json"))
        #old_users_rights = Hash[*user_data["rights"].split("_")][language]        
        user_data = old_users.find {|row| row['email'] == searched_email}
        user_rights = Hash[*user_data["rights"].split("_")]
        u = User.new 
        u.email = searched_email
        u.name = user_data["name"]
        u.password_digest = user_data["password_digest"]
        u.language = languages[user_rights.keys[0]]
        u.nick = user_data["nick"]
        u.admin = false
        u.notifications = user_data["notifs"]
        u.active = true
        u.phone = user_data["phone"]
        u.address = user_data["address"]
        u.country = user_data["country"]
        u.save
        user_rights.each do |k, v|
          r = Right.new
          r.language_id = Language.find_by(name: languages[k]).id
          r.role = v
          r.user_id = u.id
          r.save
        end
        @message = "Jest user #{params[:query]} i nowy user o ID = #{u.id}"
      else
        @message = "Nie ma usera #{params[:query]}"
      end
    else
      @message = "Introduce an email"
    end
  end
end

#Hash[*rights.split("_")][language]