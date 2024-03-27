//
//  FirestoreRealInsightsRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Firebase

internal class RealInsightsRepositoryImpl: RealInsightsRepository {
    
    private let realInsightsDataSource: RealInsightsDataSource
    private let userDataSource: UserDataSource
    private let storageFilesDataSource: StorageFilesDataSource
    private let realInsightMapper: RealInsightMapper
    
    init(realInsightsDataSource: RealInsightsDataSource, userDataSource: UserDataSource, storageFilesDataSource: StorageFilesDataSource, realInsightMapper: RealInsightMapper) {
        self.realInsightsDataSource = realInsightsDataSource
        self.userDataSource = userDataSource
        self.storageFilesDataSource = storageFilesDataSource
        self.realInsightMapper = realInsightMapper
    }

    func fetchAllRealInsights(date: String) async throws -> [RealInsight] {
        do {
            let realInsightsData = try await realInsightsDataSource.fetchAllRealInsights(date: date)
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
        
    func fetchOwnRealInsight(date: String, userId: String) async throws -> RealInsight {
        do {
            let ownRealInsight = try await realInsightsDataSource.fetchOwnRealInsight(date: date, userId: userId)
            let userData = try await userDataSource.getUserById(userId: userId)
            return realInsightMapper.map(RealInsightDataMapper(realInsightDTO: ownRealInsight, userDTO: userData))
        } catch {
            print(error.localizedDescription)
            throw RealInsightsRepositoryError.realInsightNotFound
        }
    }
    
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
