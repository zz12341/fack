json.extract! question, :id, :question, :answer, :created_at, :updated_at, :status, :able_to_answer,
              :slack_markdown_answer
json.url question_url(question)
