require_relative 'signature'

# Copyright (c) 2012, mixi, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#  * Neither the name of the mixi, Inc. nor the names of its contributors may
#    be used to endorse or promote products derived from this software without
#    specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#
# = app/controller/api_catalog_controller.rb - アプリのコントローラクラス
#

#
#
# = Description
# アプリケーションの画面遷移、モデルからのレスポンスを返すためのクラス
class ApiCatalogController < ApplicationController
  include MixiPlatform::App::Signature

  CONSUMER_KEY     = ENV['MIXI_CONSUMER_KEY']
  CONSUMER_SECRET  = ENV['MIXI_CONSUMER_SECRET']
  APP_URL          = ENV['MIXI_APP_URL']
  RUN_APP_URL      = ENV['MIXI_RUN_APP_URL']
  REDIRECT_URL     = "#{APP_URL}callback"
  RELAY_URL        = "#{APP_URL}mixi.html"

  # 認証後のリダイレクト先
  def callback
    if params[:error] == 'access_denied'
      render status: 403 and return
    end

    state = JSON.parse(params[:state])
    
    token = GraphApi::Client::Token.create
    token.oauth.set!(CONSUMER_KEY, CONSUMER_SECRET, REDIRECT_URL)
    token.get!(params[:code])
    render status: 500 and return if token.nil?
    people = GraphApi::Client::People.new(token)
    user_id = people.my_user_id
    render status: 500 and return if user_id.nil?
    token.user_id = user_id
    token.save!

    session = create_session_by_uid(state['session_id'], user_id)
    redirect_to main_path(device: state['device'], session_id: session.session_id)
  end

  # タイトル画面を表示
  def index
    start_page_url = URI.parse(request.url)
    verify_oauth_signature(start_page_url) do
      @sid = ActiveRecord::SessionStore.new('').generate_sid
      vid  =  params[:opensocial_viewer_id]
      if vid
        session = find_session_by_uid(vid) || create_session_by_uid(@sid, vid)
        @sid = session.session_id
        @viewer_id = session.data
      end
      @scope        = %w(mixi_apps2 r_profile).join(' ')
      @device       = params[:device]
      @consumer_key = CONSUMER_KEY
      @relay_url    = RELAY_URL
    end
  end

  # メイン表示
  def main
    @consumer_key = CONSUMER_KEY
    @app_url      = APP_URL
    @run_app_url  = RUN_APP_URL
    @relay_url    = RELAY_URL
    @device       = params[:device]
    @session_id   = params[:session_id]
  end

  # 友人一覧をjsonで返す
  def friends_lookup_table
    response = request_api_by_token(request.headers['X-SESSION-ID']) do |token|
                 people = GraphApi::Client::People.new(token)
                 people.lookup_my_friends({params: {count: 10}})
               end
    render json: response
  end

  # ユーザーデータ登録のレスポンスをjsonで返す
  def post_user_data
    response = request_api_by_token(request.headers['X-SESSION-ID']) do |token|
                 persistence = GraphApi::Client::Persistence.new(token)
                 persistence.register_user_data(
                             {params["key"] => params["value"]})
               end
    render json: response
  end

  # ユーザーデータをjsonで返す
  def get_my_user_data
    response = request_api_by_token(request.headers['X-SESSION-ID']) do |token|
                 persistence = GraphApi::Client::Persistence.new(token)
                 persistence.get_my_user_data
               end
    render json: response
  end

  private

  # session_idからuser_idを取得する
  # ---
  # *Arguments*
  #  session_id: String
  #
  # *Return*: session data(String)
  def find_data_by_session_id(sid)
    ActiveRecord::SessionStore::Session.find_by_session_id(sid).data
  end

  # session_idからuser_idを取得する
  # ---
  # *Arguments*
  #  sid: String
  #  uid: String
  #
  # *Return*: session (ActiveRecord::SessionStore::Session)
  def create_session_by_uid(sid, uid)
    session = ActiveRecord::SessionStore::Session.new({ 
                  session_id: sid,
                  data:       uid})
    session.save!
    session
  end

  # user_idからsessionを取得する
  # ---
  # *Arguments*
  #  uid: String
  #
  # *Return*: session (ActiveRecord::SessionStore::Session)
  def find_session_by_uid(uid)
    ActiveRecord::SessionStore::Session.find_by_data(
      ActiveRecord::SessionStore::Session.marshal(uid))
  end

  # session idからtokenを取得／APIでエラーが発生した時の処理を受け持つ
  # ---
  # *Arguments*
  #  session_id: String
  #  &block:     Proc
  # *Return*: response (Hash)
  def request_api_by_token(session_id, &block)
    user_id = find_data_by_session_id(session_id)
    token = GraphApi::Client::Token.find_by_user_id(user_id)
    render status: 500 and return if token.nil?
    token.oauth.set!(CONSUMER_KEY, CONSUMER_SECRET, REDIRECT_URL)

    block.call token
  end
end
