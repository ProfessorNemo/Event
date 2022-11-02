import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

import './scripts/custom'
import './scripts/lightbox'
import './scripts/bootstrap_js_files'
import './scripts/bootstrap'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
