//
//  CarouselData.swift
//  CircularCarousel Demo
//
//  Created by Piotr Suwara on 4/2/19.
//  Copyright © 2019 Piotr Suwara. All rights reserved.
//

import UIKit

struct CarouselData {
    static let buttonViewModels: [ButtonCarouselModel] = [
        ButtonCarouselModel(selectedImage: UIImage(systemName: "house.fill")!,
                                 unselectedImage: UIImage(systemName: "house")!,
                                 text: "Home"),
        ButtonCarouselModel(selectedImage: UIImage(systemName: "location.fill")!,
                                 unselectedImage: UIImage(systemName: "location")!,
                                 text: "Looking for something good?"),
        ButtonCarouselModel(selectedImage: UIImage(systemName: "plus")!,
                                 unselectedImage: UIImage(systemName: "plus")!,
                                 text: "Eating something?"),
        ButtonCarouselModel(selectedImage: UIImage(systemName: "heart.fill")!,
                                 unselectedImage: UIImage(systemName: "heart")!,
                                 text: "Your Health Data"),
        ButtonCarouselModel(selectedImage: UIImage(systemName: "person.fill")!,
                                 unselectedImage: UIImage(systemName: "person")!,
                                 text: "Your Account"),
    ]
}
