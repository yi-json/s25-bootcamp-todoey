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
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            Button {
                todo.isDone.toggle()
            } label: {
                Image(systemName: todo.isDone ? "circle.fill" : "circle")
                    .foregroundStyle(.yellow)

            }
            if editingIndex == todo.id {
                TextField("", text: $todo.item)
                    .foregroundStyle(.white)
                    .focused($isTextFieldFocused)
                    .onAppear {
                        isTextFieldFocused = true
                    }
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
