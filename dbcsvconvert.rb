# 2009, Johannes Fahrenkrug, http://springenwerk.com
# Licence: use it however you want.
#
# Converts CSV Files that look like this:
#
# Umsätze - Kontokorrentkonto (00) ;;;Kundennummer: 111/2222222;;
# 01.01.2009; - 02.04.2009;
# Letzter Kontostand;;;;1234,56;EUR
# Gebuchte Umsätze (Vorgemerkte und noch nicht gebuchte Umsätze sind nicht Bestandteil dieser Aufstellung)
# Buchungstag;Wert;Verwendungszweck;Soll;Haben;Waehrung
# 06.01.09;06.01.09;" Test GMBH RG 090101 V. 06.01.2008 SPRINGENWERK CONSULTING";;123,80;EUR
# 06.01.09;06.01.09;" Test GMBH RG 090102 V. 06.01.2008 SPRINGENWERK CONSULTING";;1234,80;EUR
# 06.01.09;06.01.09;" Some Insurance Company Bill";-123,52;;EUR
# 06.01.09;06.01.09;" Taxes transferred to the IRS";-654,12;;EUR
# Kontostand (31.03.2009):;;;;3322,51;EUR
#
# ...to something like this:
# 06/01/2009,123.80," Test GMBH RG 090101 V. 06.01.2008 SPRINGENWERK CONSULTING"
# 06/01/2009,1234.80," Test GMBH RG 090102 V. 06.01.2008 SPRINGENWERK CONSULTING"
# 06/01/2009,-123.52," Some Insurance Company Bill"
# 06/01/2009,-654.12," Taxes transferred to the IRS"
#
# NOTE: I whipped this up really quick for myself. Not much error handling or anything. Use at your own risk.

require 'rubygems'
require 'faster_csv'

# make sure we at least have the input file as an argument
if ARGV.size != 2
  puts "Usage: ruby dbcsvconvert.rb inputfile outputfile"
else
  inputfile = ARGV[0]
  outputfile = ARGV[1]
  puts "Input file: #{inputfile}"
  puts "Output file: #{outputfile}"
  
  converted_rows = []
  arr_of_arrs = FasterCSV.read(inputfile, :col_sep => ';')
  
  5.times {arr_of_arrs.shift} # remove first 5 lines
  arr_of_arrs.pop #remove last line
  
  arr_of_arrs.each {|row| converted_rows << [row[1].gsub('.', '/').insert(6, '20'), (row[3] || row[4]).gsub(',', '.'), row[2].strip]}

  File.open(outputfile, 'w') do |out|
    converted_rows.each {|row| out.puts "#{row[0]},#{row[1]},\"#{row[2]}\""}
  end  
end