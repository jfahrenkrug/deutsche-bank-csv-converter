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
        
Or it will convert credit card statements like this one:

        Kreditkartentransaktionen
        VISA 1234 5678 9101 1121 JOHN DOE
        
        Abrechnungsdatum:  20.03.2009
        Belegdatum;Eingangstag;Verwendungszweck;Fremdwährung;Betrag;Kurs;Betrag;Währung;
        07.03.2009;09.03.2009;MALDRON HOTEL DUBLIN 2 ; ; ;;-20,00;EUR;
        11.03.2009;13.03.2009;GITHUB ;USD;-12,00;1,27718;-9,40;EUR;
        11.03.2009;13.03.2009;1,75% / mind. 1,50 Euro A usla ndseinsatzentgelt ; ; ;;-1,50;EUR;
        20.03.2009;20.03.2009;Jahresbeitrag  ; ; ;;-30,00;EUR;
        Summe: ;;;;;;-60,90;EUR

into one that looks like this (by passing the -cc option):
        
        07/03/2009,-20.00,"MALDRON HOTEL DUBLIN 2"
        11/03/2009,-9.40,"GITHUB"
        11/03/2009,-1.50,"1,75% / mind. 1,50 Euro A usla ndseinsatzentgelt"
        20/03/2009,-30.00,"Jahresbeitrag"
        
Just run it like this:

        ruby dbcsvconvert.rb inputfile.csv outputfile.csv
        
Or for credit card statements:

        ruby dbcsvconvert.rb -cc inputfile.csv outputfile.csv
        
Enjoy!        
