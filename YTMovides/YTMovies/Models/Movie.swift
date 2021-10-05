//
//  Movie.swift
//  YTMovides
//
//  Created by Cédric Bahirwe on 05/10/2021.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    let status: Stat
    let statusMessage: String
    let data: MoviesData
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "status_message"
        case data
        case meta = "@meta"
    }
}

// MARK: - MoviesData
struct MoviesData: Codable {
    let movieCount, limit, pageNumber: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movieCount = "movie_count"
        case limit
        case pageNumber = "page_number"
        case movies
    }
}

// MARK: - Movie
struct Movie: Codable, Identifiable, Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let url: String
    let imdbCode, title, titleEnglish, titleLong: String
    let slug: String
    let year: Int
    let rating: Double
    let runtime: Int
    let genres: [String]
    let summary, descriptionFull, synopsis, ytTrailerCode: String
    let language: Language
    let mpaRating: MpaRating
    let backgroundImage, backgroundImageOriginal, smallCoverImage, mediumCoverImage: String
    let largeCoverImage: String
    let state: Stat
    let torrents: [Torrent]
    let dateUploaded: String
    let dateUploadedUnix: Int

    enum CodingKeys: String, CodingKey {
        case id, url
        case imdbCode = "imdb_code"
        case title
        case titleEnglish = "title_english"
        case titleLong = "title_long"
        case slug, year, rating, runtime, genres, summary
        case descriptionFull = "description_full"
        case synopsis
        case ytTrailerCode = "yt_trailer_code"
        case language
        case mpaRating = "mpa_rating"
        case backgroundImage = "background_image"
        case backgroundImageOriginal = "background_image_original"
        case smallCoverImage = "small_cover_image"
        case mediumCoverImage = "medium_cover_image"
        case largeCoverImage = "large_cover_image"
        case state, torrents
        case dateUploaded = "date_uploaded"
        case dateUploadedUnix = "date_uploaded_unix"
    }
}

enum Language: String, Codable {
    case en = "en"
    case es = "es"
}

enum MpaRating: String, Codable {
    case empty = ""
    case r = "R"
}

enum Stat: String, Codable {
    case ok = "ok"
}

// MARK: - Torrent
struct Torrent: Codable {
    let url: String
    let hash: String
    let quality: Quality
    let type: TypeEnum
    let seeds, peers: Int
    let size: String
    let sizeBytes: Int
    let dateUploaded: String
    let dateUploadedUnix: Int

    enum CodingKeys: String, CodingKey {
        case url, hash, quality, type, seeds, peers, size
        case sizeBytes = "size_bytes"
        case dateUploaded = "date_uploaded"
        case dateUploadedUnix = "date_uploaded_unix"
    }
}

enum Quality: String, Codable {
    case the1080P = "1080p"
    case the720P = "720p"
}

enum TypeEnum: String, Codable {
    case web = "web"
}

// MARK: - Meta
struct Meta: Codable {
    let serverTime: Int
    let serverTimezone: String
    let apiVersion: Int
    let executionTime: String

    enum CodingKeys: String, CodingKey {
        case serverTime = "server_time"
        case serverTimezone = "server_timezone"
        case apiVersion = "api_version"
        case executionTime = "execution_time"
    }
}
