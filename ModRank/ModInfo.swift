//
//  ModInfo.swift
//  ModRank
//
//  Created by Nick Fisher on 11/5/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit

class ModInfo {
    
    //MARK: Properties
    var title: String
    var id: Int
    var itemTitle: String
    var comments: Int
    var subs: Int
    var favs: Int
    var views: Int
    var unsubscribes: Int
    var img: UIImage?
    var favsRank: Int
    var favsPercent: Float
    var subsRank: Int
    var subsPercent: Float
    var unsubscribesRank: Int
    var unsubscribesPercent: Float
    var viewsRank: Int
    var viewsPercent: Float
    var commentsRank: Int
    var commentsPercent: Float
    
    //MARK: Initialization
    init(title: String, id: Int, itemTitle: String, comments: Int, subs: Int,
         favs: Int, views: Int, unsubscribes: Int, img: UIImage?, favsRank: Int,
         favsPercent: Float, subsRank: Int, subsPercent: Float, unsubscribesRank: Int,
         unsubscribesPercent: Float, viewsRank: Int, viewsPercent: Float,
         commentsRank: Int, commentsPercent: Float) {
        self.title = title;
        self.id = id;
        self.itemTitle = title;
        self.comments = comments;
        self.subs = subs;
        self.favs = favs;
        self.views = views;
        self.unsubscribes = unsubscribes;
        self.img = img;
        self.favsRank = favsRank;
        self.favsPercent = favsPercent;
        self.subsRank = subsRank;
        self.subsPercent = subsPercent;
        self.unsubscribesRank = unsubscribesRank;
        self.unsubscribesPercent = unsubscribesPercent;
        self.viewsRank = viewsRank;
        self.viewsPercent = viewsPercent;
        self.commentsRank = commentsRank;
        self.commentsPercent = commentsPercent;
    }
}
