//
//  toDoListApp.swift
//  toDoList
//
//  Created by Nick Deda on 12/20/21.
//

import SwiftUI
import ComposableArchitecture

@main
struct toDoListApp: App {
  var body: some Scene {
    WindowGroup {
      AppView(store: AppState.defaultStore)
    }
  }
}
/*
Create an iOS app which presents a list of Todos and a menu in the top right.

 The menu should contain options for:
 - creating a new todo
 - removing all of the todos
 - hiding just the completed todos

Each todo item should have a button for toggling wether or not it is complete, and the ability to change its description
*/
