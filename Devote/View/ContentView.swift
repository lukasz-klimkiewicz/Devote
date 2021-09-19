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
                    
                    // MARK: - NEW TASK BUTTON
                    
                    
                    // MARK: - TASKS
                    
                    List {
                        ForEach(items) { item in
                            
                            
                            VStack(alignment: .leading) {
                                Text(item.task ?? "")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text(item.timestamp!, formatter: itemFormatter)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            
                            
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                    //: LIST
                    
                } //: VSTACK
                .navigationBarTitle("Do zrobienia", displayMode: .large)
                .toolbar {
                    
                    #if os(iOS)
                    ToolbarItem(placement: .navigationBarTrailing){
                        EditButton()
                    }
                    #endif
                    

            } //: TOOLBAR
                
                .background(
                    BackgroundImageView()
                )
                .background(
                    backgroundGradient.ignoresSafeArea(.all)
                )
                
                // MARK: - LIST ITEM
                
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
