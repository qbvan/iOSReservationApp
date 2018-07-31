//
//  Comments.swift
//  Emily
//
//  Created by popCorn on 2018/07/24.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit

class Comment {
    var id: String?
    var name: String?
    var job: String?
    var content: String?
    var avatar: String?
    var postDate: String?
    init(id: String?, name: String?, job: String?, content: String?, avatar: String?, postDate: String?) {
        self.id = id
        self.name = name
        self.job = job
        self.content = content
        self.avatar = avatar
        self.postDate = postDate
    }
}
