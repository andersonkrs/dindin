import { Controller } from "@hotwired/stimulus";
import {
  animate,
  press,
} from "https://cdn.jsdelivr.net/npm/motion@12.6.0/+esm";

export default class extends Controller {
  static targets = ["trigger", "source"];

  connect() {
    if (this.triggerTarget) {
      press(this.triggerTarget, (element) => {
        this.copy();

        animate(element, { scale: 1.3 }, { type: "spring", stiffness: 1000 });

        return () =>
          animate(element, { scale: 1 }, { type: "spring", stiffness: 500 });
      });
    }
  }

  selectText() {
    this.sourceTarget.select();
  }

  copy() {
    const content = this.sourceTarget.value;
    navigator.clipboard.writeText(content);
  }
}
