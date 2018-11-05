package service.impl;

import domain.Contact;
import service.ContactService;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class ContactServiceImpl implements ContactService {

    @Override
    public List<Contact> sortByClientAndContactDate(List<Contact> contacts){

        contacts.sort((contact1, contact2) -> {

            long contact1Id = contact1.getClientId();
            long contact2Id = contact2.getClientId();

            if (contact1Id == contact2Id) {

                Date contact1Timestamp = contact1.getContactTimestamp();
                Date contact2Timestamp = contact2.getContactTimestamp();

                if (contact1Timestamp.equals(contact2Timestamp)) {
                    return 0;
                }
                else if (contact1Timestamp.before(contact2Timestamp)) {
                    return -1;
                }
                else {
                    return 1;
                }
            }
            else if (contact1Id < contact2Id) {
                return -1;
            }
            else {
                return 1;
            }
        });

        return contacts;
    }

    @Override
    public List<Contact> filterByDateAfter(List<Contact> contacts, LocalDate locDate) {

        Date date = java.sql.Date.valueOf(locDate);

        return contacts.stream()
                .filter(d -> d.getContactTimestamp().after(date))
                .collect(Collectors.toList());
    }
}
