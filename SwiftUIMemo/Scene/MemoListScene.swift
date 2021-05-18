//
//  MemoListScene.swift
//  SwiftUIMemo
//
//  Created by Desire L on 2021/05/18.
//
//

import SwiftUI

struct MemoListScene: View {
    @EnvironmentObject var store: MemoStore
    @EnvironmentObject var formatter: DateFormatter

    @State
    var showComposer: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(store.list) { memo in
                    NavigationLink(destination: DetailScene(memo: memo), label: {
                        MemoCell(memo: memo)
                    })
                }.onDelete(perform: store.delete)

            }.navigationBarTitle("내 메모")
                    .navigationBarItems(trailing: ModalButton(show: $showComposer))
                    .sheet(isPresented: $showComposer, content: {
                        ComposeScene(showComposer: $showComposer)
                                .environmentObject(store)
                                .environmentObject(KeyboardObserver())
                    })
        }
    }
}

fileprivate struct ModalButton: View {
    @Binding
    var show: Bool

    var body: some View {
        Button(action: {
            self.show = true
        }, label: {
            Image(systemName: "plus")
        })
    }
}


class MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
                .environmentObject(MemoStore())
                .environmentObject(DateFormatter.memoDateFormatter)
    }

    #if DEBUG
    @objc class func injected() {
        UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: MemoListScene())
    }
    #endif
}
