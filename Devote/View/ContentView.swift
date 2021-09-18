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
    
    // MARK: - FETCHING DATA
    
    
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    
    // MARK: - FUNCTION
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

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
    
    
    // MARK: - BODY

    var body: some View {
        
        
        NavigationView {
            
            VStack {
                
                
                VStack(spacing: 16) {
                    
                    TextField("New task", text: $task)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                    
                }.padding()
                
                
                
                List {
                    ForEach(items) { item in
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    }
                    .onDelete(perform: deleteItems)
                }
                //: LIST
                
            } //: VSTACK
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarLeading){
                    
                    EditButton()
                    
                }
                #endif
                
                ToolbarItem(placement: .navigationBarTrailing){
                    
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                    
                }
                

        } //: TOOLBAR
        } //: NAVIGATION
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
