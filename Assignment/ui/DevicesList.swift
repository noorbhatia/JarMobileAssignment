//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DevicesList: View {
    @Binding var searchText:String
    let devices: [DeviceData]
    let onSelect: (DeviceData) -> Void // Callback for item selection
    var body: some View {
        List( searchText.isEmpty ? devices: devices.filter({ $0.name.lowercased().contains(searchText.lowercased()) })) { device in
            Button {
                onSelect(device)
            } label: {
                VStack(alignment: .leading) {
                    AssignmentText(text: device.name)
                }
            }
        }
        .searchable(text: $searchText)
    }
}
