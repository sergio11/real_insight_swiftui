//
//  FirestoreRealInsightsRepository.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Firebase

internal class RealInsightsRepositoryImpl: RealInsightsRepository {
    
    let realInsightsDataSource: RealInsightsDataSource
    let userDataSource: UserDataSource
    let storageFilesDataSource: StorageFilesDataSource
    let realInsightMapper: RealInsightMapper
    
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
            throw RealInsightsRepositoryError.realInsightNotFound
        }
    }
        
    func fetchOwnRealInsight(date: String, userId: String) async throws -> RealInsight {
        do {
            let ownRealInsight = try await realInsightsDataSource.fetchOwnRealInsight(date: date, userId: userId)
            let userData = try await userDataSource.getUserById(userId: userId)
            return realInsightMapper.map(RealInsightDataMapper(realInsightDTO: ownRealInsight, userDTO: userData))
        } catch {
            throw RealInsightsRepositoryError.realInsightNotFound
        }
    }
    
    func postRealInsight(date: String, userId: String, backImageUrl: String, frontImageUrl: String) async throws -> RealInsight {
        
    }
}
