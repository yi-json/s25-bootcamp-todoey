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
    
    @State private var title: String = "Todoey"
    @State private var selectedColor: Color = .yellow
    @State private var isShowingSheet: Bool = false

    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button {
                        isShowingSheet = true
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                .foregroundStyle(selectedColor)
                .padding(.horizontal, 20)
                .padding(.top)
                .padding(.bottom, -20)
                .sheet(isPresented: $isShowingSheet) {
                    InfoView(title: $title, selectedColor: $selectedColor)
                }

                List {
                    ForEach($todos) { $todo in
                        TodoRowView(todo: $todo, editingIndex: editingIndex, selectedColor: selectedColor)
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
                .foregroundStyle(selectedColor)
                .padding(.horizontal)
                .padding(.bottom)
                .bold()
                

            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
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

