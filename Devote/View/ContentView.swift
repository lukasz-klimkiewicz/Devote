//
//  ContentView.swift
//  Devote
//
//  Created by Łukasz Klimkiewicz on 17/09/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // MARK: - PROPERTY
    
    @AppStorage("isDarkMode") private  var isDarkMode : Bool = false
    @State var task : String = ""
    @State private var showNewTaskItem: Bool = false

    
    // MARK: - FETCHING DATA
    
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    

    
    
    // MARK: - BODY

    var body: some View {
        
        
        NavigationView {
            
            ZStack {
                
                // MARK: - MAIN VIEW
                
                VStack {
                    
                    
                    // MARK: - HEADER
                    
                    HStack(spacing: 10) {
                        
                        // TITLE
                        
                        Text("Do zrobienia")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        
                        // EDIT BUTTON
                        
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                    
                        
                        // APPERANCE BUTTON
                        
                        Button(action: {
                            
                            isDarkMode.toggle()
                            
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                        
                        // HSTACK
                        
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
            
                    
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("Dodaj zadanie")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4)
                    
                    
                    // MARK: - TASKS
                    
                    List {
                        ForEach(items) { item in
                            
                            ListRowItemView(item: item)
                            
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                    //: LIST
                    
                } //: VSTACK
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                
                .navigationBarTitle("Do zrobienia", displayMode: .large)
                .navigationBarHidden(true)
                
                .background(
                    BackgroundImageView()
                        .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                )
                .background(
                    backgroundGradient.ignoresSafeArea(.all)
                )
                
                // MARK: - LIST ITEM
                
            // MARK: - NEW TASK BUTTON
            
            if showNewTaskItem {
                    
                BlankView(
                    backgroundColor: isDarkMode ? Color.black : Color.gray,
                    backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                    .onTapGesture {
                        withAnimation {
                            showNewTaskItem = false
                        }
                    }
                
                NewTaskItemView(isShowing: $showNewTaskItem)
                    
            }
                
            } //: ZSTACK
            .onAppear(){
                
                UITableView.appearance().backgroundColor = UIColor.clear
                
            }
            
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }



    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
