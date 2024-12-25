import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "frame"];

  connect() { }

  open() {
    this.modalTarget.showModal();
  }

  close() {
    this.modalTarget.close();
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.close();
    }
  }
}
