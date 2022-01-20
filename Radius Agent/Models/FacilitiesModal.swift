//
//  FacilitiesModal.swift
//  Radius Agent
//
//  Created by Karthi CK on 19/01/22.
//

import Foundation

// MARK : - Facilities
struct FacilitiesModal: Codable {
    var facilities: [Facility]? = nil
    var exclusions: [[Exclusion]]? = nil
}

// MARK : - Facility
struct Facility: Codable {
    var facilityID: String? = nil
    var name: String? = nil
    var options: [Option]? = nil

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case name, options
    }
}

// MARK : - Exclusion
struct Exclusion: Codable {
    var facilityID: String? = nil
    var optionsID: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case optionsID = "options_id"
    }
}

// MARK : - Option
struct Option: Codable {
    let name, icon, id: String?
}
