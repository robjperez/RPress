require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'haml'
require './rpress_helper'

get '/' do
  files = []
  local_dir = Dir.new './docs'
  local_dir.select do |name|
    name.end_with? 'rp'
  end.each do |selected_name|
    files += [selected_name]
  end
  
  haml :index, :locals => { :files => files }
end

get '/:notename' do
  note = merge_content params[:notename]
  haml :view_note, :locals => { :content => note }
end
