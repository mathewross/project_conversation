// src/controllers/hello_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    submitEnd(e) {
        if (e.detail.success) {
            document.getElementById('comment_message').value = '';
        }
    }
}