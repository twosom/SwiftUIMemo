//
//  MemoListScene.swift
//  SwiftUIMemo
//
//  Created by Desire L on 2021/05/18.
//
//

import SwiftUI

struct MemoListScene: View {
    var body: some View {
        Text("Hello, world!")
                .padding()
    }
}

class MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
    }

    #if DEBUG
    @objc class func injected() {
        UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: MemoListScene())
    }
    #endif
}
