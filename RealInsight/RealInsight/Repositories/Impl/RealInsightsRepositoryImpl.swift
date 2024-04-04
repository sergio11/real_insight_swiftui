//
//  FirestoreRealInsightsRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Firebase

/// An implementation of the `RealInsightsRepository` protocol responsible for managing real insights data.
internal class RealInsightsRepositoryImpl: RealInsightsRepository {
    
    private let realInsightsDataSource: RealInsightsDataSource
    private let userDataSource: UserDataSource
    private let storageFilesDataSource: StorageFilesDataSource
    private let realInsightMapper: RealInsightMapper
    
    /// Initializes a new instance of `RealInsightsRepositoryImpl`.
        /// - Parameters:
        ///   - realInsightsDataSource: The data source responsible for real insights operations.
        ///   - userDataSource: The data source responsible for user operations.
        ///   - storageFilesDataSource: The data source responsible for storage file operations.
        ///   - realInsightMapper: The mapper responsible for mapping real insight data.
    init(realInsightsDataSource: RealInsightsDataSource, userDataSource: UserDataSource, storageFilesDataSource: StorageFilesDataSource, realInsightMapper: RealInsightMapper) {
        self.realInsightsDataSource = realInsightsDataSource
        self.userDataSource = userDataSource
        self.storageFilesDataSource = storageFilesDataSource
        self.realInsightMapper = realInsightMapper
    }

    /// Fetches all real insights for the specified date and user ID asynchronously.
        /// - Parameters:
        ///   - date: The date for which to fetch real insights.
        ///   - userId: The ID of the user for which to fetch real insights.
        /// - Returns: An array of `RealInsight` representing the fetched real insights.
        /// - Throws: An error if the operation fails, including `realInsightNotFound` if no real insights are found.
    func fetchAllRealInsights(date: Date, userId: String) async throws -> [RealInsight] {
        do {
            let userData = try await userDataSource.getUserById(userId: userId)
            let userIds = [userId] + userData.friends
            let realInsightsData = try await realInsightsDataSource.fetchAllRealInsights(forDate: date, userIds: userIds)
            var realInsights: [RealInsight] = []
            for realInsightData in realInsightsData {
                let user = try await userDataSource.getUserById(userId: realInsightData.userId)
                let mappedRealInsight = realInsightMapper.map(RealInsightDataMapper(realInsightDTO: realInsightData, userDTO: user))
                realInsights.append(mappedRealInsight)
            }
            return realInsights
        } catch {
            print(error.localizedDescription)
            throw RealInsightsRepositoryError.realInsightNotFound
        }
    }
        
    /// Fetches own real insights for the specified user and last number of days asynchronously.
        /// - Parameters:
        ///   - days: The number of past days from which to fetch real insights.
        ///   - userId: The ID of the user for which to fetch real insights.
        /// - Returns: An array of `RealInsight` representing the fetched real insights.
        /// - Throws: An error if the operation fails, including `realInsightNotFound` if no real insights are found.
    func fetchOwnRealInsight(lastDays days: Int, userId: String) async throws -> [RealInsight] {
        do {
            let ownRealInsightList = try await realInsightsDataSource.fetchOwnRealInsight(lastDays: days, userId: userId)
            let userData = try await userDataSource.getUserById(userId: userId)
            let realInsights = ownRealInsightList.map { realInsightDTO in
                let mappedRealInsight = realInsightMapper.map(RealInsightDataMapper(realInsightDTO: realInsightDTO, userDTO: userData))
                return mappedRealInsight
            }
            return realInsights
        } catch {
            print(error.localizedDescription)
            throw RealInsightsRepositoryError.realInsightNotFound
        }
    }
    
    /// Posts a new real insight asynchronously.
        /// - Parameters:
        ///   - userId: The ID of the user posting the real insight.
        ///   - backImageData: The data of the image taken from the back camera.
        ///   - frontImageData: The data of the image taken from the front camera.
        /// - Returns: A `RealInsight` object representing the posted real insight.
        /// - Throws: An error if the operation fails, including `postFailed` if posting the real insight fails.
    func postRealInsight(userId: String, backImageData: Data, frontImageData: Data) async throws -> RealInsight {
        do {
            let backImageUrl = try await storageFilesDataSource.uploadImage(imageData: backImageData, type: .post)
            let frontImageUrl = try await storageFilesDataSource.uploadImage(imageData: frontImageData, type: .post)
            let ownRealInsight = try await realInsightsDataSource.postRealInsight(userId: userId, backImageUrl: backImageUrl, frontImageUrl: frontImageUrl)
            let userData = try await userDataSource.getUserById(userId: userId)
            return realInsightMapper.map(RealInsightDataMapper(realInsightDTO: ownRealInsight, userDTO: userData))
        } catch {
            print(error.localizedDescription)
            throw RealInsightsRepositoryError.postFailed
        }
    }
}
