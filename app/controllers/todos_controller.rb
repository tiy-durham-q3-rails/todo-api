class TodosController < ApplicationController
  before_action :find_todo, except: [:index, :create]

  respond_to :json

  def index
    @todos = Todo.all
    render :json => @todos
  end

  def show
    todo_hash = {id: @todo.id, title: @todo.title, completed: @todo.completed, order: @todo.order}
    render :json => todo_hash
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      todo_hash = {id: @todo.id, title: @todo.title, completed: @todo.completed, order: @todo.order}
      render :json => todo_hash, :status => :created
    else
      # return some status
    end
  end

  def update
    if @todo.update(todo_params)
      todo_hash = {id: @todo.id, title: @todo.title, completed: @todo.completed, order: @todo.order}
      render :json => todo_hash
    else
      # return some status
    end
  end

  def destroy
    if @todo.destroy
      render nothing: true, status: :no_content
    else
      # return ???
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :completed, :order)
  end

  def find_todo
    @todo = Todo.find(params[:id])
  end
end
