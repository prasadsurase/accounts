@RecordForm = React.createClass
  getInitialState: ->
    date: ''
    title: ''
    amount: ''

  handleChange: (e) ->
    name = e.target.name
    @setState "#{name}": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/records', { record: @state }, (responce) =>
      @props.handleNewRecord responce
      @setState @getInitialState()
    , 'JSON'

  valid: ->
    @state.date && @state.title && @state.amount

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          name: 'date'
          placeholder: 'Date'
          value: @state.date
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          name: 'title'
          placeholder: 'Title'
          value: @state.title
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          name: 'amount'
          placeholder: 'Amount'
          value: @state.amount
          onChange: @handleChange
      React.DOM.button
        className: 'btn btn-primary'
        type: 'submit'
        disabled: !@valid()
        'Create Record'

