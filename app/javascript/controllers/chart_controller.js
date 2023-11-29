import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = [ "counterAnalytic", "counter" ]
  static values = { startDate: String, endDate: String }

  connect = () => {
    this.counterChart = new Chartkick.ColumnChart(this.counterTarget, this.counterData);
  }

  counterAnalyticTargetConnected = () => {
    if (this.counterChart) {
      this.counterChart.updateData(this.counterData);
    };
  }

  createDateRange = () => {
    const result = {};
    const currentDate = new Date(this.startDateValue);
  
    while (currentDate <= new Date(this.endDateValue)) {
      const formattedDate = currentDate.toISOString().split('T')[0];
      result[formattedDate] = 0;
      currentDate.setDate(currentDate.getDate() + 1);
    }
  
    return result;
  }

  loadCounterData = (data, target, value) => {
    if (value > 0) {
      if (!data[target.dataset.action]) {
        data[target.dataset.action] = {
          name: target.dataset.action,
          data: this.createDateRange()
        };
      }
      if (data[target.dataset.action] != null && data[target.dataset.action].data[target.dataset.created] != null) {
        data[target.dataset.action].data[target.dataset.created] += value;
      };
    }
  }

  counterData = (success) => {
    let data = {};
    this.counterAnalyticTargets.forEach(target => {
      this.loadCounterData(data, target, parseInt(target.dataset.count, 10));
    });
    success(Object.values(data));
  }
}
