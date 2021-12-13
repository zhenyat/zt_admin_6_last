################################################################################
#   init.rb
#
#   First phase to start Application Admin generation: gets generic Gemfile
#
#   28.01.2017  ZT
#   20.06.2021  Bootstrap 4 + jQuery + popper.js (v.3.12)
#   20.06.2021  Bootstrap 5 - jQuery + @popperjs/core (v.3.13)
#   13.11.2021  UUID
#   12.12.2021  database option ($dbname)
################################################################################

module ZtAdmin
  begin
    if ($uuid && $dbname != 'postgresql')
      puts colored(RED, "#{TAB}uuid is applied with PostgreSQL only!")
      exit
    end

    file_in = "#{generic}/Gemfile_pattern"
    file_out = "#{AppRoot}/Gemfile"

    if $dbname == 'sqlite'
      accepted_lines = File.readlines(file_in).reject { |line| line.match(/^gem 'mysql2'/) }
      accepted_lines = accepted_lines.reject { |line| line.match(/^gem 'pg'/) }
      accepted_lines = accepted_lines.reject { |line| line.match(/^gem 'pg_search'/) }
    elsif $dbname == 'mysql'
      accepted_lines = File.readlines(file_in).reject { |line| line.match(/^gem 'sqlite3'/) }
      accepted_lines = accepted_lines.reject { |line| line.match(/^gem 'pg'/) }
      accepted_lines = accepted_lines.reject { |line| line.match(/^gem 'pg_search'/) }
    else  # postgresql
      accepted_lines = File.readlines(file_in).reject { |line| line.match(/^gem 'sqlite3'/) }
      accepted_lines = accepted_lines.reject { |line| line.match(/^gem 'mysql2'/) }
    end

    if !$uuid
      accepted_lines = accepted_lines.reject { |line| line.match(/^gem 'securerandom'/) } 
    end
    
    File.open(file_out, "w") { |f| accepted_lines.each { |line| f.puts line } }

    # if $uuid or $dbname == 'postgresql'
    #   FileUtils.cp "#{generic}/Gemfile_uuid", "#{AppRoot}/Gemfile"
    # else
    #   FileUtils.cp "#{generic}/Gemfile", AppRoot
    # end
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
