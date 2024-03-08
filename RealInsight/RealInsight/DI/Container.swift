//
//  Container.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 8/3/24.
//

import Foundation
import Factory

extension Container {
    
    var authenticationRepository: Factory<AuthenticationRepository> {
        self { FirestoreAuthenticationRepository() }.singleton
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
    
    var realInsightsRepository: Factory<RealInsightsRepository> {
        self { FirestoreRealInsightsRepository() }.singleton
    }
    
    var fetchRealInsightsUseCase: Factory<FetchRealInsightsUseCase> {
        self { FetchRealInsightsUseCase(repository: self.realInsightsRepository(), authRepository: self.authenticationRepository()) }
    }
}


extension Container {
    
    var userProfileRepository: Factory<UserProfileRepository> {
        self { FirestoreUserProfileRepository() }.singleton
    }
    
    var saveUserDataUseCase: Factory<SaveUserDataUseCase> {
        self { SaveUserDataUseCase(repository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
}
