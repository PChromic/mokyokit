package mapper;

import domain.Status;

public interface JsonMapper {

    String toJson(Status status);

    Status fromJson(String jsonStatus);
}
