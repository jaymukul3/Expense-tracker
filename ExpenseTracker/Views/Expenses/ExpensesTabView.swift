//
//  ExpensesTabView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct ExpensesTabView: View {
    
    @Environment(\.managedObjectContext)
        var context: NSManagedObjectContext
    
    @State private var searchText : String = ""
    @State private var SearchBarHeight: CGFloat = 0
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    @State var selectedCategories: Set<Category> = Set()
    @State var isAddFormPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $searchText, keyboardHeight: $SearchBarHeight, placeholder: "Search expenses")
                FilterCategoriesView(selectedCategories: $selectedCategories)
                Divider()
                SelectSortOrderView(sortType: $sortType, sortOrder: $sortOrder)
                Divider()
                LogListView(predicate: ExpenseLog.predicate(with: Array(selectedCategories), searchText: searchText), sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
            }
            .padding(.bottom, SearchBarHeight)
            .sheet(isPresented: $isAddFormPresented) {
                LogFormView(context: self.context)
            }
            .navigationBarItems(trailing: Button(action: addTapped) { Text("Add") })
            .navigationBarTitle("Expense Logs", displayMode: .inline)
        }
    }
    
    func addTapped() {
        isAddFormPresented = true
    }
    
    
    
}

struct ExpensesTabView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesTabView()
    }
}
