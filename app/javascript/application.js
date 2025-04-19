// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import { Turbo } from "@hotwired/turbo-rails";
import { StreamActions } from "@hotwired/turbo";
import { Application, defaultSchema } from "@hotwired/stimulus";
import "./controllers";

const customSchema = {
  ...defaultSchema,
  keyMappings: { ...defaultSchema.keyMappings },
};

window.Stimulus = Application.start(document.documentElement, customSchema);
window.Stimulus.debug = true;

StreamActions.close_dialog = function() {
  this.targetElements[0].close();
};

import { config } from "current.js";
config.prefix = "config";
