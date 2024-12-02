//
//  ProfileView.swift
//  Horizon
//
//  Created by Akshat Sharma on 11/25/24.
//

import SwiftUI
import ATProtoKit

struct ProfileView: View {
    @State var viewModel: ViewModel
    @Environment(BlueskyAgent.self) private var agent

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // read this value from the data source
                if let profileDef = viewModel.profileDef {
                    ProfileHeaderView(profileDef: profileDef)
                } else {
                    ProgressView()
                }
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Label("Sign Out", systemImage: "person.crop.circle.badge.xmark")
                    }
                }
            }
            .task {
                await viewModel.fetchProfileDefIfNeeded(atProtoClient: agent.atProtoClient)
            }
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileView.ViewModel.mock)
        .environment(MockBlueskyAgent() as BlueskyAgent)
}
