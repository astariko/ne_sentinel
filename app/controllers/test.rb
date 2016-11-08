
require 'open-uri'
require 'nokogiri'
site = 'http://pssnfs-lx.mh.lucent.com/1830wiki/1830PSS_Fruits_G_Deliveries'
source = open(site){|f|f.read}

looking_for = "grape-"

#str = '<h1> first </h1><td> second </td> end'
doc = Nokogiri::HTML::Document.parse(source)
lines = doc.css("td").css("p[class='line862'], p[class='line891']").map(&:text)

results = Array.new

i = 0
load_data = nil
lines.each { |line|
  if line.strip.start_with?(looking_for)
    if load_data
      results << load_data
    end
    i = 0
    load_data = { :label => line.strip, :data => ''}
  
  elsif load_data
    case i
	when  0 then load_data[:swp] = line.strip
	when  1 then load_data[:date] = line.strip
	#when  2 then load_data[:status] = line.strip
	else load_data[:data] << line.strip
    end
    i += 1
  end
}

# At this point results contain a list of loads. Let's find most recent one, that did not fail.
res = nil
results.each{ |result|
  if result[:data].include? "Passed"
    res = result
    break
  end
}

puts res[:label] + " " + res[:swp]
