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
        ScrollView {
          ForEachStore(store.scope(
            state: \.filteredTodos,
            action: AppAction.todos
          )) { childStore in
            WithViewStore(childStore) { childViewStore in
              ToDoView(store: childStore)
            }
          }
        }
        .navigationTitle("ToDoList")
        .toolbar {
          ToolbarItem(placement: .primaryAction) {
            Menu {
              Button(action: { viewStore.send(.addTodo) }) {
                Label("Add", systemImage: "plus")
              }
              Button(action: { viewStore.send(.toggleShowComplete) }) {
                Label(viewStore.showComplete ? "Hide" : "Show", systemImage:viewStore.showComplete ? "eye.slash" : "eye")
              }
              Button(action: { viewStore.send(.clearTodo) }) {
                Label("Clear", systemImage: "trash")
              }
            }
          label: {
            Label("Add", systemImage: "ellipsis.circle")
          }
          }
        }
      }
      .preferredColorScheme(.dark)
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(store: AppState.defaultStore)
  }
}
