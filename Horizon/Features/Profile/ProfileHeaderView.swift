//
//  ProfileHeaderView.swift
//  Horizon
//
//  Created by Akshat Sharma on 12/10/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let actorName: String
    
    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()
            HStack(alignment: .bottom) {
                Text(actorName)
                    .padding()
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
        }
    }
}
