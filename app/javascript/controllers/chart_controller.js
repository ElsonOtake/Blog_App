import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = [ "counterAnalytic", "counter", "lengthAnalytic", "length", "uniqueAnalytic", "unique",
                     "browserAnalytic", "devices", "platforms" ]
  static values = { startDate: String, endDate: String }

  connect = () => {
    this.counterChart = new Chartkick.ColumnChart(this.counterTarget, this.counterData);
    this.lengthChart = new Chartkick.ColumnChart(this.lengthTarget, this.lengthData);
    this.uniqueChart = new Chartkick.ColumnChart(this.uniqueTarget, this.uniqueData);
    this.devicesChart = new Chartkick.ColumnChart(this.devicesTarget, this.devicesData);
    this.platformsChart = new Chartkick.ColumnChart(this.platformsTarget, this.platformsData);
  }

  counterAnalyticTargetConnected = () => {
    if (this.counterChart) {
      this.counterChart.updateData(this.counterData);
    };
  }

  lengthAnalyticTargetConnected = () => {
    if (this.lengthChart) {
      this.lengthChart.updateData(this.lengthData);
    };
  }

  uniqueAnalyticTargetConnected = () => {
    if (this.uniqueChart) {
      this.uniqueChart.updateData(this.uniqueData);
    };
  }

  browserAnalyticTargetConnected = () => {
    if (this.devicesChart) {
      this.devicesChart.updateData(this.devicesData);
    }
    if (this.platformsChart) {
      this.platformsChart.updateData(this.platformsData);
    }
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

  loadDeviceData = (data, target) => {
    if (!data[target.dataset.device]) {
      data[target.dataset.device] = {
        name: target.dataset.device,
        data: this.createDateRange()
      };
    }
    if (data[target.dataset.device] != null && data[target.dataset.device].data[target.dataset.created] != null) {
      data[target.dataset.device].data[target.dataset.created]++;
    };
  }

  loadPlatformData = (data, target) => {
    if (!data[target.dataset.platform]) {
      data[target.dataset.platform] = {
        name: target.dataset.platform,
        data: this.createDateRange()
      };
    }
    if (data[target.dataset.platform] != null && data[target.dataset.platform].data[target.dataset.created] != null) {
      data[target.dataset.platform].data[target.dataset.created]++;
    };
  }

  counterData = (success) => {
    let data = {};
    this.counterAnalyticTargets.forEach(target => {
      this.loadCounterData(data, target, parseInt(target.dataset.count, 10));
    });
    success(Object.values(data));
  }

  lengthData = (success) => {
    let averageLength = {};
    let data = this.createDateRange();
    this.lengthAnalyticTargets.forEach(target => {
      if (!averageLength[target.dataset.created]) {
        averageLength[target.dataset.created] = { totalLength: 0, count: 0 };
      };
      averageLength[target.dataset.created].totalLength += parseInt(target.dataset.length);
      averageLength[target.dataset.created].count++;
    });
    for (const created in averageLength) {
      data[created] = averageLength[created].totalLength / averageLength[created].count;
    };
    success(data);
  }

  uniqueData = (success) => {
    let data = this.createDateRange();
    this.uniqueAnalyticTargets.forEach(target => {
      data[target.dataset.created]++;
    });
    success(data);
  }

  devicesData = (success) => {
    let data = {};
    this.browserAnalyticTargets.forEach(target => {
      this.loadDeviceData(data, target);
    });
    success(Object.values(data));
  }

  platformsData = (success) => {
    let data = {};
    this.browserAnalyticTargets.forEach(target => {
      this.loadPlatformData(data, target);
    });
    success(Object.values(data));
  }
}
