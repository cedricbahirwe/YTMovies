//
//  YTSMovie.swift
//  PreMovie (iOS)
//
//  Created by Cédric Bahirwe on 09/10/2021.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Decodable {
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
struct MoviesData: Decodable {
    let movieCount, limit, pageNumber: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movieCount = "movie_count"
        case pageNumber = "page_number"
        case limit
        case movies
    }
}

// MARK: - Movie
struct Movie: Decodable, Identifiable, Equatable {
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
    let summary: String
    let genres: [String]?
    
    let descriptionFull, synopsis, ytTrailerCode: String
    let state: Stat
    let language: String
    let mpaRating: MpaRating
    
    let backgroundImage, backgroundImageOriginal, smallCoverImage, mediumCoverImage: String
    let largeCoverImage: String
    
    let torrents: [Torrent]
    let dateUploaded: String
    let dateUploadedUnix: Int

    enum CodingKeys: String, CodingKey {
        case id, url
        case imdbCode = "imdb_code"
        case title
        case titleEnglish = "title_english"
        case titleLong = "title_long"
        
        case slug, year, rating, runtime, summary, genres
        
        case descriptionFull = "description_full"
        case synopsis
        case ytTrailerCode = "yt_trailer_code"
        case language
        case mpaRating = "mpa_rating"
        case state
        
        case backgroundImage = "background_image"
        case backgroundImageOriginal = "background_image_original"
        case smallCoverImage = "small_cover_image"
        case mediumCoverImage = "medium_cover_image"
        case largeCoverImage = "large_cover_image"
        
        case torrents
        case dateUploaded = "date_uploaded"
        case dateUploadedUnix = "date_uploaded_unix"
    }
}

enum MpaRating: String, Decodable {
    case empty = ""
    case r = "R"
}

enum Stat: String, Decodable {
    case ok = "ok"
}

// MARK: - Torrent
struct Torrent: Decodable {
    let url: String
    let hash: String
    let quality: Quality
    let type: String
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

// MARK: - Quality
enum Quality: String, Decodable {
    case the1080P = "1080p"
    case the720P = "720p"
}

// MARK: - Meta
struct Meta: Decodable {
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
