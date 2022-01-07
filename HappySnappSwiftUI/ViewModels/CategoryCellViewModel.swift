//
//  CategoryCellViewModel.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 04/10/2020.
//

import Foundation
import Combine
import Resolver

class TaskCellViewModel: ObservableObject, Identifiable  {
    @Injected var taskRepository: TaskRepository
    
    @Published var task: Task
    
    var id: String = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        $task
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $task
            .dropFirst()
            //.debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { [weak self] task in
                self?.taskRepository.updateTask(task)
            }
            .store(in: &cancellables)
    }
    
}

