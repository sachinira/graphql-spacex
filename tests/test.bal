import ballerina/test;
import ballerina/log;

Client baseClient = check new Client("https://api.spacex.land/graphql/");

// @test:Config {}
// function  exampleMutation() {

//     string insertUserString = string `mutation ($objects: [users_insert_input!]!) {
//                                 insert_users(objects: $objects) {
//                                     affected_rows
//                                 }
//                             }`;

//     json vars = {
//         objects: [
//             {name: "Sachi"},
//             {name: "Hiruni"}
//         ]
//     };

//     json|error bEvent = baseClient->mutation(insertUserString, vars);

//     if (bEvent is json) {
//         log:printInfo(bEvent.toString());
//     } else {
//         test:assertFail(msg = bEvent.message());
//     }
// }

// @test:Config {}
// function  exampleQuery() {

//     string rockets = string `query {
//                                 rockets {
//                                     active
//                                     name
//                                 }
//                             }`;

//     json|error bEvent = baseClient->query(rockets);

//     if (bEvent is json) {
//         log:printInfo(bEvent.toString());
//     } else {
//         test:assertFail(msg = bEvent.message());
//     }
// }


@test:Config {}
function  insertUser() {

    string insertUserString = string `mutation ($objects: [users_insert_input!]!) {
                                insert_users(objects: $objects) {
                                    affected_rows
                                }
                            }`;

    UsersMutationResponse|error bEvent = baseClient->insertUser(insertUserString, [{name: "Sachi"}]);

    if (bEvent is UsersMutationResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail(msg = bEvent.message());
    }
}

@test:Config {}
function  updateUser() {

    string updateUserString = string `mutation ($where: users_bool_exp!, $_set: users_set_input) {
                                        update_users(where: $where, _set: $_set) {
                                            affected_rows
                                            returning {
                                                name
                                            }
                                        }
                                    }`;
  
    UsersBoolExp 'where = {
        id: {
            _eq: "89b9d27d-dd79-48d9-a251-16e188c0720d"
        }
    };

    UsersSetInput set = {
        name: "Sachini"
    };

    UsersMutationResponse|error bEvent = baseClient->updateUser(updateUserString, 'where , set);

    if (bEvent is UsersMutationResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail(msg = bEvent.message());
    }
}

@test:Config {}
function  deleteUser() {

    string updateUserString = string `mutation ($where: users_bool_exp!) {
                                        delete_users(where: $where) {
                                            affected_rows
                                        }
                                    }`;
                                        
    UsersBoolExp 'where = {
        id: {
            _eq: "89b9d27d-dd79-48d9-a251-16e188c0720d"
        }
    };

    UsersMutationResponse|error bEvent = baseClient->deleteUser(updateUserString, 'where);

    if (bEvent is UsersMutationResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail(msg = bEvent.message());
    }
}

@test:Config {}
function  getDragon() {

    string dragonString = string `query ($limit: Int, $offset: Int) {
                                    dragons (limit: $limit, offset: $offset) {
                                        name
                                        active
                                    }
                                }`;
    int 'limit = 1;
    Dragon[]|error bEvent = baseClient->getDragons(dragonString, 'limit);

    if (bEvent is Dragon[]) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail(msg = bEvent.message());
    }
}
