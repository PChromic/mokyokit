package service.impl;

import com.opencsv.CSVWriter;
import com.opencsv.bean.StatefulBeanToCsv;
import com.opencsv.bean.StatefulBeanToCsvBuilder;
import com.opencsv.exceptions.CsvException;
import domain.Contact;
import service.CsvWriter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.List;

public class CsvWriterImpl implements CsvWriter {

    public void writeCsvFile(List<Contact> contacts, String path) throws CsvException, IOException {

        Writer writer = new FileWriter(path);
        // add header to file
        writer.append("kontakt_id, klient_id, pracownik_id , status , kontakt_ts\n");
        // get
        StatefulBeanToCsvBuilder builder = new StatefulBeanToCsvBuilder(writer);
        StatefulBeanToCsv beanWriter = builder
                .withQuotechar(CSVWriter.NO_QUOTE_CHARACTER)
                .withSeparator(',')
                .build();

        beanWriter.write(contacts);
        writer.close();
    }
}
