require 'json'


module TestHelpers
  include Rack::Test::Methods

  def initialize
    ENV['RACK_ENV'] = 'test'

    @plot_data =
      [
       [
        [0, 2],
        [1, 4],
        [3, 3],
        [4, 17],
       ],
       [
        [5, 20],
        [6, 34],
        [7, 33],
        [8, 33.32],
        [9, 18.43],
       ],
       [
        [1, 11],
        [2, 22],
        [3, 33],
       ],
      ]
    @table_data =
      [
       ['Color Name', 'Hex Value', 'Description', 'Notes'],
       ['red', '#FF0000', 'Often used for errors.', '---'],
       ['green', '#00FF00', 'Often used for success.',
        '<p style="color: #00FF00;">I am green.</p>'],
       ['blue', '#0000FF', '---', 'Link color'],
       ['yellow', '#FFFF00', 'Often used for warnings.'],
      ]

    @diff_a = <<-ASTRING
This is
a
simple
test.
ASTRING

    @diff_b = <<-BSTRING
This is
a not so simple
and very crazy
test.
BSTRING

    @markdown = <<-MARKDOWN
# One

Here is some code:

        def sun
          puts 'Shining
        end

## Two

This is number *two*.

## Three

This is number **three**.

MARKDOWN

    @html = <<-HTMLSTRING
<div class="row">
  <p>This is a <strong>test</strong>.</p>
</div>
HTMLSTRING

    @svg = <<-SVGSTRING
<svg width="5cm" height="4cm" version="1.1"
     xmlns="http://www.w3.org/2000/svg">
  <desc>Four separate rectangles
  </desc>
    <rect x="0.5cm" y="0.5cm" width="2cm" height="1cm"/>
    <rect x="0.5cm" y="2cm" width="1cm" height="1.5cm"/>
    <rect x="3cm" y="0.5cm" width="1.5cm" height="2cm"/>
    <rect x="3.5cm" y="3cm" width="1cm" height="0.5cm"/>

  <!-- Show outline of canvas using 'rect' element -->
  <rect x=".01cm" y=".01cm" width="4.98cm" height="3.98cm"
        fill="none" stroke="blue" stroke-width=".02cm" />

</svg>
SVGSTRING

    @image = Base64.encode64(File.read(File.expand_path('..',
      File.dirname(__FILE__)) + '/res/image.png'))

    @table_data =
      [
        ['Color Name', 'Hex Value', 'Description', 'Notes'],
        ['red', '#FF0000', 'Often used for errors.', '---'],
        ['green', '#00FF00', 'Often used for success.',
          '<p style="color: #00FF00;">I am green.</p>'],
        ['blue', '#0000FF', '---', 'Link color'],
        ['yellow', '#FFFF00', 'Often used for warnings.'],
      ]

    @haml = <<-HAML
%p
  This is a
  %strong HAML
  test.

%p
  Here is a list:
  %ul
    %li One
    %li Two
    %li Three
    %li Four
    %li Five
HAML

  end


  def app
    path = '../../../lib/fancy_print/web_app/config.ru'
    Rack::Builder.parse_file(File.expand_path(path, __FILE__)).first
  end

  # Mute ActiveRecord
  ActiveRecord::Base.logger = nil
end
