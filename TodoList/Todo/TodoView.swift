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
        Button(action: {
          viewStore.send(.toggleComplete)
        }) {
          Image.init(systemName: viewStore.complete ? "checkmark" : "circle")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
        }
        TextField(
          "Untitled",
          text: viewStore.binding(
            get: \.name,
            send: TodoAction.updateName
          )
        )
          .disabled(viewStore.complete)
          .opacity(viewStore.complete ? 0.5 : 1)
        Button {
          viewStore.send(.deleteButtonTapped)
        } label: {
          Image(systemName: "trash")
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
