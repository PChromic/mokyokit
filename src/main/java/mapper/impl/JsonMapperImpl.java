package mapper.impl;

import com.google.gson.Gson;
import domain.Status;
import mapper.JsonMapper;

public class JsonMapperImpl implements JsonMapper {

    private final Gson gson;

    public JsonMapperImpl(Gson gson) {
        this.gson = gson;
    }

    @Override
    public String toJson(Status status) {
        return gson.toJson(status);
    }

    @Override
    public Status fromJson(String jsonStatus) {
        return gson.fromJson(jsonStatus, Status.class);
    }
}
