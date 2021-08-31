import ballerina/http;
//import ballerina/io;

public isolated client class Client {
    final http:Client clientEp;
    
    public isolated function init(string serviceUrl, http:ClientConfiguration clientConfig =  {}) returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }

    //Generic function. Can use for every mutation scenario (Option 1)
    remote isolated function mutation(string query, UserInsertInput[]? objects = (), UsersOnConflict? on_conflict = (), UsersBoolExp? updateUserWhere = (), UsersSetInput? _set = (), UsersBoolExp? deleteUserWhere = (), map<anydata>? additionalVariables = ()) returns MutationResponse|error? {
        http:Request request = new;
        json variables = {
            objects: objects.toJson(),
            on_conflict: on_conflict.toJson(),
            updateUserWhere: updateUserWhere.toJson(),
            _set: _set.toJson(),
            deleteUserWhere: deleteUserWhere.toJson()
        };
        variables = check variables.mergeJson(additionalVariables.toJson());
        json params = {
            query: query,
            variables: {}
        };
        request.setPayload(params.toJson());
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data;
        if (data is ()) {
            return;
        }
        return check data.cloneWithType(MutationResponse);
    }

    remote isolated function query(string query, string? id = (), int? 'limit = (), int? offset = (), map<anydata>? additionalVariables = ()) returns QueryResponse|error? {
        http:Request request = new;
        json variables = {
            id: id.toJson(),
            'limit: 'limit.toJson(),
            offset: offset.toJson()
        };
        variables = check variables.mergeJson(additionalVariables.toJson());
        json params = {
            query: query,
            variables: variables
        };
        request.setPayload(params);
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data;
        if (data is ()) {
            return;
        }
        return check data.cloneWithType(QueryResponse);
    }

    // Mutations
    remote isolated function insertUser(string query, UserInsertInput[] objects, UsersOnConflict? on_conflict = ()) returns UsersMutationResponse|error? {
        http:Request request = new;
        json variables = {
            objects: objects.toJson(),
            on_conflict: on_conflict.toJson()
        };
        ObjectParameters params = {
            query: query,
            variables: variables
        };
        request.setPayload(params.toJson());
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data.insert_users;
        if (data is ()) {
            return;
        }
        return check data.cloneWithType(UsersMutationResponse);
    }

    remote isolated function updateUser(string query, UsersBoolExp 'where, UsersSetInput? _set = ()) returns UsersMutationResponse|error? {
        http:Request request = new;
        json variables = {
            'where: 'where.toJson(),
            _set: _set.toJson()
        };
        ObjectParameters params = {
            query: query,
            variables: variables
        };
        request.setPayload(params.toJson());
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data.update_users;
        if (data is ()) {
            return;
        }
        return check data.cloneWithType(UsersMutationResponse);
    }

    remote isolated function deleteUser(string query, UsersBoolExp 'where) returns UsersMutationResponse|error? {
        http:Request request = new;
        json variables = {
            'where: 'where.toJson()
        };
        ObjectParameters params = {
            query: query,
            variables: variables
        };
        request.setPayload(params.toJson());
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data.delete_users;
        if (data is ()) {
            return;
        }
        return check data.cloneWithType(UsersMutationResponse);
    }

    //Queries
    remote isolated function getDragon(string query, string id) returns Dragon|error? {
        http:Request request = new;      
        ObjectParameters params = {
            query: query,
            variables: {
                id : 'id.toJson()
            }
        };
        request.setPayload(params.toJson());
        json response = check self.clientEp-> post("", request, targetType = json);
        json data = check response.data.dragon;
        if (data is ()) {
            return;
        }
        return check data.cloneWithType(Dragon);
    }

    remote isolated function getDragons(string query, int? 'limit = (), int? offset = ()) returns Dragon?[]|error? {
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
        if (data is ()) {
            return;
        }
        return check data.cloneWithType(DragonArray);
    }
}
