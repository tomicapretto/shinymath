var mathInputBinding = new Shiny.InputBinding();

$.extend(mathInputBinding, {
  initialize: function(el) {
    el.mathFieldElement = document.getElementById(el.id);
    el.mathField = MQ.MathField(el.mathFieldElement, {
      handlers: {
        edit: function() {
          el.value = el.mathField.latex();
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
    el.value = el.mathField.latex();
    console.log('getvalue');
    return el.value;
  },

  // set values
  setValue: function(el, value) {
    el.mathField.latex(value);
    el.value = el.mathField.latex();
    console.log('setValue: ' + el.value);
  },

  // handle messages from the server
  receiveMessage: function(el, value) {
    this.setValue(el, value);
    $(el).trigger('change');
  },

  subscribe: function(el, callback) {
    $(el).on('input.mathInputBinding', function(event) {
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
  }
});

Shiny.inputBindings.register(mathInputBinding, 'shinymath.mathInput');
