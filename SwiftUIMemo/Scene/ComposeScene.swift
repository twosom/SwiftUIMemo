//
// Created by Desire L on 2021/05/18.
//

import SwiftUI

struct ComposeScene: View {

    @EnvironmentObject
    var keyboard: KeyboardObserver

    @EnvironmentObject
    var store: MemoStore

    @State
    private var content: String = ""

    @Binding
    var showComposer: Bool

    var memo: Memo? = nil

    var body: some View {
        NavigationView {
            VStack {
                TextView(text: $content)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom, 0)
                        .animation(.easeInOut(duration: keyboard.context.animationDuration))
//                        .background(Color.yellow)

            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationBarTitle(memo != nil ? "메모 편집" : "새 메모", displayMode: .inline)
                    .navigationBarItems(
                            leading: DismissButton(show: $showComposer),
                            trailing: SaveButton(show: $showComposer, content: $content, memo: memo))
        }.onAppear {
            self.content = memo?.content ?? ""
        }
    }
}

fileprivate struct SaveButton: View {

    @Binding
    var show: Bool

    @EnvironmentObject
    var store: MemoStore

    @Binding
    var content: String

    var memo: Memo? = nil


    var body: some View {
        Button(action: {
            if let memo = memo {
                store.update(memo: memo, content: content)
            } else {
                store.insert(memo: content)
            }

            self.show = false
        }, label: {
            Text("저장")
        })
    }
}

fileprivate struct DismissButton: View {

    @Binding
    var show: Bool

    var body: some View {
        Button(action: {
            self.show = false
        }, label: {
            Text("취소")
        })
    }
}

struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene(showComposer: .constant(false))
                .environmentObject(MemoStore())
                .environmentObject(KeyboardObserver())
    }


}


