//
//  Game.swift
//  TaroGold
//
//  Created by Akerke Okapova on 2/20/18.
//  Copyright © 2018 Akerke Okapova. All rights reserved.
//

import Foundation

struct Constants {
    
    static let gameSegue = "ShowGame"
    
    static let categoryCellIdentifier = "CategoryCell"
    
    static let jobsKey = "jobs"
    static let countriesKey = "countries"
    static let companiesKey = "companies"
    
    static let categories = [jobsKey, countriesKey, companiesKey]
    
    static let categoryNames = [
        jobsKey: "Моя будущая профессия",
        countriesKey: "Мое будущее место проживания",
        companiesKey: "Мое будущее место работы"
    ]
    
    static let options = [
        jobsKey: ["Web-дизайнер", "Web-программист", "Администратор базы данных", "Блогер", "Контент-менеджер", "Копирайтер", "Системный администратор", "Тестировщик", "iOS-разработчик", "Android-разработчик", "Архитектор", "Балетмейстер", "Диджей", "Композитор", "Модель", "Музыкант", "Скульптор", "Фотограф", "Хореограф", "Художник", "Ювелир"],
        countriesKey: ["Switzerland", "Canada", "Germany", "United", "Kingdom", "Japan", "Sweden", "Australia", "United", "States", "France", "Netherlands", "Denmark", "Norway", "New Zealand", "Finland", "Italy", "Singapore", "Austria", "Luxembourg", "Spain", "China", "Ireland", "South Korea", "United Arab Emirates", "Portugal"],
        companiesKey: ["Codebusters", "Google", "Microsoft", "Tesla", "SpaceX", "Booking", "Amazon", "DAR Ecosystems", "Intellection", "Spotify", "Facebook", "Netflix", "Oracle", "Apple", "Samsung", "Nvidia", "Yahoo"
        ]
    ]
    
    static let keys = ["СТАРТ", "СТОП", "ПРОДОЛЖИТЬ"]
    
    static let states = (
        reset: 0,
        running: 1,
        paused: 2
    )
}

struct Game {
    
    private var index = 0
    private var state = Constants.states.reset
    private var category = 0
    
    var currentState: Int {
        return state
    }
    
    var currentCategory: Int {
        return category
    }
    
    mutating func setCategory(index: Int){
        category = index
    }
    
    mutating func reset() {
        index = 0
        state = Constants.states.reset
    }
    
    mutating func pause() {
        state = Constants.states.paused
    }
    
    mutating func start() {
        state = Constants.states.running
    }
    
    mutating func getNextOption() -> String {
        index = (index + 1) % (Constants.options[Constants.categories[category]]?.count)!
        return Constants.options[Constants.categories[category]]![index]
    }
}
