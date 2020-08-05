################################################################################
#   init.rb
#
#   First phase to start Application Admin generation: gets generic Gemfile
#
#   28.01.2017  ZT
#   05.08.2020  Last update
################################################################################

module ZtAdmin
  begin
    FileUtils.cp "#{generic}/Gemfile", AppRoot
    puts colored GREEN, "\File 'Gemfile' has been updated"
    
    puts colored(MAGENTA, "Run commands now:")
    puts colored(MAGENTA, "#{TAB2}bundle install")
    puts colored(MAGENTA, "#{TAB2}rails generate react:install")
    puts colored(MAGENTA, "#{TAB2}yarn add bootstrap jquery popper.js")
    puts colored(MAGENTA, "#{TAB2}yarn add @fortawesome/fontawesome-free")
    puts colored(MAGENTA, "#{TAB2}rails generate simple_form:install --bootstrap")
    puts colored(MAGENTA, "#{TAB2}rails generate pundit:install")
    puts colored(MAGENTA, "#{TAB2}zt_admin c[lone]")
  rescue Exception => error
    puts colored(RED, 'ACHTUNG! Something went wrong during initialization...')
    puts colored(RED, error.message)
  end
end
