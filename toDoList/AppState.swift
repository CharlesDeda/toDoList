//
//  toDoState.swift
//  toDoList
//
//  Created by Nick Deda on 12/20/21.
//

import ComposableArchitecture


struct AppState: Equatable {
  var toDos: IdentifiedArrayOf<TodoState> = []
}

enum AppAction: Equatable {
case toDos(id: TodoState.ID, action: TodoAction)
case addToDo
}

struct AppEnvironment {}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
  toDoReducer.forEach(
    state: \.toDos,
    action: /AppAction.toDos(id:action:),
    environment: { _ in .init() }
  ),
  Reducer { state, action, environment in
    switch action {
      
    case let .toDos(id, action: .deleteButtonTapped):
      state.toDos.remove(id: id)
      return .none
      
    case .toDos:
      return .none
      
    case .addToDo:
      state.toDos.append(
        TodoState(
          name: "Untitled",
          complete: false
        ))
      return .none
    }
  }
)

extension AppState {
  static let defaultStore = Store(
    initialState: AppState(toDos: [
      TodoState(
        name: "New To Do",
        complete: false
      )
    ]),
    reducer: appReducer,
    environment: AppEnvironment()
  )
}
