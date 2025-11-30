package com.aws.lambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.aws.lambda.pojo.TraceScheduledEvent;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ObjectUtils;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueRequest;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueResponse;

import java.util.Map;
import java.util.Optional;

@Slf4j
public class Application implements RequestHandler<TraceScheduledEvent, Object> {

    private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    @Override
    public Object handleRequest(TraceScheduledEvent traceScheduledEvent, Context context) {
        log.info("handleRequest called..");
        return "SUCCESS";
    }

    public static Map<String, String> readSecrets(JsonObject envVarJson, String secretsName) throws RuntimeException {
        String secretString;
        try {
            String currentRegion = System.getenv("AWS_REGION");
            SecretsManagerClient client = SecretsManagerClient.builder().region(Region.of(currentRegion)).build();
            GetSecretValueRequest request = GetSecretValueRequest.builder().secretId(secretsName).build();
            GetSecretValueResponse resp = client.getSecretValue(request);
            if(resp == null) {
                throw new RuntimeException("Could not read secrets");
            }
            secretString = ObjectUtils.isNotEmpty(resp) ? resp.secretString() : "";
            log.info("secretString: {}", secretString);
            return gson.fromJson(secretString, new TypeToken<Map<String, String>>() {
            }.getType());
        } catch(Exception ex) {
            log.error("Unable to read secrets {}",ex);
            throw new RuntimeException(ex);
        }
        //return null;
    }
}
