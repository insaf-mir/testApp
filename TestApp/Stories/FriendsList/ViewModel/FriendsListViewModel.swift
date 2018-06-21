//
//  FriendsListViewModel.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 21.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import RxCocoa
import RxSwift
import VK_ios_sdk

class FriendsListViewModel {
    let pageSize = 50
    let disposeBag = DisposeBag()
    let friends = BehaviorRelay<[FriendViewModel]>(value: [])
    
    func fetchData() {
        let params: [String: Any] = ["fields": ["nickname", "photo_100"],
                                     "count": pageSize]
        let request = VKApi.friends().get(params)
        request?.execute(resultBlock: { response in
            let viewModels = self.map(from: response)
            self.friends.accept(viewModels)
        }, errorBlock: { error in
            print(error ?? "")
        })
    }
    
    func fetchNextPage() {
        let params: [String: Any] = ["fields": ["nickname", "photo_100"],
                                     "count": pageSize,
                                     "offset": friends.value.count]
        let request = VKApi.friends().get(params)
        request?.execute(resultBlock: { response in
            let viewModels = self.friends.value + self.map(from: response)
            self.friends.accept(viewModels)
        }, errorBlock: { error in
            print(error ?? "")
        })
    }
    
    private func map(from response: VKResponse<VKApiObject>?) -> [FriendViewModel] {
        guard
            let friendsArray = response?.parsedModel as? VKUsersArray,
            let friends = friendsArray.items as? [VKUser]
        else {
            return []
        }
        let viewModels: [FriendViewModel] = friends.compactMap { model -> FriendViewModel? in
            guard
                let name = model.first_name as? String,
                let surname = model.last_name as? String
                else {
                    return nil
            }
            return FriendViewModel(id: model.id.intValue,
                                   name: "\(name) \(surname)",
                imageUrl: model.photo_100)
        }
        return viewModels
    }
}

struct FriendViewModel {
    let id: Int
    let name: String
    let imageUrl: String
}
