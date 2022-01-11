//
//  Search.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/11.
//

import SwiftUI

struct Search: View {
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            Group {
                VStack{
                    Spacer().frame(height:30)
                    SearchBarView(searchText: $searchText).padding([.leading, .trailing], 12)
                    Spacer()
                }
            }
            .navigationBarTitle("搜索")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct SearchBarView : View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            ZStack(alignment: .leading){
                Rectangle().foregroundColor(.black.opacity(0.15)).cornerRadius(10).frame(height: 40)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    
                    let serachBar = TextField("请输入关键字", text: $searchText,  onEditingChanged: changedSearch, onCommit: fetchSearch)
                        .textFieldStyle(.plain)
                    
                    if #available(iOS 15.0, *) {
                        serachBar.submitLabel(.search)
                    } else {
                        serachBar
                    }
                    
                    if searchText.count > 0 {
                        Button(action: clearSearch) {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .padding(.trailing, 5)
                        .foregroundColor(.gray)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            if searchText.count > 0 {
                Button(action: cancelSearch) {
                    Text("取消").foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    func changedSearch(isEditing: Bool) {
        debugPrint(isEditing)
    }
    
    func fetchSearch() {
        debugPrint(searchText)
    }
    
    func clearSearch() {
        searchText = ""
    }
    
    func cancelSearch() {
        searchText = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}


struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
