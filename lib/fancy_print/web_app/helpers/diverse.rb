module FancyPrint
  class App
    helpers do
      # Save an `Output' object to the datastore.
      #
      # @param data [String] the data for the new output object
      # @param datatype [String] the type of the object (e.g
      #   "text"/"plot"/"html"/...); all data types supported by FancyPrint
      #    are valid
      # @param datetime [String] the creation date of the object (format:
      #   yyyy-mm-dd hh:mm:ss -TIMEZONE)
      #
      # @return nil
      def save_output(data, type, datetime, description)
        Output.create(:data => data, :datatype => type, :description =>
                      description, :datetime => datetime).save
      end

      # Render some Markdown using the `github-markup' gem
      #
      # @param markdown [String] Markdown string
      #
      # @return [String] rendered Markdown as HTML string
      def gh_markdown(markdown)
        GitHub::Markup.render('file.md', markdown)
      end
    end
  end
end
