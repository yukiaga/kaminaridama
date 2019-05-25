class Api::V1::LightningsController < ApplicationController

  def health_check
    render status: 200, json: { status: 200, message: "Success health_check!!" }
  end

  def year
    @lightning = Lightning.where(year: params[:year]).page(params[:page] ||= 1).per(params[:per_page] ||= 30).order(flash_time: "DESC")

    render 'lightning', formats: 'json', handlers: 'jbuilder'
  end

  def month
    @lightning = Lightning.where(year: params[:year], month: params[:month]).page(params[:page] ||= 1).per(params[:per_page] ||= 30).order(flash_time: "DESC")

    render 'lightning', formats: 'json', handlers: 'jbuilder'
  end

  def day
    @lightning = Lightning.where(year: params[:year], month: params[:month], day: params[:day]).page(params[:page] ||= 1).per(params[:per_page] ||= 30).order(flash_time: "DESC")

    render 'lightning', formats: 'json', handlers: 'jbuilder'
  end

  def hour
    @lightning = Lightning.where(year: params[:year], month: params[:month], day: params[:day], hour: params[:hour]).page(params[:page] ||= 1).per(params[:per_page] ||= 30).order(flash_time: "DESC")

    render 'lightning', formats: 'json', handlers: 'jbuilder'
  end

  def minute
    @lightning = Lightning.where(year: params[:year], month: params[:month], day: params[:day], hour: params[:hour], minute: params[:minute]).page(params[:page] ||= 1).per(params[:per_page] ||= 30).order(flash_time: "DESC")

    render 'lightning', formats: 'json', handlers: 'jbuilder'
  end

  def second
    @lightning = Lightning.where(year: params[:year], month: params[:month], day: params[:day], hour: params[:hour], minute: params[:minute], second: params[:second]).page(params[:page] ||= 1).per(params[:per_page] ||= 30).order(flash_time: "DESC")

    render 'lightning', formats: 'json', handlers: 'jbuilder'
  end

  def decimal_number
    @lightning = Lightning.where(year: params[:year], month: params[:month], day: params[:day], hour: params[:hour], minute: params[:minute], second: params[:second], decimal_number: params[:decimal_number]).page(params[:page] ||= 1).per(params[:per_page] ||= 30).order(flash_time: "DESC")

    render 'lightning', formats: 'json', handlers: 'jbuilder'
  end

end
