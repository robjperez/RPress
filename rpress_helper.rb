def merge_content filename
  content = File.read "./docs/#{filename}"
  content.split("##").collect do |line|
    if File.exists? "./docs/#{line}" then
      merge_content if filename != line
    else
      line
    end
  end.join
end
