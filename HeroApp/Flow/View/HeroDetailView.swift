//
//  HeroDetailView.swift
//  HeroApp
//
//  Created by Aziza Gilash on 01.04.2025.
//

import SwiftUI

struct HeroDetailView: View {
    @StateObject var viewModel: HeroDetailViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let hero = viewModel.hero {
                VStack {
                    AsyncImage(url: hero.heroImageUrl) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 200, height: 200)
                                .cornerRadius(20)
                        default:
                            Color.gray
                                .frame(width: 200, height: 200)
                                .cornerRadius(20)
                        }
                    }
                    Text(hero.name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 16)
                    Text("Race: \(hero.appearance.race ?? "Unknown")")
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                    Spacer()
                }
            } else {
                Text(viewModel.errorMessage ?? "Unknown error")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .navigationTitle("Hero Details")
    }
}
