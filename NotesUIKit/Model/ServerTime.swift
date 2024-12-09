//
//  ServerTime.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

struct ServerTime: Codable {
    let abbreviation, clientIP, datetime: String?
    let dayOfWeek, dayOfYear: Int?
    let dst: Bool?
    let dstFrom: String?
    let dstOffset: Int?
    let dstUntil: String?
    let rawOffset: Int?
    let timezone: String?
    let unixtime: Int?
    let utcDatetime, utcOffset: String?
    let weekNumber: Int?

    enum CodingKeys: String, CodingKey {
        case abbreviation
        case clientIP = "client_ip"
        case datetime
        case dayOfWeek = "day_of_week"
        case dayOfYear = "day_of_year"
        case dst
        case dstFrom = "dst_from"
        case dstOffset = "dst_offset"
        case dstUntil = "dst_until"
        case rawOffset = "raw_offset"
        case timezone, unixtime
        case utcDatetime = "utc_datetime"
        case utcOffset = "utc_offset"
        case weekNumber = "week_number"
    }
}
