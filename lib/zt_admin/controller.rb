#!/usr/bin/env ruby
################################################################################
#   Generates Admin Controller for the given Model
#
#   05.03.2015  ZT (bkc_admin version)
#   07.07.2016  modified to generate a standard rails controller code
#   10.09.2016  corrected: admin namespace & add password to permission list
#   09.11.2016  BaseController & basepolymorphic_url
#   21.01.2017  Flash & no polymorphic way
################################################################################
module ZtAdmin
  # admin directory
  relative_path = 'app/controllers/admin'
  admin_path    = "#{AppRoot}/#{relative_path}"

  action_report relative_path
  Dir.mkdir(admin_path) unless File.exist?(admin_path)

  # Controller file
  relative_path = "app/controllers/admin/#{$names}_controller.rb"
  absolute_path = "#{AppRoot}/#{relative_path}"
  action_report relative_path

  file = File.open(absolute_path, 'w')

  # Generate controller code

  file.puts "class Admin::#{$models}Controller < Admin::BaseController"
  file.puts "#{TAB}before_action :set_#{$name}, only: [:show, :edit, :update,:destroy]"

  file.puts "\n#{TAB}def index\n#{TAB*2}@#{$names} = policy_scope(#{$model})\n#{TAB}end"
#  file.puts "\n#{TAB}def index\n#{TAB*2}@#{$names} = #{$model}.all\n#{TAB*2}authorize @#{$names}\n#{TAB}end"

  file.puts "\n#{TAB}def show\n#{TAB*2}authorize @#{$name}\n#{TAB}end"

  file.puts "\n#{TAB}def new\n#{TAB*2}@#{$name} = #{$model}.new\n#{TAB*2}authorize @#{$name}\n#{TAB}end"

  file.puts "\n#{TAB}def edit\n#{TAB*2}authorize @#{$name}\n#{TAB}end"

  file.puts "\n#{TAB}def create\n#{TAB*2}@#{$name} = #{$model}.new(#{$name}_params)\n#{TAB*2}authorize @#{$name}"
  file.puts "#{TAB*2}if @#{$name}.save"
  file.puts "#{TAB*3}flash[:success] = t('messages.created', model: @#{$name}.class.model_name.human)"
  file.puts "#{TAB*3}redirect_to [:admin, @#{$name}]"
  file.puts "#{TAB*2}else#{TAB*3}\n#{TAB*3}render :new\n#{TAB*2}end\n#{TAB}end"
  #file.puts "\n#{TAB*2}if @#{$name}.save\n#{TAB*3}redirect_to polymorphic_url([:admin, @#{$name}], locale: params[:locale]), notice: t('messages.created', model: @#{$name}.class.model_name.human)\n#{TAB*2}else\n#{TAB*3}render :new\n#{TAB*2}end\n#{TAB}end"

  file.puts "\n#{TAB}def update\n#{TAB*2}authorize @#{$name}"
  file.puts "#{TAB*2}if @#{$name}.update(#{$name}_params)"
  file.puts "#{TAB*3}flash[:success] = t('messages.updated', model: @#{$name}.class.model_name.human)"
  file.puts "#{TAB*3}redirect_to [:admin, @#{$name}]"
  file.puts "#{TAB*2}else#{TAB*3}\n#{TAB*3}render :edit\n#{TAB*2}end\n#{TAB}end"

  file.puts "\n#{TAB}def destroy\n#{TAB*2}authorize @#{$name}"
  file.puts "#{TAB*2}@#{$name}.destroy"
  file.puts "#{TAB*2}flash[:success] = t('messages.deleted', model: @#{$name}.class.model_name.human)"
  file.puts "#{TAB*2}redirect_to admin_#{$names}_path\n#{TAB}end"

  file.puts "\n#{TAB}private"

  file.puts "\n#{TAB*2}# Uses callbacks to share common setup or constraints between actions"
  file.puts "#{TAB*2}def set_#{$name}\n#{TAB*3}@#{$name} = #{$model}.find(params[:id])\n#{TAB*2}end"

  file.puts "\n#{TAB*2}# Only allows a trusted parameter 'white list' through"
  line = "#{TAB*2}def #{$name}_params\n#{TAB*3}params.require(:#{$name}).permit("
  $attr_names.each do |attr_name|
    if $references_names.include? attr_name
      line << ":#{attr_name}_id"                        # FK attribute
    else
      line << ":#{attr_name}"                           # Ordinary attribute
    end
    line << ", " unless attr_name== $attr_names.last    # Non-last attribute
  end

  if $model == "User"
    line << ",  :password, :password_confirmation"      # add password to the permission list
  end

  if $ancestry
    line << ", :ancestry"
  end

  if $content
    line << ", :content"
  end

  if $images
    line << ", :cover_image, :remove_cover_image, images: []"
  end

  line << ")\n#{TAB*2}end"
  file.puts line

  file.puts "end"
  file.close
end