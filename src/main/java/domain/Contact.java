package domain;

import com.google.gson.annotations.SerializedName;
import com.opencsv.bean.CsvBindByPosition;
import enums.ContactStatus;

import java.sql.Timestamp;
import java.util.Date;

public class Contact {

    @CsvBindByPosition(position = 0)
    @SerializedName("kontakt_id")
    long contactId;

    @CsvBindByPosition(position = 1)
    @SerializedName("klient_id")
    long clientId;

    @CsvBindByPosition(position = 2)
    @SerializedName("pracownik_id")
    long workerId;

    @CsvBindByPosition(position = 3)
    @SerializedName("status")
    ContactStatus contactStatus;

    @CsvBindByPosition(position = 4)
    @SerializedName("kontakt_ts")
    Timestamp contactTimestamp;

    public Contact() {
    }

    public Contact(Long contactId, Long clientId, Long workerId, ContactStatus status, Timestamp contactTimestamp) {
        this.contactId = contactId;
        this.clientId = clientId;
        this.workerId = workerId;
        this.contactStatus = status;
        this.contactTimestamp = contactTimestamp;
    }

    public long getContactId() {
        return contactId;
    }

    public void setContactId(Long contactId) {
        this.contactId = contactId;
    }

    public long getClientId() {
        return clientId;
    }

    public void setClientId(Long clientId) {
        this.clientId = clientId;
    }

    public long getWorkerId() {
        return workerId;
    }

    public void setWorkerId(Long workerId) {
        this.workerId = workerId;
    }

    public ContactStatus getContactStatus() {
        return contactStatus;
    }

    public void setContactStatus(ContactStatus contactStatus) {
        this.contactStatus = contactStatus;
    }

    public Date getContactTimestamp() {
        return contactTimestamp;
    }

    public void setContactTimestamp(Timestamp contactTimestamp) {
        this.contactTimestamp = contactTimestamp;
    }
}
