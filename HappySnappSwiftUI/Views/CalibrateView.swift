//
//  CalibrateView.swift
//  HappySnapp_v2
//
//  Created by CryptoByNight on 04/10/2020.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
    @State var presentAddNewItem = false
    @State var showSettingsScreen = false
    @State var test = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                            TaskCell(taskCellVM: taskCellVM)
                            
                        } //: FOR EACH
                    } //: LAZY V GRID
                    .animation(.default)
                } // :SCROLL
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.showSettingsScreen.toggle()
                                        }) {
                                            Image(systemName: "gear")
                                        }
                )
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .sheet(isPresented: $showSettingsScreen) {
                    AccountView()
                }
                
            } //: ZSTACK
            
        } //: NAVIGATION VIEW
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            //AuthenticationService().signOut()
        }
    }
    
    
}


enum InputError: Error {
    case empty
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var body: some View {
        Button(action: {
            
            self.taskCellVM.task.selected.toggle()
            
        }) {
            ZStack {
                Image(taskCellVM.task.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(25)
                    .opacity(taskCellVM.task.selected ? 0.5 : 1.0)
                    .overlay(
                        Text(taskCellVM.task.name)
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.black, radius: 6)
                            .opacity(taskCellVM.task.selected ? 0 : 1.0)
                            .padding()
                    )
                
                Image("640")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 15)
                    .opacity(taskCellVM.task.selected ? 0.8 : 0)
                    .padding()
                
            } //: ZSTACK
        }
        
    }
}

