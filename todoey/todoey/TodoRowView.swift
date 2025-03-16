//
//  TodoRowView.swift
//  todoey
//
//  Created by Jason Yi on 3/10/25.
//

import SwiftUI

struct TodoRowView: View {
    @Binding var todo: Todo
    var editingIndex: UUID?
    var selectedColor: Color
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            Button {
                todo.isDone.toggle()
            } label: {
                Image(systemName: todo.isDone ? "circle.fill" : "circle")
                    .foregroundStyle(selectedColor)

            }
            if editingIndex == todo.id {
                TextField("", text: $todo.item)
                    .foregroundStyle(todo.isDone ? .gray : .white)
                    .focused($isTextFieldFocused)
            } else {
                Text(todo.item)
                    .foregroundStyle(todo.isDone ? .gray : .white)
            }
        }
        .listRowBackground(Color.black)
    }
}

//#Preview {
//    TodoRowView(isDone: false, id: UUID())
//}
