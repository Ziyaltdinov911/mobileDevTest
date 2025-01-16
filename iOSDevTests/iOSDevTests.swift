//
//  iOSDevTests.swift
//  iOSDevTests
//
//  Created by KAMA . on 16.01.2025.
//

import XCTest
@testable import iOSDev // Подключение основного модуля проекта для тестирования

final class iOSDevTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Вызывается перед запуском каждого теста.
        // Используйте для инициализации объектов или ресурсов, которые будут использоваться в тестах.
    }
    
    override func tearDownWithError() throws {
        // Вызывается после завершения каждого теста.
        // Используйте для освобождения ресурсов или сброса состояния.
    }
    
    func testCharacterModelDecoding() throws {
        let json = """
        {
            "id": 1,
            "name": "Rick Sanchez",
            "status": "Alive",
            "species": "Human",
            "gender": "Male",
            "location": {
                "name": "Earth"
            }
        }
        """
        let jsonData = Data(json.utf8)
        let decoder = JSONDecoder()
        
        do {
            let character = try decoder.decode(Character.self, from: jsonData)
            XCTAssertEqual(character.name, "Rick Sanchez")
            XCTAssertEqual(character.status, "Alive")
            XCTAssertEqual(character.location.name, "Earth")
        } catch {
            XCTFail("Декодирование модели Character завершилось с ошибкой: \(error)")
        }
    }
    
}
