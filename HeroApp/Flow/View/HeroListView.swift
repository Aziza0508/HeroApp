//
//  HeroListView.swift
//  HeroApp
//
//  Created by Aziza Gilash on 01.04.2025.
//

import SwiftUI

struct HeroListView: View {
    @StateObject var viewModel: HeroListViewModel

    var body: some View {
        VStack {
            Text("Hero List")
                .font(.largeTitle)
                .padding(.top, 16)

            Divider()
                .padding(.bottom, 8)

            listOfHeroes()
            Spacer()
        }
        .task {
            await viewModel.fetchHeroes()
        }
    }
}

extension HeroListView {
    @ViewBuilder
    private func listOfHeroes() -> some View {
        ScrollView {
            LazyVStack(alignment: .leading) {  // Using LazyVStack for performance
                ForEach(viewModel.heroes) { model in
                    heroCard(model: model)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            viewModel.routeToDetail(by: model.id)
                        }
                }
            }
        }
    }

    @ViewBuilder
    private func heroCard(model: HeroListModel) -> some View {
        HStack {
            AsyncImage(url: model.heroImage) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .padding(.trailing, 16)
                default:
                    Color.gray
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .padding(.trailing, 16)
                }
            }

            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                Text(model.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}
