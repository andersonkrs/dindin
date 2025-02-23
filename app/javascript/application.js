// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import { Application, defaultSchema } from "@hotwired/stimulus";
import "./controllers";

const customSchema = {
  ...defaultSchema,
  keyMappings: { ...defaultSchema.keyMappings },
};

window.Stimulus = Application.start(document.documentElement, customSchema);
window.Stimulus.debug = true;

import { config } from "current.js";
config.prefix = "config";
