//
// Created by Desire L on 2021/05/18.
//

import SwiftUI

struct DetailScene: View {
    @ObservedObject
    var memo: Memo

    @EnvironmentObject
    var store: MemoStore

    @EnvironmentObject
    var formatter: DateFormatter

    @State
    private var showEditSheet = false

    @State
    private var showDeleteAlert = false

    @Environment(\.presentationMode)
    var presentationMode


    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(memo.content)
                                .padding()
                        Spacer()
                    }
                    Text("\(memo.insertDate, formatter: formatter)")
                            .padding()
                            .font(.footnote)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                }
            }


            HStack {
                Button(action: {
                    self.showDeleteAlert.toggle()
                }, label: {
                    Image(systemName: "trash")
                            .foregroundColor(Color(UIColor.systemRed))
                }).padding()
                        .alert(isPresented: self.$showDeleteAlert, content: {
                            Alert(title: Text("삭제 확인"),
                                    message: Text("메모를 삭제하시겠습니까?"),
                                    primaryButton: .destructive(Text("삭제"),
                                            action: {
                                                store.delete(memo: memo)
                                                presentationMode.wrappedValue.dismiss()
                                            }),
                                    secondaryButton: .cancel())
                        })

                Spacer()

                Button(action: {
                    self.showEditSheet.toggle()
                }, label: {
                    Image(systemName: "square.and.pencil")
                }).padding()
                        .sheet(isPresented: $showEditSheet, content: {
                            ComposeScene(showComposer: self.$showEditSheet, memo: self.memo)
                                    .environmentObject(store)
                                    .environmentObject(KeyboardObserver())
                        })
            }.padding(.leading)
                    .padding(.trailing)
        }.navigationBarTitle("메모 보기")
    }
}


struct DetailScene_Previews: PreviewProvider {
    static var previews: some View {
        DetailScene(memo: Memo(content: "SwiftUI"))
                .environmentObject(MemoStore())
                .environmentObject(DateFormatter.memoDateFormatter)
    }
}
