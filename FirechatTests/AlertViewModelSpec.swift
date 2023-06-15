//
//  AlertViewModelSpec.swift
//  FirechatTests
//
//  Created by Glenn Ludszuweit on 15/06/2023.
//

import XCTest
import Quick
import Nimble
@testable import Firechat
import Firebase

class AlertViewModelSpec: QuickSpec {
    override func spec() {
        describe("AlertViewModel") {
            var viewModel: AlertViewModel!

            beforeEach {
                viewModel = AlertViewModel()
            }

            afterEach {
                viewModel = nil
            }

            context("setErrorValues") {
                it("should set error values correctly") {
                    let errorMessage = "An error occurred"
                    let showAlert = true

                    viewModel.setErrorValues(errorMessage: errorMessage, showAlert: showAlert)

                    expect(viewModel.title).to(equal("Error!"))
                    expect(viewModel.message).to(equal(errorMessage))
                    expect(viewModel.showAlert).to(beTrue())
                }
            }

            context("resetValues") {
                it("should reset values") {
                    viewModel.title = "Error"
                    viewModel.message = "An error occurred"
                    viewModel.showAlert = true

                    viewModel.resetValues()

                    expect(viewModel.title).to(beEmpty())
                    expect(viewModel.message).to(beEmpty())
                    expect(viewModel.showAlert).to(beFalse())
                }
            }
        }
    }
}
