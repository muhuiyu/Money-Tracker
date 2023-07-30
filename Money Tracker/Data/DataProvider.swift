//
//  DataProvider.swift
//  Get Fit
//
//  Created by Mu Yu on 3/29/23.
//

import Foundation

//protocol DataProvider {
//    // Set up
//    func setup()
//
//    // User
//    func getUserPreference(for userID: UserID) -> UserPreference?
//    func getUserProfile(for userID: UserID) -> User?
//
//    // Food, Database
//    func getCustomizedMeals(for userID: UserID) -> [CustomizedMeal]
//    func getDailyMealLog(for userID: UserID, on date: Date) -> DailyMealLog?
//    func updateMealLog(for userID: UserID, to value: MealLog) -> VoidResult
//    func removeMealLog(for userID: UserID) -> VoidResult
//    func getPreviousFoodLogs(for userID: UserID) -> [FoodID: FoodLog]
//
//    // Search
//    func searchFoods(contain keyword: String) -> [FoodID]
//
//    // Workout
//    func getWorkoutRoutines(for userID: UserID) -> [WorkoutRoutine]
//    func removeWorkoutRoutine(for userID: UserID, at workoutRoutine: WorkoutRoutineID) -> VoidResult
//    func getAllWorkoutSessions(for userID: UserID) -> [WorkoutSession]
//    func getWorkoutSessions(for userID: UserID, from startDate: Date, to endDate: Date) -> [WorkoutSession]
//    func getWorkoutSessions(for userID: UserID, on date: YearMonthDay) -> [WorkoutSession]
//    func removeWorkoutSession(for userID: UserID, at sessionID: WorkoutSessionID) -> VoidResult
//    func updateWorkoutSession(for userID: UserID, _ session: WorkoutSession) -> VoidResult
//
//    // Journal
//    func getJournal(for userID: UserID, on date: Date) -> [Journal]
//}
