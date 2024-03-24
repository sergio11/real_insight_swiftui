//
//  Container.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Factory


extension Container {
    
    var userMapper: Factory<UserMapper> {
        self { UserMapper() }.singleton
    }
    
    var realInsightMapper: Factory<RealInsightMapper> {
        self { RealInsightMapper(userMapper: self.userMapper()) }.singleton
    }
}

extension Container {
    
    var authenticationDataSource: Factory<AuthenticationDataSource> {
        self { FirestoreAuthenticationDataSource() }.singleton
    }
    
    var authenticationRepository: Factory<AuthenticationRepository> {
        self { AuthenticationRepositoryImpl(authenticationDataSource: self.authenticationDataSource()) }.singleton
    }
    
    var signOutUseCase: Factory<SignOutUseCase> {
        self { SignOutUseCase(repository: self.authenticationRepository()) }
    }
    
    var verifyOtpUseCase: Factory<VerifyOtpUseCase> {
        self { VerifyOtpUseCase(repository: self.authenticationRepository()) }
    }
    
    var sendOtpUseCase: Factory<SendOtpUseCase> {
        self { SendOtpUseCase(repository: self.authenticationRepository()) }
    }
    
    var verifySessionUseCase: Factory<VerifySessionUseCase> {
        self { VerifySessionUseCase(repository: self.authenticationRepository()) }
    }
}

extension Container {
    
    var userDataSource: Factory<UserDataSource> {
        self { FirestoreUserDataSource() }.singleton
    }
    
    var userProfileRepository: Factory<UserProfileRepository> {
        self { FirestoreUserProfileRepository() }.singleton
    }
    
    var saveUserDataUseCase: Factory<SaveUserDataUseCase> {
        self { SaveUserDataUseCase(repository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
}

extension Container {
    
    var storageDataSource: Factory<StorageFilesDataSource> {
        self { FirestoreStorageFilesDataSource() }.singleton
    }
}

extension Container {
    
    var realInsightsDataSource: Factory<RealInsightsDataSource> {
        self { FirestoreRealInsightsDataSource() }.singleton
    }
    
    var realInsightsRepository: Factory<RealInsightsRepository> {
        self { RealInsightsRepositoryImpl(realInsightsDataSource: self.realInsightsDataSource(), userDataSource: self.userDataSource(), storageFilesDataSource: self.storageDataSource(), realInsightMapper: self.realInsightMapper()) }.singleton
    }
    
    var fetchRealInsightsUseCase: Factory<FetchRealInsightsUseCase> {
        self { FetchRealInsightsUseCase(repository: self.realInsightsRepository(), authRepository: self.authenticationRepository()) }
    }
    
    var postRealInsightUseCase: Factory<PostRealInsightUseCase> {
        self { PostRealInsightUseCase(repository: self.realInsightsRepository(), authRepository: self.authenticationRepository()) }
    }
}

