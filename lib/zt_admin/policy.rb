#! /usr/bin/env ruby
################################################################################
#   policy.rb
#
#   Generates policy file for a Model
#
#   30.01.2017  ZT
################################################################################

module ZtAdmin
  relative_path = "app/policies/#{$name}_policy.rb"
  absolute_path = "#{AppRoot}/#{relative_path}"

  action_report relative_path
  file = File.open(absolute_path, 'w')

  file.puts "class #{$model}Policy < ApplicationPolicy"

  file.puts "\n#{TAB}# For index"
  file.puts "#{TAB}class Scope < Scope"
  file.puts "#{TAB*2}def resolve"
  file.puts "#{TAB*3}if (user.superadmin? || user.admin? || user.manager?)\n#{TAB*4}scope.all\n#{TAB*4}else\n#{TAB*4}nil\n#{TAB*3}end"
  file.puts "#{TAB*2}end"
  file.puts "#{TAB}end"

  file.puts "\n#{TAB}def show?\n#{TAB*2}user.superadmin? || user.admin? || user.manager?\n#{TAB}end"
  file.puts "\n#{TAB}def create?\n#{TAB*2}user.superadmin? || user.admin?\n#{TAB}end"
  file.puts "\n#{TAB}def new?\n#{TAB*2}create?\n#{TAB}end"
  file.puts "\n#{TAB}def edit?\n#{TAB*2}user.superadmin? || user.admin?\n#{TAB}end"
  file.puts "\n#{TAB}def update?\n#{TAB*2}user.superadmin? || user.admin?\n#{TAB}end"
  file.puts "\n#{TAB}def destroy?\n#{TAB*2}user.superadmin? || user.admin?\n#{TAB}end"

  file.puts "end"
  file.close
end
