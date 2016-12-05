class FiguresController < ApplicationController
	get '/' do 
		redirect '/figures'
	end

	get '/figures' do
		@figures = Figure.all 
		erb :'figures/index'
	end

	get '/figures/new' do
		erb :"figures/new"
	end


	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		erb :'figures/show'
	end

	
	post '/figures' do 
		@figure = Figure.create(params[:figure])

		unless params[:title][:name].empty?
			@figure.titles << Title.find_or_create_by(params[:title])
		end

		unless params[:landmark][:name].empty?
			@figure.landmarks << Landmark.find_or_create_by(params[:landmark])
		end
		@figure.save

		redirect to "/figures/#{@figure.id}"
	end

	get 'figures/:id/edit' do
		@figure = Figure.find(params[:id])
		erb :'figures/edit'
	end

	post '/figures/:id' do
	  @figure = Figure.find(params[:id])
      @figure.update(params[:figure])

      if !params[:landmark][:name].empty?
        @figure.landmarks << Landmark.create(params[:landmark])
      end

      if !params[:title][:name].empty?
        @figure.titles << Title.create(params[:title])
      end

      @figure.save
      redirect to "/figures/#{@figure.id}"
	end
end