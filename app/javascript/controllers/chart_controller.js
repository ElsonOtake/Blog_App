import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = [ "counterAnalytic" ]

  counterAnalyticTargetConnected = () => {
    console.log("Counter analytics connected");
  }
}
