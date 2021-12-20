//
//  toDoState.swift
//  toDoList
//
//  Created by Nick Deda on 12/20/21.
//

import ComposableArchitecture
import SwiftUI

struct TodoState: Identifiable, Equatable {
  let id = UUID()
  var name: String
  var complete: Bool = false
}

enum TodoAction: Equatable {
  case updateName(String)
  case deleteButtonTapped
}

struct TodoEnvironment {
}

let toDoReducer = Reducer<
  TodoState,
  TodoAction,
  TodoEnvironment
> { state, action, environment in
  
  switch action {
    
  case let .updateName(string):
    state.name = string
    return .none
    
  case .deleteButtonTapped:
    return .none
    
  }
}

extension TodoState {
  static let mockStore = Store (
    initialState: TodoState(
      name: "Doctors Appointment",
      complete: Bool(true
                    )),
    reducer: toDoReducer,
    environment: TodoEnvironment()
  )
}
