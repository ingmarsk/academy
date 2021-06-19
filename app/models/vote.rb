class Vote < ApplicationRecord
  belongs_to :voteable, polymorphic: true
  belongs_to :user
  # Cada voto genera un record en la db. Si pusieramos una columna 'vote_count'
  # para User y Course seria un campo duplicado ademas que no nos daria ninguna
  # info util cómo que usuarios dan votos a qué cursos/teachers.
  # El record Vote sirve para poder registrar y analizar las preferencias de los usuarios,
  # por ejemplo si tienen muchos votos de un curso de una categoria en concreto
  # se puede personalizar los emails con esa preferencia.
  # Get votes given by a user => Vote.where(user: user)
  # Get votes given to a user => user.votes
  # Get votes given to a course => course.votes

  # A user can only vote himself, another teacher or a course just once
  validates_uniqueness_of :user_id, scope: %i(voteable_id voteable_type)
end
