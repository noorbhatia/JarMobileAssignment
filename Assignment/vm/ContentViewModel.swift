//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation
import SwiftUI
import RealmSwift

class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData]? = []
    
    @ObservedResults(DeviceObject.self) var deviceList
    
    private var token: NotificationToken?

        init() {
            setupObserver()
        }

        deinit {
            token?.invalidate()
        }
    private func setupObserver() {
           do {
               let realm = try Realm()
               let results = realm.objects(DeviceObject.self)

                token = results.observe({ [weak self] changes in
                    self?.data = results.map(DeviceData.init)
               })
           } catch let error {
               print(error.localizedDescription)
           }
       }

    func fetchAPI() {
        apiService.fetchDeviceDetails(completion: { item in
            DispatchQueue.main.async {
                self.data = item
            }
            self.updateOfflineList(item)
            
        })
    }
    
    func updateOfflineList(_ deviceData:[DeviceData]){
        for device in deviceData {
            let dev = DeviceObject()
            dev.name = device.name
            $deviceList.append(dev)

        }
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
