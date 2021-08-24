type ObjectParameters record {|
    string query;
    json? variables;
|};

public type InsertUserVariables record {|
    UserInsertInput[] objects;
    UsersOnConflict? on_conflict = ();
|};

public type UserInsertInput record {
    string id?;
    string name?;
    string rocket?;
    string twitter?;
    //timestamp: timestamptz is a scalar
};

public type UsersOnConflict record {
    UsersConstraint constraint;
    UsersUpdateInput update_columns;
};

public type UsersConstraint record {
    string users_pkey?;
};

public type UsersUpdateInput record {
    string id?;
    string name?;
    string rocket?;
    string twitter?;
    //timestamp: timestamptz
};

// public type UsersMutationResponse record {
//     int affected_rows;
//     Users returning?;
// }; 

// public type Users record {
//     string id;
//     string name?;
//     string rocket?;
//     string twitter?;
//     //timestamp: timestamptz!
// };

public type GetDragonVariables record {
    int? 'limit = ();
    int? offset = ();
};

// public type Dragon  record {
//     boolean active?;
//     int crew_capacity?;
//     string description?;
//     //Distance diameter?;
//     int dry_mass_kg?;
//     int dry_mass_lb?;
//     string first_flight?;
//     //DragonHeatShield heat_shield?;
//     //Distance height_w_trunk?;
//     string id?;
//     //Mass launch_payload_mass?;
//     //Vol umelaunch_payload_vol?;
//     string name?;
//     int orbit_duration_yr?;
//     //DragonPressurizedCapsule pressurized_capsule?;
//     //Mass return_payload_mass?;
//     //Volume return_payload_vol?;
//     float sidewall_angle_deg?;
//     //DragonThrust[] thrusters?;
//     //DragonTrunk trunk?;
//     string 'type?;
//     string wikipedia?;
// };
