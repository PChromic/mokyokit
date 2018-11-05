package service;

import com.opencsv.exceptions.CsvException;
import domain.Contact;

import java.io.IOException;
import java.util.List;

public interface CsvWriter {

    void writeCsvFile(List<Contact> contacts, String path) throws CsvException, IOException;

}

