################################################################################
#   init.rb
#
#   First phase to start Application Admin generation: gets generic Gemfile
#
#   28.01.2017  ZT
#   20.06.2021  Bootstrap 4 + jQuery + popper.js (v.3.12)
#   20.06.2021  Bootstrap 5 - jQuery + @popperjs/core (v.3.13)
#   13.11.2021  UUID
################################################################################

module ZtAdmin
  begin
    if $uuid
      FileUtils.cp "#{generic}/Gemfile_uuid", "#{AppRoot}/Gemfile"
    else
      FileUtils.cp "#{generic}/Gemfile", AppRoot
    end
    puts colored GREEN, "\File 'Gemfile' has been updated"
    
    puts colored(MAGENTA, "Run commands now:")
    puts colored(MAGENTA, "#{TAB*2}bundle update; gem cleanup; bundle install")
    if ZtAdmin::VERSION[0..3] == '3.12'
      puts colored(MAGENTA, "#{TAB*2}yarn add bootstrap@4.5.3 jquery popper.js")
    else
      puts colored(MAGENTA, "#{TAB*2}yarn add react-bootstrap bootstrap @popperjs/core react-router-dom")
    end
    puts colored(MAGENTA, "#{TAB*2}yarn add @fortawesome/fontawesome-free")
    # puts colored(MAGENTA, "#{TAB*2}yarn add @fortawesome/fontawesome-svg-core @fortawesome/free-solid-svg-icons ")
    # puts colored(MAGENTA, "#{TAB*2}yarn add @fortawesome/free-brands-svg-icons @fortawesome/react-fontawesome")
    puts colored(MAGENTA, "#{TAB*2}ps aux | grep spring | grep -v 'grep' | awk '{print $2}' | xargs kill")
    puts colored(MAGENTA, "#{TAB*2}rails generate simple_form:install --bootstrap")
    puts colored(MAGENTA, "#{TAB*2}rails generate pundit:install")
    puts colored(MAGENTA, "#{TAB*2}zt_admin c[lone]")
  rescue Exception => error
    puts colored(RED, 'ACHTUNG! Something went wrong during initialization...')
    puts colored(RED, error.message)
  end
end
