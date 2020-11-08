var mathInputBinding = new Shiny.InputBinding();

$.extend(mathInputBinding, {
  initialize: function(el) {
    mathFieldEl = document.getElementById(el.id);
    var mathField = MQ.MathField(mathFieldEl, {
      handlers: {
        edit: function() {
          el.value = mathField.latex();
        }
      }
    });
  },

  // find inputs
  find: function(scope) {
    return $(scope).find(".mathquill-editable");
  },

  getId: function(el) {
    return Shiny.InputBinding.prototype.getId.call(this, el) || el.name;
  },

  // retrieve value
  getValue: function(el) {
    return el.value;
  },

  // set values
  setValue: function(el, value) {
    el.value = value;
  },

  // handle messages from the server
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('value'))
      this.setValue(el, data.value);

    updateLabel(data.label, this._getLabelNode(el));

    if (data.hasOwnProperty('placeholder'))
      el.placeholder = data.placeholder;

    $(el).trigger('change');
  },

  subscribe: function(el, callback) {
    $(el).on('keyup.mathInputBinding input.mathInputBinding', function(event) {
      callback(true);
    });
    $(el).on('change.mathInputBinding', function(event) {
      callback(false);
    });
  },
  unsubscribe: function(el) {
    $(el).off('.mathInputBinding');
  },

  // the same as shiny's textInput
  getRatePolicy: function() {
    return {
      policy: 'debounce',
      delay: 250
    };
  },
  _getLabelNode: function(el) {
    return $(el).parent().find('label[for="' + $escape(el.id) + '"]');
  }
});

Shiny.inputBindings.register(mathInputBinding, 'shinymath.mathInput');
