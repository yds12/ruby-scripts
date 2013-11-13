words = {}
words.default = 0

Dir.entries('.').each do |e|
  next unless File.file? e
  content = File.read e
  w = content.split /\W/
  w.each do |word|
    if word.length > 0
      words[word] += 1
    end
  end
end

result = words.sort_by do |k, v| v end

result.each do |r|
  puts "#{r[0]}\t\t#{r[1]}"
end
