package domain;

import com.google.gson.annotations.SerializedName;

import java.util.List;

public class Status {

    @SerializedName("next_offset")
    private int nextOffset;

    @SerializedName("records")
    private List<Contact> contacts;

    public int getNextOffset() {
        return nextOffset;
    }

    public void setNextOffset(int nextOffset) {
        this.nextOffset = nextOffset;
    }

    public List<Contact> getContacts() {
        return contacts;
    }

    public void setContacts(List<Contact> contacts) {
        this.contacts = contacts;
    }
}
