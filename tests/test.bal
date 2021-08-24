import ballerina/test;
import ballerina/log;

Client baseClient = check new Client("https://api.spacex.land/graphql/");

@test:Config {}
function  exampleMutation() {

    string insertUserString = string `mutation ($objects: [users_insert_input!]!) {
                                insert_users(objects: $objects) {
                                    affected_rows
                                }
                            }`;

    json vars = {
        objects: [
            {name: "Sachi"},
            {name: "H"}
        ]
    };

    json|error bEvent = baseClient->mutation(insertUserString, vars);

    if (bEvent is json) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail(msg = bEvent.message());
    }
}

@test:Config {}
function  insertUser() {

    string insertUserString = string `mutation ($objects: [users_insert_input!]!) {
                                insert_users(objects: $objects) {
                                    affected_rows
                                }
                            }`;

    InsertUserVariables vars = {
        objects: []
    };

    json|error bEvent = baseClient->insertUser(insertUserString, vars);

    if (bEvent is json) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail(msg = bEvent.message());
    }
}

@test:Config {}
function  getDragon() {

    string dragonString = string `query ($limit: Int, $offset: Int) {
                                    dragons (limit: $liit, offset: $offset) {
                                        name
                                        active
                                    }
                                }`;

    GetDragonVariables vars = {
        'limit: 1
    };

    json|error bEvent = baseClient->getDragons(dragonString, vars);

    if (bEvent is json) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail(msg = bEvent.message());
    }
}
