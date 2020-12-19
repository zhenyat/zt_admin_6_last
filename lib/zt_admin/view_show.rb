#!/usr/bin/env ruby
#################################################################################
#   view_show.rb
#
#   Generates View file: admin/views/<model>/show.html.haml
#
#   05.03.2015  ZT (for bkc_admin)
#   06.07.2016  Copied for zt_admin
#   02.08.2016  Updated with bootstrap
#   03.08.2016  Bugs fixed
#   19.12.2020  RichText & ActiveStorage Images fields are added
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/show.html.haml"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/show.html.haml", 'w')

  file.puts ".container"
  #file.puts "%p#notice= notice\n\n"
  file.puts "#{TAB}%h1= t #{$model}.model_name.human"

  file.puts "#{TAB}%table.table.table-striped\n#{TAB*2}%tbody"
  file.puts "#{TAB*3}- @#{$name}.attributes.each do |key, value|"

  file.puts "#{TAB*4}- if key == 'id' || key.include?('digest') || key == 'created_at' || key == 'updated_at'"
  file.puts "#{TAB*5}//skip these attributes"
  file.puts "#{TAB*4}- else"
  file.puts "#{TAB*5}%tr"
  file.puts "#{TAB*6}- if key == 'status'"
  file.puts "#{TAB*7}%td= t 'status.status'"
  file.puts "#{TAB*7}%td= status_mark @#{$name}.status"
  file.puts "#{TAB*6}- else"
  file.puts "#{TAB*7}%td= t " << '"activerecord.attributes.' << "#{$name}." << '#{key}"'
  file.puts "#{TAB*7}%td= value"

  # Images & Rich Text
  file.puts "#{TAB*3}= render 'admin/shared/show_images', object: @#{$name}"
  file.puts "#{TAB}= render 'admin/shared/show_rich_text_content', object: @#{$name}"
  file.puts "#{TAB}= render 'admin/shared/show_actions', object: @#{$name}"

  file.close
end