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
    let isEnableInfiniteScroll = BehaviorRelay<Bool>(value: true)
    let isEndLoadNextPage = BehaviorRelay<Bool>(value: true)
    let isEndUpdate = BehaviorRelay<Bool>(value: true)

    func fetchData() {
        let params: [String: Any] = ["fields": ["nickname", "photo_100", "last_seen", "city"],
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
        let params: [String: Any] = ["fields": ["nickname", "photo_100", "last_seen", "city"],
                                     "count": pageSize,
                                     "offset": friends.value.count]
        let request = VKApi.friends().get(params)
        request?.execute(resultBlock: { response in
            self.isEndLoadNextPage.accept(self.isEndLoadNextPage.value == false)
            let responseModels = self.map(from: response)
            let viewModels = self.friends.value + responseModels
            self.isEnableInfiniteScroll.accept(responseModels.count > 0)
            self.friends.accept(viewModels)
        }, errorBlock: { error in
            print(error ?? "")
        })
    }
    
    func updateData() {
        let params: [String: Any] = ["fields": ["nickname", "photo_100", "last_seen", "city"],
                                     "count": friends.value.count]
        let request = VKApi.friends().get(params)
        request?.execute(resultBlock: { response in
            self.isEndUpdate.accept(self.isEndUpdate.value == false)
            let viewModels = self.map(from: response)
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
            // пришлось кастовать из-за неправильного бриджинга из модели написанного на objc в свифт
            guard
                let name = model.first_name as? String,
                let surname = model.last_name as? String,
                let cityModel = model.city as? VKCity,
                let city = cityModel.title as? String,
                self.friends.value.first(where: { friend -> Bool in
                    return friend.id == model.id.intValue
                }) == nil
            else {
                return nil
            }
            let lastSeen = Date(timeIntervalSince1970: model.last_seen.time.doubleValue)
            let df = DateFormatter()
            df.dateFormat = "HH:mm"
            let lastSeenString = "last seen today at " + df.string(from: lastSeen)
            return FriendViewModel(id: model.id.intValue,
                                   name: "\(name) \(surname)",
                                   imageUrl: model.photo_100,
                                   city: city,
                                   lastSeen: lastSeenString
                   )
        }
        return viewModels
    }
}

struct FriendViewModel {
    let id: Int
    let name: String
    let imageUrl: String
    let city: String
    let lastSeen: String
}
