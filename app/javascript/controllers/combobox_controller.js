import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "menu"];

  connect() {
    console.log("combo connected", this.menuTarget);
  }
}
