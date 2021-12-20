//
//  toDoView.swift
//  toDoList
//
//  Created by Nick Deda on 12/20/21.
//

import SwiftUI
import ComposableArchitecture

struct ToDoView: View {
  let store: Store<TodoState, TodoAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        TextField(
          "Untitled",
          text: viewStore.binding(
            get: \.name,
            send: TodoAction.updateName
          )
        )
        Button("Delete") {
          viewStore.send(.deleteButtonTapped)
        }
      }
    }
  }
}

struct ToDoView_Previews: PreviewProvider {
  static var previews: some View {
    ToDoView(store: TodoState.mockStore)
  }
}
