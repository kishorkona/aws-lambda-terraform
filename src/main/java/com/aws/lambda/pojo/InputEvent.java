package com.aws.lambda.pojo;

import com.google.gson.JsonObject;
import lombok.Data;

import java.util.Map;

@Data
public class InputEvent {
    private String input;
    private String secretsName;
    private String action;
    Map<String, String> secrets;
    JsonObject envVarJson;
    private Map<String, String> localSecrets;
    private JsonObject localEnvvarsJson;


}
