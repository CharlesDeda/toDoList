//
//  toDoState.swift
//  toDoList
//
//  Created by Nick Deda on 12/20/21.
//

import ComposableArchitecture
import SwiftUI


struct AppState: Equatable {
  var todos: IdentifiedArrayOf<TodoState> = []
  var showComplete = true
}

enum AppAction: Equatable {
  case todos(id: TodoState.ID, action: TodoAction)
  case addTodo
  case clearTodo
  case toggleShowComplete
}

struct AppEnvironment {}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
  toDoReducer.forEach(
    state: \.todos,
    action: /AppAction.todos(id:action:),
    environment: { _ in .init() }
  ),
  Reducer { state, action, environment in
    switch action {
      
    case .toggleShowComplete:
      state.showComplete.toggle()
//      state.toDos.toggle
      return .none
      
    case .clearTodo:
      state.todos.removeAll()
      return .none
      
    case let .todos(id, action: .deleteButtonTapped):
      state.todos.remove(id: id)
      return .none
      
    case .todos:
      return .none
      
    case .addTodo:
      state.todos.append(
        TodoState(
          name: "Untitled",
          complete: false
        ))
      return .none
    }
  }
) .debug()

extension AppState {
  static let defaultStore = Store(
    initialState: AppState(todos: [
      TodoState(
        name: "New To Do",
        complete: false
      )
    ]),
    reducer: appReducer,
    environment: AppEnvironment()
  )
}
