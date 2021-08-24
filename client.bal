import ballerina/http;
//import ballerina/io;

public isolated client class Client {
    final http:Client clientEp;
    
    public isolated function init(string serviceUrl, http:ClientConfiguration clientConfig =  {}) returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }

    // Generic mutation function. Can use for every mutation scenario (Option 1)
    remote isolated function mutation(string query, json? variables = ()) returns json|error {
        http:Request request = new;
        json params = {
            query: query,
            variables: variables
        };
        request.setPayload(params);
        return check self.clientEp-> post("", request, targetType = json);
    }

    // Generic mutation function. Can use for every mutation scenario (Option 1)
    remote isolated function query(string query, json? variables = ()) returns json|error {
        http:Request request = new;
        json params = {
            query: query,
            variables: variables
        };
        request.setPayload(params);
        return check self.clientEp-> post("", request, targetType = json);
    }

    // Re-engineered mutation functions (Option 3)
    remote isolated function insertUser(string query, InsertUserVariables? variables = ()) returns json|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: variables.toJson()
        };
        request.setPayload(params.toJson());
        return check self.clientEp-> post("", request, targetType = json);
    }

    // Re-engineered query functions (Option 3)
    remote isolated function getDragons(string query, GetDragonVariables? variables = ()) returns json|error {
        http:Request request = new;      
        ObjectParameters params = {
            query: query,
            variables: variables.toJson()
        };
        request.setPayload(params.toJson());
        return check self.clientEp-> post("", request, targetType = json);
    }

}

