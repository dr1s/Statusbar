command: "sh ./scripts/screens"


refreshFrequency: 1000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./assets/colors.css">
    <link rel="stylesheet" type="text/css" href="./assets/fontawesome-all.min.css">
    <div class="kwmmode"></div>
  """

style: """
    -webkit-font-smoothing: antialiased
    left: 10px
    top: -2px
    //width: 850px
    width: 100%
    position: absolute
    margin: 0 auto
    margin-top: 6px
    font: 14px FontAwesome
    color: #a5a5a5
    font-weight: 700
    cursor: pointer;
    .list {
        display: inline
        text-align: center
        //padding-top: 6pxs
        padding-bottom: 2px
    }

    .inactive {
        border: 1px #a89984
    }

    .active {
        background: #a5a5a5
        color: #282a36
    }
"""

update: (output, domEl) ->
    [mode, spaces, focused...] = output.split '@'
    spaces = @visual spaces
    focused = @maxLength focused.join(""), 70

    #display the html string
    $(domEl).find('.kwmmode').html("<span class='tilingMode icon'> </span>" +
        "<span class='tilingMode white'>#{mode} " +
        "<span> |</span>" +
        spaces +
        "<span>| </span><span class='icon'></span> " +
        "<span class='white'>#{focused}</span>")

maxLength: (str, limit) ->
    if str.length > limit
        return str.substr(0, limit) + "…"
    return str

visual: (spaces) ->
    spaces = spaces.split('(')
    spaces = (x.replace /^\s+|\s+$/g, "" for x in spaces when x != '')
    return (@numbers space for space in spaces).join('')

dots: (space) ->
    # the active space has a closing paren aroound the name
    if space.slice(-1) == ")"
        return "<span class='icon screen'>&nbsp&nbsp</span>"
    else
        return "<span class='icon white screen'>&nbsp&nbsp</span>"

numbers: (space) ->
    # the active space has a closing paren aroound the name
    if space.slice(-1) == ")"
        return "<span class='list active'>&nbsp#{space.slice(-2, -1)}&nbsp</span>"
    else
        return "<span class='list inactive'>&nbsp#{space.slice(-1)}&nbsp</span>"
