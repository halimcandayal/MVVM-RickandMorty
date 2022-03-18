//
//  RicknMortyViewModel.swift
//  MVVM RickandMorty
//
//  Created by Halimcan Dayal on 18.03.2022.
//

import Foundation

protocol IRicknMortyViewModel {
    func fetchItems()
    func changeLoading()

    var ricknMortyCharacters: [Result] { get set }
    var ricknMortyService: IRicknMortyService { get }
    
    var ricknMortyOutPut: RicknMortyOutPut? { get }
    
    func setDelegate(output: RicknMortyOutPut)
     
}

final class RicknMortyViewModel: IRicknMortyViewModel {
    var ricknMortyOutPut: RicknMortyOutPut?
    
    var ricknMortyOutput: RicknMortyOutPut?
    
    func setDelegate(output: RicknMortyOutPut) {
        ricknMortyOutput = output
    }
    
    
    var ricknMortyCharacters: [Result] = []
    private var isLoading = false;
    let ricknMortyService: IRicknMortyService
    
    init() {
        ricknMortyService = RickMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        ricknMortyService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.ricknMortyCharacters = response ??  []
            self?.ricknMortyOutput?.saveDatas(values: self?.ricknMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        ricknMortyOutput?.changeLoading(isLoad: isLoading)
    }
    
    
    
    
}



