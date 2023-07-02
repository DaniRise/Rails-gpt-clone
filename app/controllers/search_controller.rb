class SearchController < ApplicationController
    def index
      query = params[:q] # Obtén el término de búsqueda ingresado por el usuario desde los parámetros
  
      response = HTTParty.post(
        'https://api.openai.com/v1/engines/davinci-codex/completions',
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{ENV['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']}"
        },
        body: {
          'prompt': query,
          'max_tokens': 100,
          'n': 5
        }.to_json
      )
  
      if response['choices'].present?
        search_results = response['choices'].map { |choice| choice['text'] }
      else
        search_results = []
      end
  
      @results = search_results
    end
  
    def chat
      query = params[:q]
  
      conversation = session[:conversation] || []
      conversation << { user: "Usuario", text: query }
      session[:conversation] = conversation
  
      @conversation = conversation
  
      if query.present?
        # Llamada a la API de GPT y obtención de la respuesta
        response = OpenAI::Completion.create(
          engine: 'text-davinci-003',
          prompt: conversation.map { |message| message[:user] + ": " + message[:text] }.join("\n"),
          max_tokens: 50
        )
  
        @response = response.choices[0].text.strip if response.choices.present?
      end
  
      render 'chat'
    end
  end