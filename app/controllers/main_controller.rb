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
    type = params[:type]
    prc = params[:prcCall]
    dep = params[:depCall]
    if prc.nil? then prc = "No" else prc = "Yes" end
    if dep.nil? then dep = "No" else dep = "Yes" end

    session[:value] = [callerName, method, disposition, county, item, method, type, prc, dep]
    vals = session[:value]
    puts vals
    respond_to do |format|
      if params[:submit_clicked]
        if prc == "Yes"
          CSV.open('PRCcall_stats.csv', "at") do |csv|
            csv << [callerName, method, County.find(county).name.titleize, Item.find(item).name.titleize, disposition, type]
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
