//
//  DefaultPlatformInfoApi.swift
//  Pods
//
//  Created by MJ on 12.07.2025.
//

// iOS implementation for platform interface
class DefaultPlatformInfoApi: PlatformInfoApi {

    // Flutter interface
    private let api: VersionFlutterApi

    init(api: VersionFlutterApi) {
        self.api = api
    }

    // Get platform information
    func getPlatformInfo(completion: @escaping (Result<PlatformInfo, Error>) -> Void) {
        // Call flutter api to get app version
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
