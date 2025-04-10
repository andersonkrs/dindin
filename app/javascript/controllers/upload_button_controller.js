import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "input"];
  static classes = ["submitting"];

  connect() {
    document.addEventListener(
      "turbo:submit-start",
      this.handleSubmitStart.bind(this),
    );
    document.addEventListener(
      "turbo:submit-end",
      this.handleSubmitEnd.bind(this),
    );
  }

  disconnect() {
    document.removeEventListener(
      "turbo:submit-start",
      this.handleSubmitStart.bind(this),
    );
    document.removeEventListener(
      "turbo:submit-end",
      this.handleSubmitEnd.bind(this),
    );
    super.disconnect();
  }

  click() {
    this.inputTarget.click();
  }

  submit() {
    this.element.requestSubmit();
  }

  handleSubmitStart(event) {
    const form = event.target;
    form.classList.add(this.submittingClass);
    this.buttonTarget.toggleAttribute("disabled");
  }

  handleSubmitEnd(event) {
    const form = event.target;
    form.classList.remove(this.submittingClass);
    this.buttonTarget.toggleAttribute("disabled");
  }
}
