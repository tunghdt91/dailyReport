namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(email: "admin@framgia.com",
                 active: true,
                 group_id: 6,
                 group_manager: true,
                 admin: true,
                 password: "framgia",
                 md5: Digest::MD5.hexdigest("admin@framgiaframgia.com"),
                 password_confirmation: "framgia")
  	Group.create!(user_id: 1,
  				 	r: true,
  				 	e: true,
  				 	d: true,
  				 	group_id: 6,
  				 	manager: true)
  	Namegroup.create!(group_id:6)

  	Catalog.create!(
  		name: "Catalog Test",
  		detail: "Nothing")

  end
end