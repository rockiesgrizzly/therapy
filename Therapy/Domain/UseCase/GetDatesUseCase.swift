
protocol GetDatesUseCaseProtocol {
    static var result: Result<[DateTask], Error> { get async throws }
}

struct GetDatesUseCase: GetDatesUseCaseProtocol {
    static var result: Result<[DateTask], Error> {
        get async throws {
            do {
                let retrievedDates = try await ProgressRepository.dates()
                return .success(DateTask.from(retrievedDates))
            } catch {
                return .failure(error)
            }
        }
    }
}

extension DateTask {
    static func from(_ progressDate: ProgressDate) -> Self {
        DateTask(date: progressDate.date,
                 completed: progressDate.completed,
                 breathCount: progressDate.breathCount,
                 moodChoices: progressDate.moodChoices)
    }
    
    static func from(_ progressDates: [ProgressDate]) -> [Self] {
        var result = [DateTask]()
        
        for date in progressDates {
            result.append(DateTask.from(date))
        }
        
        return result
    }
}
