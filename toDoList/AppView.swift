//
//  ContentView.swift
//  toDoList
//
//  Created by Nick Deda on 12/20/21.
//
import Foundation
import SwiftUI
import ComposableArchitecture

struct AppView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        List {
          ForEachStore(store.scope(
            state: \.toDos,
            action: AppAction.toDos
          )) { childStore in
            WithViewStore(childStore) { childViewStore in
                ToDoView(store: childStore)
            }
          }
        }
        .navigationTitle("To Do List")
        .toolbar {
          Button("Add") {
            viewStore.send(.addToDo)
          }
        }
      }
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(store: AppState.defaultStore)
  }
}
