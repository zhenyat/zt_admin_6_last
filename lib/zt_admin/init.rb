################################################################################
#   init.rb
#
#   First phase to start Application Admin generation: gets generic Gemfile
#
#   28.01.2017  ZT
#   20.06.2021  Bootstrap 4 + jQuery + popper.js
################################################################################

module ZtAdmin
  begin
    FileUtils.cp "#{generic}/Gemfile", AppRoot
    puts colored GREEN, "\File 'Gemfile' has been updated"
    
    puts colored(MAGENTA, "Run commands now:")
    puts colored(MAGENTA, "#{TAB*2}bundle update; gem cleanup; bundle install")
    puts colored(MAGENTA, "#{TAB*2}yarn add bootstrap@4.5.3 jquery popper.js")
    puts colored(MAGENTA, "#{TAB*2}yarn add @fortawesome/fontawesome-free")
    puts colored(MAGENTA, "#{TAB*2}ps aux | grep spring | grep -v 'grep' | awk '{print $2}' | xargs kil")
    puts colored(MAGENTA, "#{TAB*2}rails generate simple_form:install --bootstrap")
    puts colored(MAGENTA, "#{TAB*2}rails generate pundit:install")
    puts colored(MAGENTA, "#{TAB*2}zt_admin c[lone]")
  rescue Exception => error
    puts colored(RED, 'ACHTUNG! Something went wrong during initialization...')
    puts colored(RED, error.message)
  end
end
