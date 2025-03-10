//
//  InfoView.swift
//  todoey
//
//  Created by Jason Yi on 3/10/25.
//

import SwiftUI

struct InfoView: View {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink, .cyan, .gray]
    
    @Binding var title: String
    @Binding var selectedColor: Color
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.9)
            VStack {
                VStack {
                    Image(systemName: "list.bullet.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.white, selectedColor)
                    TextField("Title", text: $title)
                        .padding()
                        .background(.gray.opacity(0.45))
                        .cornerRadius(10)
                        .bold()
                    
                }
                .padding()
                .background(.gray.opacity(0.3))
                .cornerRadius(10.0)
                .padding(.horizontal, 20)
                .foregroundStyle(selectedColor)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                            )
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                }
                .padding()
                .background(.gray.opacity(0.3))
                .cornerRadius(10.0)
                .padding(.horizontal, 20)
            }
        }

    }
}

#Preview {
    InfoView(title: .constant("Tadoey"), selectedColor: .constant(.blue))
}
