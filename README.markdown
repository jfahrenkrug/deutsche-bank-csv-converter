Deutsche Bank CSV Converter
===========================

I recently signed up at [freeagentcentral.com][1] for my invoicing needs as a freelancer. It's a wonderful tool! I was disappointed though when I wanted to import my bank statements. Deutsche Bank offers a CSV export but in a format freeagent doesn't like. So I wrote this little converter script. You need to have the fastercsv gem installed.

[1]: http://www.freeagentcentral.com

It will convert a csv file like this one:

        Umsätze - Kontokorrentkonto (00) ;;;Kundennummer: 111/2222222;;
        01.01.2009; - 02.04.2009;
        Letzter Kontostand;;;;1234,56;EUR
        Gebuchte Umsätze (Vorgemerkte und noch nicht gebuchte Umsätze sind nicht Bestandteil dieser Aufstellung)
        Buchungstag;Wert;Verwendungszweck;Soll;Haben;Waehrung
        06.01.09;06.01.09;" Test GMBH RG 090101 V. 06.01.2008 SPRINGENWERK CONSULTING";;123,80;EUR
        06.01.09;06.01.09;" Test GMBH RG 090102 V. 06.01.2008 SPRINGENWERK CONSULTING";;1234,80;EUR
        06.01.09;06.01.09;" Some Insurance Company Bill";-123,52;;EUR
        06.01.09;06.01.09;" Taxes transferred to the IRS";-654,12;;EUR
        Kontostand (31.03.2009):;;;;3322,51;EUR
        
into one that looks like this:

        06/01/2009,123.80," Test GMBH RG 090101 V. 06.01.2008 SPRINGENWERK CONSULTING"
        06/01/2009,1234.80," Test GMBH RG 090102 V. 06.01.2008 SPRINGENWERK CONSULTING"
        06/01/2009,-123.52," Some Insurance Company Bill"
        06/01/2009,-654.12," Taxes transferred to the IRS"
        
Just run it like this:

        ruby dbcsvconvert.rb inputfile.csv outputfile.csv
        
Enjoy!        
