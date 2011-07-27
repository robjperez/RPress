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
  if params[:notename].end_with? '.rp' then
    note = merge_content params[:notename]
    haml :view_note, :locals => { :content => note, :note_title => params[:notename] }
  end
end

post '/:notename' do
  if params[:notename].end_with? '.rp' then
    save_content params[:notename], params[:note_content]

    redirect '/'
  end
end
