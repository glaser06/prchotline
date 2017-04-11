require 'csv'

class MainController < ApplicationController


  def clear_form
    session.delete(:value)
    redirect_to :back
  end

  def submit_form
    callerName = params[:callerName]
    method = params[:method]
    disposition = params[:disposition]
    county = params[:county]
    item = params[:item]

    method = params[:method]
    purpose = params[:purpose]
    type = params[:type]

    session[:value] = [callerName, method, disposition, county, item, method, purpose, type]
    vals = session[:value]

    respond_to do |format|
      if params[:submit_clicked]
        if params[:callerName] && params[:method] && params[:disposition] && params[:county]&& params[:method] && params[:purpose] && params[:type]
          CSV.open('call_stats.csv', "at") do |csv|
            csv << [callerName, method, County.find(county).name.titleize, Item.find(item).name.titleize, disposition, purpose, type]
            session.delete(:value)
            format.html { redirect_to "/", notice: "#{params[:callerName]} was added to Call Stats."}
            end
        end
        if dep == "Yes"
          CSV.open('DEPcall_stats.csv', "at") do |csv|
            csv << [callerName, method, County.find(county).name.titleize, Item.find(item).name.titleize, disposition, type]
          end
        end
        session.delete(:value)
        format.html { redirect_to "/", notice: "#{params[:callerName]} was added to Call Stats."}
      end
    end
  end

  def newCall
    if params.has_key?([:callerName])
      callerName = params[:callerName]
      session[:value] = [params[:callerName]]
    end
    @vals = session[:value]
  end


end
