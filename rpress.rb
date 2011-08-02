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

get '/note/*.rp/view' do |note_name|
  note = merge_content "#{note_name}.rp"
  haml :view_note, :locals => { :content => note, :note_title => "#{note_name}.rp" }
end

get '/note/new' do
  new_note_name = "note_#{Time.now.strftime '%Y%m%d_%H%M%S'}.rp"
  haml :view_note, :locals => { :content => "", :note_title => new_note_name }
end

post '/note/*.rp/save' do |note_name|
  save_content "#{note_name}.rp", params[:note_content]
  redirect '/'
end

get '/note/*.rp/delete' do |note_name|
  
end
