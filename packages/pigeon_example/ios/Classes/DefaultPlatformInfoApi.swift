//
//  DefaultPlatformInfoApi.swift
//  Pods
//
//  Created by MJ on 12.07.2025.
//

class DefaultPlatformInfoApi: PlatformInfoApi {
    
    private let api: VersionFlutterApi
    
    init(api: VersionFlutterApi) {
        self.api = api
    }
    
    func getPlatformInfo(completion: @escaping (Result<PlatformInfo, Error>) -> Void) {
        api.getAppVersion { result in
            switch result {
            case .success(let appVersion):
                completion(
                    .success(
                        PlatformInfo(
                            name: "iOS",
                            version: UIDevice.current.systemVersion,
                            appVersion: appVersion
                        )
                    )
                )
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
