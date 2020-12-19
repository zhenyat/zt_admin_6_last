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

  file.puts "\n#{TAB*3}- if #{$model}.reflect_on_attachment(:cover_image).present?"
  file.puts "#{TAB*4}%tr"
  file.puts "#{TAB*5}%td= t 'images.cover_image'"
  file.puts "#{TAB*5}%td"
  file.puts "#{TAB*6}- if #{$name}.cover_image.attached?"
  file.puts "#{TAB*7}= image_tag #{$name}.cover_image.variant(resize_to_limit: [100, 100])"
  file.puts "#{TAB*4}%tr"
  file.puts "#{TAB*5}%td= t 'images.gallery'"
  file.puts "#{TAB*5}%td"
  file.puts "#{TAB*6}%tr"
  file.puts "#{TAB*7}- if #{$name}.images.attached?"
  file.puts "#{TAB*8}- #{$name}.images.each do |image|"
  file.puts "#{TAB*9}%td{:style => 'width:10%'}= image_tag image.variant(resize_to_limit: [50, 50])"
  file.puts "#{TAB}- if #{$model}.reflect_on_association(:rich_text_content).present?"
  file.puts "#{TAB*2}= t 'content'"
  file.puts "#{TAB*2}.content-area= @#{$name}.content"

  file.puts "\n.form_actions"
  file.puts "#{TAB}.row\n#{TAB*2}.col-md-2"
  file.puts "#{TAB*3}= link_to t('actions.back'), admin_#{$names}_path, class: 'btn btn-primary btn-sm'"

  file.close
end