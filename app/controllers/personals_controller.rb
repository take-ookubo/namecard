class PersonalsController < ApplicationController
  before_action :set_personal, only: [:show, :edit, :update, :destroy]

  # GET /personals/search
  def search
    @keyword = params[:keyword]
    keyword  = '%' + @keyword + '%'

    personal = Personal.arel_table
    div = Division.arel_table
    company = Company.arel_table

    # TODO:sequeel で作り直し
    # WHERE (("personals"."name" LIKE '%keyword%' OR
    # ("personals"."name_kana" LIKE '%keyword%' OR
    # ("divisions"."name" LIKE '%keyword%' OR
    # ("divisions"."name_kana" LIKE '%keyword%' OR
    # ("companies"."name" LIKE '%keyword%' OR
    # "companies"."name_kana" LIKE '%keyword%'))))))
    @personals = Personal.joins(:division => :company).where(
      personal[:name].matches(keyword).or(
        personal[:name_kana].matches(keyword).or(
          div[:name].matches(keyword).or(
            div[:name_kana].matches(keyword).or(
              company[:name].matches(keyword).or(
                company[:name_kana].matches(keyword)
              )
            )
          )
        )
      )
    )
    p @personals.to_sql
    render :action => :index
  end

  # GET /personals
  # GET /personals.json
  def index
    @keyword = nil
    @personals = Personal.all
  end

  # GET /personals/1
  # GET /personals/1.json
  def show
  end

  # GET /personals/new
  def new
    @personal = Personal.new
    @personal.division = Division.new
    @personal.division.company = Company.new
  end

  # GET /personals/1/edit
  def edit
  end

  # POST /personals
  # POST /personals.json
  def create

    @company = Company.new(company_params)
    @company.save
    @division = Division.new(division_params)
    @division.company = @company
    @division.save
    @personal = Personal.new(personal_params)
    @personal.division = @division

    respond_to do |format|
      if @personal.save
        format.html { redirect_to @personal, notice: '新規作成しました。' }
        format.json { render action: 'show', status: :created, location: @personal }
      else
        format.html { render action: 'new' }
        format.json { render json: @personal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personals/1
  # PATCH/PUT /personals/1.json
  def update
    res = false
    ActiveRecord::Base.transaction do

      raise StandardError::ArgumentError unless @company.update(company_params)

      raise StandardError::ArgumentError unless @division.update(division_params)

      raise StandardError::ArgumentError unless @personal.update(personal_params)

      res = true
    end
  rescue => e
      logger.debug e
  ensure
    respond_to do |format|
      if res
        format.html { redirect_to @personal, notice: '更新しました。' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @personal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personals/1
  # DELETE /personals/1.json
  def destroy
    @personal.destroy
    respond_to do |format|
      format.html { redirect_to personals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal
      @personal = Personal.find(params[:id])
      @division = @personal.division
      @company = @division.company
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_params
      params.require(:personal).permit(:division_id, :name, :name_kana, :title, :mail, :memo)
    end

  def division_params
    params.require(:division).permit(:name, :name_kana, :zip, :address, :tel, :fax, :url )
  end

  def company_params
    params.require(:company).permit(:name, :name_kana, :zip, :address, :tel, :fax, :url )
  end
end
