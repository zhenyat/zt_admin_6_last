#!/usr/bin/env ruby
################################################################################
#   view_form.rb
#
#   Generates partial file: admin/views/<models>/_form.html.haml
#
#   23.02.2015  ZT (bkc_admin)
#   09.07.2016  Updated for zt_admin
#   21.07.2016  no blank option for DDL
#   02.08.2016  Final update for bootstrap
#   03.08.2016  Bug fixed
#   19.12.2020  RichText & ActiveStorage Images fields are added
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/_form.html.haml"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/_form.html.haml", 'w')
  file.puts ".container"
  file.puts "#{TAB}.row"
  file.puts "#{TAB*2}.col-ms-6"  # DO NOT UNDERSTAND why '-ms-' working!
  file.puts "#{TAB*3}= simple_form_for([:admin, @#{$name}], html: {multipart: true}) do |f|"

  # Errors block
  file.puts "#{TAB*4}= f.error_notification message: t('messages.error_notification')"

  # Input fields
  file.puts "\n#{TAB*4}.form-inputs"

  $attr_names.each_with_index do |attr_name|
    if attr_name.match 'password'
      file.puts "#{TAB*5}= f.input :password"
      file.puts "#{TAB*5}= f.input :password_confirmation"
    elsif attr_name.match 'remember_digest'
      # skip the attribute
    elsif attr_name.match 'position'
      file.puts "#{TAB*5}= f.input :#{attr_name}, as: :hidden"
    elsif attr_name.match 'status'
      file.puts "\n#{TAB*5}= f.input :status, default: 0"
     file.puts "#{TAB*5}/= render 'admin/shared/status_buttons', f: f"
    else
      if $enum.include?(attr_name)
        file.puts "#{TAB*5}= f.input :#{attr_name}, include_blank: false"
      else
        file.puts "#{TAB*5}= f.input :#{attr_name}"
      end
    end
  end

  # Rich Text Input field
  file.puts "\n#{TAB*5}- if #{$model}.reflect_on_association(:rich_text_content).present?"
  file.puts "#{TAB*6}= f.label t 'content'"
  file.puts "#{TAB*6}.content-area= f.rich_text_area :content"

  # Cover Image fields
  file.puts "\n#{TAB*5}- if #{$model}.reflect_on_attachment(:cover_image).present?"
  file.puts "#{TAB*6}%hr"
  file.puts "#{TAB*6}.row"
  file.puts "#{TAB*7}.col-offset-1.col-md-4"
  file.puts "#{TAB*8}= f.label t 'images.cover_image'"
  file.puts "#{TAB*6}.row"
  file.puts "#{TAB*7}.col-md-4"
  file.puts "#{TAB*8}= f.file_field :cover_image"
  file.puts "#{TAB*6}%br"

  file.puts "\n#{TAB*6}.row"
  file.puts "#{TAB*7}- if @#{$name}.cover_image.attached?"
  file.puts "#{TAB*8}.col-md-3"
  file.puts "#{TAB*9}= image_tag @sample.cover_image.variant(resize_to_fit: [100, 100])"
  file.puts "#{TAB*8}.col-md-3"
  file.puts "#{TAB*9}= f.check_box :remove_cover_image"
  file.puts "#{TAB*9}%i.fas.fa-trash"

  # Images Gallery Fields
  file.puts "\n#{TAB*5}- if #{$model}.reflect_on_attachment(:images).present?"
  file.puts "#{TAB*6}%hr"
  file.puts "#{TAB*6}.row"
  file.puts "#{TAB*7}.col-md-4"
  file.puts "#{TAB*8}= f.label t 'images.gallery'"
  file.puts "#{TAB*6}.row"
  file.puts "#{TAB*7}.col-md-4"
  file.puts "#{TAB*8}= f.file_field :images, multiple: true"
  file.puts "#{TAB*6}%br"
  file.puts "#{TAB*6}.row"
  file.puts "#{TAB*7}- if @#{$name}.images.attached?"
  file.puts "#{TAB*8}- @#{$name}.images.each do |image|"
  file.puts "#{TAB*9}.col-md-3"
  file.puts "#{TAB*10}= image_tag image.variant(resize_to_fit: [100, 100])"
  file.puts "#{TAB*10}= check_box_tag 'image_to_remove_ids[]', image.id"
  file.puts "#{TAB*10}%i.fas.fa-trash"
    
  file.puts "#{TAB*4}%hr"
  file.puts "\n#{TAB*4}.form_actions"
  file.puts "#{TAB*5}.row"

  file.puts "#{TAB*6}.col-sm-3"
  file.puts "#{TAB*7}= f.submit t('actions.save'), class: 'btn btn-primary btn-sm'"

  #file.puts "#{TAB*6}.col-sm-3"
  #file.puts "#{TAB*7}= link_to t('actions.save'), admin_#{$name}_path, class: 'btn btn-info btn-sm' unless @#{$name}.new_record?"

  file.puts "#{TAB*6}.col-sm-3"
  file.puts "#{TAB*7}= link_to t('actions.back'), admin_#{$names}_path, class: 'btn btn-info btn-sm'"

  file.close
end