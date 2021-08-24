import ballerina/http;
//import ballerina/io;

public isolated client class Client {
    final http:Client clientEp;
    
    public isolated function init(string serviceUrl, http:ClientConfiguration clientConfig =  {}) returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }

    // Generic function. Can use for every mutation scenario (Option 1)
    remote isolated function mutation(string query, json? variables = ()) returns json|error {
        http:Request request = new;
        json params = {
            query: query,
            variables: variables
        };
        request.setPayload(params);
        return check self.clientEp-> post("", request, targetType = json);
    }

    remote isolated function query(string query, json? variables = ()) returns json|error {
        http:Request request = new;
        json params = {
            query: query,
            variables: variables
        };
        request.setPayload(params);
        return check self.clientEp-> post("", request, targetType = json);
    }

    // Mutations
    remote isolated function insertUser(string query, UserInsertInput[] objects, UsersOnConflict? on_conflict = ()) returns UsersMutationResponse|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: {
                objects: objects.toJson(),
                on_conflict: on_conflict.toJson()
            }
        };
        request.setPayload(params.toJson());
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data.insert_users;
        return check data.cloneWithType(UsersMutationResponse);
    }

    remote isolated function updateUser(string query, UsersBoolExp 'where, UsersSetInput? _set = ()) returns UsersMutationResponse|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: {
                'where: 'where.toJson(),
                _set: _set.toJson()
            }
        };
        request.setPayload(params.toJson());
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data.update_users;
        return check data.cloneWithType(UsersMutationResponse);
    }

    remote isolated function deleteUser(string query, UsersBoolExp 'where) returns UsersMutationResponse|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: {
                'where: 'where.toJson()
            }
        };
        request.setPayload(params.toJson());
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data.delete_users;
        return check data.cloneWithType(UsersMutationResponse);
    }

    //Queries
    remote isolated function getDragons(string query, int? 'limit = (), int? offset = ()) returns Dragon[]|error {
        http:Request request = new;      
        ObjectParameters params = {
            query: query,
            variables: {
                'limit : 'limit.toJson(),
                offset : offset.toJson()
            }
        };
        request.setPayload(params.toJson());
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data.dragons;
        return check data.cloneWithType(DragonArray);
    }
}
