//
//  HeroDetailViewModel.swift
//  HeroApp
//
//  Created by Aziza Gilash on 01.04.2025.
//

import Foundation

final class HeroDetailViewModel: ObservableObject {
    @Published var hero: HeroEntity?
    @Published var isLoading = true
    @Published var errorMessage: String?

    private let heroId: Int
    private let service: HeroService

    init(heroId: Int, service: HeroService) {
        self.heroId = heroId
        self.service = service
        Task {
            await fetchHeroDetails()
        }
    }

    func fetchHeroDetails() async {
        do {
            let heroDetail = try await service.fetchHeroById(id: heroId)
            await MainActor.run {
                self.hero = heroDetail
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
