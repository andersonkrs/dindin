import { Controller } from "@hotwired/stimulus";
import {
  autoUpdate,
  computePosition,
  offset,
  flip,
  shift,
} from "@floating-ui/dom";
import { animate } from "motion";
import { useClickOutside } from "stimulus-use";
import { Current } from "current.js";

export default class extends Controller {
  static targets = ["calendar", "input", "maskedInput"];

  connect() {
    useClickOutside(this);
    if (this.inputTarget.value) {
      this.#formatDateForMask(this.inputTarget.value);
    }
  }

  toggle() {
    if (this.cleanupFloating) {
      this.cleanupFloating();
    }

    this.cleanupFloating = autoUpdate(
      this.inputTarget.parentElement,
      this.calendarTarget,
      () => {
        computePosition(this.inputTarget.parentElement, this.calendarTarget, {
          placement: "bottom",
          middleware: [offset(5), flip(), shift()],
        }).then(({ x, y }) => {
          Object.assign(this.calendarTarget.style, {
            position: "absolute",
            left: `${x}px`,
            top: `${y}px`,
          });
        });
      },
    );

    const willBeOpen = this.calendarTarget.classList.contains("hidden");
    this.calendarTarget.classList.toggle("hidden", !willBeOpen);
    if (willBeOpen) {
      animate([
        [
          this.calendarTarget,
          { scale: [0.95, 1] },
          { type: "spring", stiffness: 250 },
        ],
      ]);
    }
  }

  clickOutside() {
    this.#close();
  }

  dateSelected(e) {
    this.inputTarget.value = e.target.value;
    this.#formatDateForMask(this.inputTarget.value);
    this.#close();

    this.dispatch("onchange", { target: this.inputTarget });
  }

  #close() {
    this.calendarTarget.classList.add("hidden");
  }

  #formatDateForMask(dateString) {
    if (!dateString) {
      this.maskedInputTarget.value = "";
      return;
    }

    // Assuming dateString is in "YYYY-MM-DD" format from the cally component
    const date = new Date(dateString);
    // Adjust for timezone offset to ensure the correct date is formatted
    const userTimezoneOffset = date.getTimezoneOffset() * 60000;
    const correctedDate = new Date(date.getTime() + userTimezoneOffset);

    this.maskedInputTarget.value = new Intl.DateTimeFormat(Current.locale, {
      year: "numeric",
      month: "long",
      day: "numeric",
    }).format(correctedDate);
  }
}
