import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static classes = ["toggle"];
  static targets = ["toggle", "frequency", "endCondition", "count"];

  endConditionChanged() {
    this.#toggleCountVisibility();

    if (this.isRecurrentForever) {
      this.countTarget.value = null;
    } else {
      this.countTarget.value = 10;
    }
  }

  toggle() {
    const willBeRecurrent = !this.element.classList.contains(this.toggleClass);
    this.element.classList.toggle(this.toggleClass, willBeRecurrent);
    this.toggleTarget.value = willBeRecurrent;

    this.dispatch("toggle", { detail: { recurrent: willBeRecurrent } });
  }

  get #isForever() {
    this.endConditionTarget.value == "forever";
  }

  #toggleCountVisibility() {
    this.countTarget.parentElement.classList.toggle(
      "invisible",
      this.#isForever,
    );
  }
}
