import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  change() {
    const icon = document.getElementById("likes_counter");
    icon.className = icon.className == "bi-star" ? "bi-star-fill" : "bi-star";
  }
}
