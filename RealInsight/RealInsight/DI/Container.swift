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
    
    var storageDataSource: Factory<StorageFilesDataSource> {
        self { FirestoreStorageFilesDataSourceImpl() }.singleton
    }
}


extension Container {
    
    var authenticationDataSource: Factory<AuthenticationDataSource> {
        self { FirebaseAuthenticationDataSourceImpl() }.singleton
    }
    
    var authenticationRepository: Factory<AuthenticationRepository> {
        self { AuthenticationRepositoryImpl(authenticationDataSource: self.authenticationDataSource()) }.singleton
    }
    
    var signOutUseCase: Factory<SignOutUseCase> {
        self { SignOutUseCase(repository: self.authenticationRepository()) }
    }
    
    var sendOtpUseCase: Factory<SendOtpUseCase> {
        self { SendOtpUseCase(repository: self.authenticationRepository()) }
    }
    
    var verifySessionUseCase: Factory<VerifySessionUseCase> {
        self { VerifySessionUseCase(authRepository: self.authenticationRepository(), userProfileRepository: self.userProfileRepository()) }
    }
    
    var signInUseCase: Factory<SignInUseCase> {
        self { SignInUseCase(authRepository: self.authenticationRepository(), userProfileRepository: self.userProfileRepository()) }
    }
    
    var signUpUseCase: Factory<SignUpUseCase> {
        self { SignUpUseCase(authRepository: self.authenticationRepository(), userRepository: self.userProfileRepository()) }
    }
}

extension Container {
    
    var userDataSource: Factory<UserDataSource> {
        self { FirestoreUserDataSourceImpl() }.singleton
    }
    
    var userProfileRepository: Factory<UserProfileRepository> {
        self { UserProfileRepositoryImpl(userDataSource: self.userDataSource(), storageFilesDataSource: self.storageDataSource(), userMapper: self.userMapper()) }.singleton
    }
    
    var updateUserUseCase: Factory<UpdateUserUseCase> {
        self { UpdateUserUseCase(userRepository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
    
    var getCurrentUserUseCase: Factory<GetCurrentUserUseCase> {
        self { GetCurrentUserUseCase(authRepository: self.authenticationRepository(), userRepository: self.userProfileRepository())}
    }
    
    var verifyUsernameAvailabilityUseCase: Factory<VerifyUsernameAvailabilityUseCase> {
        self { VerifyUsernameAvailabilityUseCase(userProfileRepository: self.userProfileRepository()) }
    }
    
    var getSuggestionsUseCase: Factory<GetSuggestionsUseCase> {
        self { GetSuggestionsUseCase(userRepository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
}


extension Container {
    
    var realInsightsDataSource: Factory<RealInsightsDataSource> {
        self { FirestoreRealInsightsDataSourceImpl() }.singleton
    }
    
    var realInsightsRepository: Factory<RealInsightsRepository> {
        self { RealInsightsRepositoryImpl(realInsightsDataSource: self.realInsightsDataSource(), userDataSource: self.userDataSource(), storageFilesDataSource: self.storageDataSource(), realInsightMapper: self.realInsightMapper()) }.singleton
    }
    
    var fetchRealInsightsUseCase: Factory<FetchRealInsightsUseCase> {
        self { FetchRealInsightsUseCase(repository: self.realInsightsRepository(), authRepository: self.authenticationRepository()) }
    }
    
    var postRealInsightUseCase: Factory<PostRealInsightUseCase> {
        self { PostRealInsightUseCase(realInsightsRepository: self.realInsightsRepository(), authRepository: self.authenticationRepository()) }
    }
    
    var fetchOwnRealInsightsUseCase: Factory<FetchOwnRealInsightsUseCase> {
        self { FetchOwnRealInsightsUseCase(realInsightsRepository: self.realInsightsRepository(), authRepository: self.authenticationRepository()) }
    }
}

extension Container {
    
    var eventBus: Factory<EventBus<AppEvent>> {
        self { EventBus<AppEvent>() }.singleton
    }
}
