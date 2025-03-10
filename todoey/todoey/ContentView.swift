//
//  ContentView.swift
//  tadoey
//
//  Created by Jason Yi on 3/9/25.
//

import SwiftUI

struct Todo: Identifiable {
    var id = UUID()
    var item: String
    var isDone: Bool
}

struct ContentView: View {
    @State private var todos: [Todo] = [
        Todo(item: "Buy groceries", isDone: false),
        Todo(item: "Walk the dog", isDone: false),
        Todo(item: "Cry in my sleep", isDone: true)
        
    ]
    
    @State private var editingIndex: UUID?
    @FocusState private var isTextFieldFocused: Bool

    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Todoey")
                    .font(.largeTitle)
                    .foregroundStyle(.yellow)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top)
                    .padding(.bottom, -40)

                List {
                    ForEach($todos) { $todo in
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
                            } else {
                                Text(todo.item)
                                    .foregroundStyle(todo.isDone ? .gray : .white)
                            }
                        }
                        .listRowBackground(Color.black)
                    }
                    .onDelete(perform: deleteTask)

                }
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                Button("New Reminder", systemImage: "plus.circle.fill") {
                    addTask()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                .foregroundStyle(.yellow)
                .padding(.horizontal)
                .padding(.bottom)
                .bold()
                

            }
            .background(Color.black.ignoresSafeArea())
        }
    

    }
    
    private func addTask() {
        let newTask = Todo(item: "", isDone: false)
        todos.append(newTask)
        editingIndex = newTask.id
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isTextFieldFocused = true
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
    
        
}

#Preview {
    ContentView()
}

