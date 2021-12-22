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
        Form {
          Section("Sigma Grindset") {
            ForEachStore(store.scope(
              state: \.todos,
              action: AppAction.todos
            )) { childStore in
              WithViewStore(childStore) { childViewStore in
                ToDoView(store: childStore)
                  .opacity(!viewStore.showComplete && childViewStore.complete ? 0 : 1)
              }
            }
          }
        }
        .navigationTitle("Sigma Grind")
        .toolbar {
          ToolbarItem(placement: .primaryAction) {
            Menu {
              Button("New") {
                viewStore.send(.addTodo)
              }
              Button(viewStore.showComplete ? "Hide" : "Show") {
                viewStore.send(.toggleShowComplete)
              }
              Button("Clear") {
                viewStore.send(.clearTodo)
              }
            }
          label: {
            Label(
              title: {
                Text("add")
              },
              icon: {
                Image(systemName: "plus")
              }
            )
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
