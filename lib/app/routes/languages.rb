require 'app/presenters/problems'

module ExercismWeb
	module Routes
		class Languages < Core
      get '/languages/:track_id' do |track_id|
        begin
          active = ExercismWeb::Presenters::Tracks.find(track_id.to_s).active?
          exists = true
        rescue Exception => e
          Bugsnag.notify(e)
          "#{track_id} is not a language"
          exists = false
        end

				locals = {
          problems: Presenters::Special::Problems.new(track_id).track_problems,
		      language: Language.of(track_id),
          slug: track_id,
          active: active,
          exists: exists
			    }
        erb :"languages/languages", locals: locals
			end
		end
	end
end
