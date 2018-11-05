import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opencsv.exceptions.CsvException;
import domain.Status;
import service.CsvWriter;
import service.impl.CsvWriterImpl;
import mapper.JsonMapper;
import mapper.impl.JsonMapperImpl;
import service.ContactService;
import service.FileService;
import service.impl.ContactServiceImpl;
import service.impl.FileServiceImpl;

import java.io.IOException;
import java.time.LocalDate;

public class ContactApplication {

    private static FileService fileService;
    private static ContactService contactService;
    private static JsonMapper statusMapper;
    private static Gson gson;
    private static CsvWriter writer;


    public static void main(String[] args) throws IOException, CsvException {

        initServices();

        String jsonStatus = fileService.readJsonFile("statuses.json");
        Status status = statusMapper.fromJson(jsonStatus);
        status.setContacts(contactService.filterByDateAfter(status.getContacts(), LocalDate.of(2017,7,1)));
        status.setContacts(contactService.sortByClientAndContactDate(status.getContacts()));
        writer.writeCsvFile(status.getContacts(), "statuses.csv");
    }

    private static void initServices() {
        fileService = new FileServiceImpl();
        gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        statusMapper = new JsonMapperImpl(gson);
        contactService = new ContactServiceImpl();
        writer = new CsvWriterImpl();
    }
}
