import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stimulus"
export default class extends Controller {
  static values = { post: { type: String, default: "" }, member: { type: String, default: "" }}

  add_like() {
    const configObj = {
      method: 'POST',
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }
    };
    let user_id = this.memberValue;
    let post_id = this.postValue;
    fetch(`../../../api/v1/members/${user_id}/posts/${post_id}/likes`, configObj);
  }

  remove_like() {
    const configObj = {
      method: 'DELETE',
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }
    };
    let user_id = this.memberValue;
    let post_id = this.postValue;
    fetch(`../../../api/v1/members/${user_id}/posts/${post_id}/likes/0`, configObj);
  }

  toggle_likes() {
    const icon = document.getElementById(`like_icon_${this.postValue}`);
    const counter = document.getElementById(`likes_counter_${this.postValue}`);
    if (icon.classList[0] == "fa-regular" || icon.classList[1] == "fa-regular") {
      icon.classList.add("fa-solid");
      icon.classList.remove("fa-regular");
      this.add_like();
      counter.innerHTML = parseInt(counter.innerHTML) + 1;
    } else {
      icon.classList.add("fa-regular");
      icon.classList.remove("fa-solid");
      this.remove_like();
      counter.innerHTML = parseInt(counter.innerHTML) - 1;
    }
  }

  toggle_comments() {
    const icon = document.getElementById(`comment_icon_${this.postValue}`);
    const comments = document.getElementById(`comments_${this.postValue}`);
    if (icon.classList[0] == "fa-regular" || icon.classList[1] == "fa-regular") {
      icon.classList.add("fa-solid");
      icon.classList.remove("fa-regular");
      comments.classList.remove("hidden_comments");
    } else {
      icon.classList.add("fa-regular");
      icon.classList.remove("fa-solid");
      comments.classList.add("hidden_comments");
    }
  }

  add_comment() {
    const counter = document.getElementById(`comments_counter_${this.postValue}`);

    if (this.element.parentElement.elements[1].value != "") {
      counter.innerHTML = parseInt(counter.innerHTML) + 1;
    }
  }
}