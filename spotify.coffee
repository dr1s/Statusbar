command: "sh ./scripts/shpotify.sh"

refreshFrequency: 10000

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='spotify'></div>
  """

style: """
  width: 100%
  position: absolute
  margin: 0 auto
  margin-top: 4px
  text-align: center
  font: 14px FontAwesome
  color: #a5a5a5
  font-weight: 700
"""

cutWhiteSpace: (text) ->
  text.replace /^\s+|\s+$/g, ""

update: (output, domEl) ->

   values = output.split('@')
   artist = @cutWhiteSpace(values[0])
   song = @cutWhiteSpace(values[1])
   elapsed = values[2]
   total = values[3]
   status = @cutWhiteSpace(values[4])

   if artist.length >= 30
     artist = artist.substring(0,29)
     artist = @cutWhiteSpace(artist)
     song = song + "…"

   if song.length >= 30
     song = song.substring(0,29)
     song = @cutWhiteSpace(song)
     song = song + "…"

   # Create mpdHtmlString
   mpdHtmlString = ""
   if artist or song
     mpdHtmlString = "<span class='icon switch'></span><span class='white'>  #{artist} - #{song}&nbsp</span>"

     mpdHtmlString += "<span>#{elapsed} / #{total}<span>"


   $(domEl).find('.spotify').html(mpdHtmlString)
