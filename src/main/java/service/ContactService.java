package service;

import domain.Contact;

import java.time.LocalDate;
import java.util.List;

public interface ContactService {

    List<Contact> sortByClientAndContactDate(List<Contact> contacts);

    List<Contact> filterByDateAfter(List<Contact> contacts, LocalDate locDate);
}
