namespace :debug do
  desc "TODO"
  task generate_fake_user: :environment do
    if User.all.count == 0
      u = User.new
      u.provider    = 'fake_session'
      u.uid         = '0'
      u.screen_name = 'FakeAdmin'
      u.name        = 'Fake Admin'
      if u.save
        puts "Fake user created!"
      else
        puts "Fake user not created ... Save failed"
      end
    else
      puts "Fake user not created ... User already exists"
    end
  end

end
